// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function receive_packet(buffer, socket){
	msgid = buffer_read(buffer, buffer_u8);
	switch msgid
	{
		case network.player_establish:
			var player_username = buffer_read(buffer, buffer_string)
			network_player_join(player_username)
			break;
		
		case network.move:
			var move_x = buffer_read(buffer, buffer_u16)
			var move_y = buffer_read(buffer, buffer_u16)
			
			//update server representation
			var player_instance = ds_map_find_value(socket_to_instanceid, socket)
			player_instance.x = move_x
			player_instance.y = move_y
			
			//notify all players that a player has moved
			for (i = 0; i < ds_list_size(socket_list); i++)
			{
				var curr_socket = ds_list_find_value(socket_list, i)
				if (curr_socket != socket)
				{
					buffer_seek(server_buffer, buffer_seek_start, 0);
					buffer_write(server_buffer, buffer_u8, network.move);
					buffer_write(server_buffer, buffer_u8, socket);
					buffer_write(server_buffer, buffer_u16, move_x);
					buffer_write(server_buffer, buffer_u16, move_y);
					network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
				}
			}
			
			//Update the position of the moving player
			/*buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.move);
			buffer_write(server_buffer, buffer_u8, socket);/////
			buffer_write(server_buffer, buffer_u16, move_x);
			buffer_write(server_buffer, buffer_u16, move_y);
			network_send_packet(socket, server_buffer, buffer_tell(server_buffer))*/
			
			break;
	}
}