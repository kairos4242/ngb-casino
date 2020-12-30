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
			
			break;
			
		case network.add_object:
			//grab the object name, network id x, and y
			var object_to_add = buffer_read(buffer, buffer_string)
			var object_network_id = buffer_read(buffer, buffer_u16)
			var object_x = buffer_read(buffer, buffer_u16)
			var object_y = buffer_read(buffer, buffer_u16)
			
			//create the object at the coordinates specified
			var asset_to_add = asset_get_index(object_to_add)
			var created_object = instance_create_layer(object_x, object_y, "Instances", asset_to_add)
			created_object.network_id = object_network_id
			//add to network id map
			ds_map_add(network_id_to_instanceid, object_network_id, created_object.id)
			
			break;
			
		case network.modify_property:
			//grab the object network id, what to change, and the value to set it too
			var object_network_id = buffer_read(buffer, buffer_u16)
			var property_to_modify = buffer_read(buffer, buffer_string)
			var type_to_write = buffer_read(buffer, buffer_string)
			//read a diff data type depending on which type the data is
			switch type_to_write {
				default: break;
				case "u16": var value_to_set = buffer_read(buffer, buffer_u16)
				break;
				case "s16": var value_to_set = buffer_read(buffer, buffer_s16)
				break;
				case "string": var value_to_set = buffer_read(buffer, buffer_string)
				break;
				case "f16": var value_to_set = buffer_read(buffer, buffer_f16)
				break;
			}
			//more data types can be added as the need arises
			
			var object_instance_id = ds_map_find_value(network_id_to_instanceid, object_network_id)
			variable_instance_set(object_instance_id, property_to_modify, value_to_set)
			
			break;
		
		case network.modify_player_property:
			//grab the socket, what property to change, and the value to set it to
			var socket_id = buffer_read(buffer, buffer_u16)
			var property_to_modify = buffer_read(buffer, buffer_string)
			var type_to_write = buffer_read(buffer, buffer_string)
			//read a diff data type depending on which type the data is
			switch type_to_write {
				default: break;
				case "u16": var value_to_set = buffer_read(buffer, buffer_u16)
				break;
				case "s16": var value_to_set = buffer_read(buffer, buffer_s16)
				break;
				case "string": var value_to_set = buffer_read(buffer, buffer_string)
				break;
				case "f16": var value_to_set = buffer_read(buffer, buffer_f16)
				break;
			}
			//^maybe this will need to be a switch eventually based on what object property we are setting
			//like for instance you can't set name in a u16
			//either that or have network.modify_property_string, network.modify_property_u16, etc etc
			//for now just reading unsigned 16 bit is good though
			
			var object_instance_id = ds_map_find_value(socket_to_instanceid, socket_id)
			variable_instance_set(object_instance_id, property_to_modify, value_to_set)
			
			break;
		
		case network.destroy_object:
			//grab the object network id
			var object_network_id = buffer_read(buffer, buffer_u16)
			
			//find the object and destroy it
			var object_instance_id = ds_map_find_value(network_id_to_instanceid, object_network_id)
			if (is_undefined(ds_map_find_value(network_id_to_instanceid, object_network_id))) break;
			with object_instance_id
			{
				instance_destroy()
			}
			
			//remove it from network id map
			ds_map_delete(network_id_to_instanceid, object_network_id)
			break;
			
		case network.kill_player:
			//get player socket
			var socket_to_kill = buffer_read(buffer, buffer_u16)
			if socket_to_kill == global.my_socket
			{
				//this player is the one getting deactivated, so create a "you died!" screen to inform player
				instance_create_layer(0, 0, "Instances", obj_DeathScreen)
				instance_destroy(instance_find(obj_Player, 0))
			}
			else
			{
				//it's a different player, so just change their sprite to an X
				var instance_to_kill = ds_map_find_value(socket_to_instanceid, socket_to_kill)
				instance_to_kill.sprite_index = spr_DeadPlayer
			}
			break;
			
		case network.declare_victory:
			//get socket and username of victorious player
			var socket_victorious = buffer_read(buffer, buffer_u16)
			var username_victorious = buffer_read(buffer, buffer_string)
			
			if (socket_victorious == global.my_socket)
			{
				//this player won, so congratulate them!
				instance_create_layer(0, 0, "Instances", obj_VictoryScreen)
			}
			else
			{
				with (obj_DeathScreen)
				{
					text_to_draw = username_victorious + " won the match! Better luck next time you loser!"
				}
			}
			break;
		case network.refresh_room:
			//clear all instances and request them again from server
			//just walls right now but later can expand this to background tiles/other level objects/etc
			for (i = 0; i < instance_number(obj_Wall); i++)
			{
				//delete this wall
				instance_destroy(instance_find(obj_Wall, i))
			}
			
			//request all other walls
			buffer_seek(client_buffer, buffer_seek_start, 0)
			buffer_write(client_buffer, buffer_u8, network.request_objects)
			network_send_packet(client, client_buffer, buffer_tell(client_buffer));
			break;
	}	
}