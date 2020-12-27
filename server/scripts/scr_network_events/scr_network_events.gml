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

function network_modify_property(id_to_modify, property_to_modify, value_to_write)
{
	for (i = 0; i < ds_list_size(socket_list); i++)
	{
		//send packet to modify property
		var curr_socket = ds_list_find_value(socket_list, i)
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.modify_property)
		buffer_write(server_buffer, buffer_u16, id_to_modify)
		buffer_write(server_buffer, buffer_string, property_to_modify)
		buffer_write(server_buffer, buffer_u16, value_to_write)
		network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
	}
}