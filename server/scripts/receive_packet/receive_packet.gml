// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function receive_packet(buffer, socket){
	msgid = buffer_read(buffer, buffer_u8);
	switch msgid
	{
		case network.player_establish:
			//player join
			var player_username = buffer_read(buffer, buffer_string)
			var player_class = buffer_read(buffer, buffer_u8)
			network_player_join(player_username)
			//set all class properties for local
			var player_instance = ds_map_find_value(socket_to_instanceid, socket)
			player_instance.hp = classes[player_class][1]
			player_instance.max_hp = classes[player_class][1]
			player_instance.max_mana = classes[player_class][2]
			player_instance.mana = classes[player_class][2]
			player_instance.mana_regen = classes[player_class][3]
			player_instance.walk_speed = classes[player_class][4]
			player_instance.jumps = classes[player_class][5]
			player_instance.max_jumps = classes[player_class][5]
			
			//set all class properties for network
			network_modify_player_property(socket, "hp", "u16", classes[player_class][1])
			network_modify_player_property(socket, "max_hp", "u16", classes[player_class][1])
			network_modify_player_property(socket, "max_mana", "u16", classes[player_class][2])
			network_modify_player_property(socket, "mana", "u16", classes[player_class][2])
			network_modify_player_property(socket, "mana_regen", "u16", classes[player_class][3])
			network_modify_player_property(socket, "walk_speed", "u16", classes[player_class][4])
			network_modify_player_property(socket, "jumps", "u16", classes[player_class][5])
			network_modify_player_property(socket, "max_jumps", "u16", classes[player_class][5])
			show_debug_message("Num walls: " + string(instance_number(obj_Wall)))
			//send player all walls that are in the level
			for (i = 0; i < instance_number(obj_Wall); i++)
			{
				var current_object = instance_find(obj_Wall, i)
				buffer_seek(server_buffer, buffer_seek_start, 0)
				buffer_write(server_buffer, buffer_u8, network.add_object)
				buffer_write(server_buffer, buffer_string, "obj_Wall")
				buffer_write(server_buffer, buffer_u16, current_object.network_id)
				buffer_write(server_buffer, buffer_u16, current_object.x)
				buffer_write(server_buffer, buffer_u16, current_object.y)
				network_send_packet(socket, server_buffer, buffer_tell(server_buffer))
			}
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
		case network.cast_spell:
			var spell_to_cast = buffer_read(buffer, buffer_string)//should be the script name as a string
			var casting_player = ds_map_find_value(socket_to_instanceid, socket)
			var target_x = buffer_read(buffer, buffer_u16)
			var target_y = buffer_read(buffer, buffer_u16)
			var spell_to_cast_id = asset_get_index(spell_to_cast)
			//update server representation, script will handle updating player representations
			script_execute(spell_to_cast_id, casting_player, [target_x, target_y])
			
			
			
			break;
			
		case network.request_objects:
			//send requesting client all level objects
			for (i = 0; i < instance_number(obj_Wall); i++)
			{
				var current_object = instance_find(obj_Wall, i)
				buffer_seek(server_buffer, buffer_seek_start, 0)
				buffer_write(server_buffer, buffer_u8, network.add_object)
				buffer_write(server_buffer, buffer_string, "obj_Wall")
				buffer_write(server_buffer, buffer_u16, current_object.network_id)
				buffer_write(server_buffer, buffer_u16, current_object.x)
				buffer_write(server_buffer, buffer_u16, current_object.y)
				network_send_packet(socket, server_buffer, buffer_tell(server_buffer))
			}
			break;
			
		case network.poker_bet:
			//get amount to bet
			var bet_amount = buffer_read(buffer, buffer_u16)
			
			//give it to poker controller and decrease the alarm to 0 as there is no need to wait further
			obj_PokerController.current_bet = bet_amount
			obj_PokerController.alarm[0] = 1
			
	}
}