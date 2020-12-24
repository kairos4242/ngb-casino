// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function received_packet(buffer){
	msgid = buffer_read(buffer, buffer_u8)
	
	switch (msgid)
	{
		case network.player_establish:
			var socket_read = buffer_read(buffer, buffer_u8);
			global.my_socket = socket_read
			
			buffer_seek(client_buffer, buffer_seek_start, 0)
			buffer_write(client_buffer, buffer_u8, network.player_establish)
			buffer_write(client_buffer, buffer_string, obj_GameController.username)
			network_send_packet(client, client_buffer, buffer_tell(client_buffer));
			break;
		
		case network.add_object:
			var name_of_object = buffer_read(buffer, buffer_string)
			show_debug_message("Name of object: " + name_of_object)
			var wall_x = buffer_read(buffer, buffer_u16)
			var wall_y = buffer_read(buffer, buffer_u16)
			instance_create_layer(wall_x, wall_y, "Instances", asset_get_index(name_of_object))
			break;
		
		case network.player_connect:
			var socket_read = buffer_read(buffer, buffer_u8);
			var player_x = buffer_read(buffer, buffer_u16);
			var player_y = buffer_read(buffer, buffer_u16);
			var player_username = buffer_read(buffer, buffer_string)
			
			var player_instance = instance_create_depth(player_x, player_y, depth, obj_Player)
			player_instance.socket = socket_read
			player_instance.username = player_username
			
			ds_map_add(socket_to_instanceid, socket_read, player_instance)
			break;
			
		case network.player_joined:
			var socket_read = buffer_read(buffer, buffer_u8);
			var player_x = buffer_read(buffer, buffer_u16);
			var player_y = buffer_read(buffer, buffer_u16);
			var player_username = buffer_read(buffer, buffer_string);
			
			var slave_instance = instance_create_depth(player_x, player_y, depth, obj_Slave)
			slave_instance.socket = socket_read
			slave_instance.username = player_username
			
			ds_map_add(socket_to_instanceid, socket_read, slave_instance)
			break;
			
		case network.player_disconnect:
			var curr_socket = buffer_read(buffer, buffer_u8);
			var curr_player = ds_map_find_value(socket_to_instanceid, curr_socket);
			
			//player has left so remove their instance and remove them from map
			with (curr_player)
			{
				instance_destroy()
			}
			ds_map_delete(socket_to_instanceid, curr_socket);
			
			break;
		
		case network.move:
			var curr_socket = buffer_read(buffer, buffer_u8)
			var move_x = buffer_read(buffer, buffer_u16)
			var move_y = buffer_read(buffer, buffer_u16)
			
			var curr_player = ds_map_find_value(socket_to_instanceid, curr_socket)
			
			if is_undefined(curr_player) break;
			curr_player.x = move_x
			curr_player.y = move_y
			break;
			
		case network.cast_spell:
			//have the player who cast the spell cast a simulated version of said spell
			var curr_socket = buffer_read(buffer, buffer_u8)
			var spell_to_cast = buffer_read(buffer, buffer_string)
			var curr_player = ds_map_find_value(socket_to_instanceid, curr_socket)
			script_execute(spell_to_cast, curr_player, -1)
			
			
	}	
}