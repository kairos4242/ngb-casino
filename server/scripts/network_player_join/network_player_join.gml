// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function network_player_join(username){
	
	//create obj_Player in server
	var player_instance = instance_create_depth(player_spawn_x, player_spawn_y, 0, obj_Player)
	player_instance.username = username
	ds_map_add(socket_to_instanceid, socket, player_instance);//map player instance to socket
	
	//Create obj_Player for connecting client
	buffer_seek(server_buffer, buffer_seek_start, 0);
	buffer_write(server_buffer, buffer_u8, network.player_connect);
	buffer_write(server_buffer, buffer_u8, socket);
	buffer_write(server_buffer, buffer_u16, player_instance.x);
	buffer_write(server_buffer, buffer_u16, player_instance.y);
	buffer_write(server_buffer, buffer_string, player_instance.username);
	network_send_packet(socket, server_buffer, buffer_tell(server_buffer));
		
	//add all already connected players to the joining client
	for (i = 0; i < ds_list_size(socket_list); i++)
	{
		var curr_socket = ds_list_find_value(socket_list, i);
		if curr_socket != socket
		{
			var slave_instance = ds_map_find_value(socket_to_instanceid, curr_socket);
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.player_joined);
			buffer_write(server_buffer, buffer_u8, curr_socket);
			buffer_write(server_buffer, buffer_u16, slave_instance.x);
			buffer_write(server_buffer, buffer_u16, slave_instance.y);
			buffer_write(server_buffer, buffer_string, slave_instance.username);
			network_send_packet(socket, server_buffer, buffer_tell(server_buffer));
		}
	}
		
	//add the joining client to all other clients
	for (i = 0; i < ds_list_size(socket_list); i++)
	{
		var curr_socket = ds_list_find_value(socket_list, i);
		if curr_socket != socket
		{
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.player_joined);
			buffer_write(server_buffer, buffer_u8, socket);
			buffer_write(server_buffer, buffer_u16, player_instance.x);
			buffer_write(server_buffer, buffer_u16, player_instance.y);
			buffer_write(server_buffer, buffer_string, player_instance.username);
			network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer));
		}
	}
}