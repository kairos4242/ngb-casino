// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function network_destroy_object(id_to_destroy){
	//to be run in obj_server only, to use in other objects
	//do with obj_Server network_destroy(whatever)
	
	for (i = 0; i < ds_list_size(socket_list); i++)
	{
		var curr_socket = ds_list_find_value(socket_list, i)
		buffer_seek(server_buffer, buffer_seek_start, 0)
		buffer_write(server_buffer, buffer_u8, network.destroy_object)
		buffer_write(server_buffer, buffer_u16, id_to_destroy)
		network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer));
	}
}

function network_create_object(object_to_create, id_to_create, x_to_create, y_to_create)
{
	for (i = 0; i < ds_list_size(socket_list); i++)
	{
		//send packet to create object
		var curr_socket = ds_list_find_value(socket_list, i)
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.add_object);
		buffer_write(server_buffer, buffer_string, object_to_create)
		buffer_write(server_buffer, buffer_u16, id_to_create)
		buffer_write(server_buffer, buffer_u16, x_to_create)
		buffer_write(server_buffer, buffer_u16, y_to_create)
		network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
	}
}

function network_modify_property(id_to_modify, property_to_modify, type_to_write, value_to_write)
{
	for (i = 0; i < ds_list_size(socket_list); i++)
	{
		//send packet to modify property
		var curr_socket = ds_list_find_value(socket_list, i)
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.modify_property)
		buffer_write(server_buffer, buffer_u16, id_to_modify)
		buffer_write(server_buffer, buffer_string, property_to_modify)
		buffer_write(server_buffer, buffer_string, type_to_write)
		//write a diff data type depending on which type the data is
		switch type_to_write {
			default: break;
			case "u16": buffer_write(server_buffer, buffer_u16, value_to_write)
			break;
			case "s16": buffer_write(server_buffer, buffer_s16, value_to_write)
			break;
			case "f16": buffer_write(server_buffer, buffer_f16, value_to_write)
			break;
			case "string": buffer_write(server_buffer, buffer_string, value_to_write)
			break;
		}
		network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
	}
}

function network_modify_player_property(socket_to_modify, property_to_modify, type_to_write, value_to_write)
{
	//this needs to be a separate function because players don't have network IDs
	//they have sockets instead
	//so this works off the socket not the network id
	for (i = 0; i < ds_list_size(socket_list); i++)
	{
		//send packet to modify property
		var curr_socket = ds_list_find_value(socket_list, i)
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.modify_player_property)
		buffer_write(server_buffer, buffer_u16, socket_to_modify)
		buffer_write(server_buffer, buffer_string, property_to_modify)
		buffer_write(server_buffer, buffer_string, type_to_write)
		//write a diff data type depending on which type the data is
		switch type_to_write {
			default: break;
			case "u16": buffer_write(server_buffer, buffer_u16, value_to_write)
			break;
			case "s16": buffer_write(server_buffer, buffer_s16, value_to_write)
			break;
			case "string": buffer_write(server_buffer, buffer_string, value_to_write)
			break;
			case "f16": buffer_write(server_buffer, buffer_f16, value_to_write)
			break;
		}
		network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
	}
}

function network_kill_player(socket_to_kill) {
	for (i = 0; i < ds_list_size(socket_list); i++)
	{
		//send packet to kill player
		var curr_socket = ds_list_find_value(socket_list, i)
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.kill_player)
		buffer_write(server_buffer, buffer_u16, socket_to_kill)
		network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
	}
	
}

function network_declare_victory(socket_victorious, username_victorious) {
	//in future, check if socket_victorious -1 and if so declare a draw
	//for now, just tell each socket that socket_victorious is victorious
	alarm[0] = 120//in two seconds, go to next poker round
	var winning_object = ds_map_find_value(socket_to_instanceid, socket_victorious)
	winning_object.balance += pot//give the winning player their winnings
	pot = 0
	network_modify_player_property(socket_victorious, "balance", "u16", winning_object.balance)
	for (i = 0; i < ds_list_size(socket_list); i++)
	{
		var curr_socket = ds_list_find_value(socket_list, i)
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.declare_victory)
		buffer_write(server_buffer, buffer_u16, socket_victorious)
		buffer_write(server_buffer, buffer_string, username_victorious)
		network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
	}
}