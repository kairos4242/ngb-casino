/// @description Insert description here
// You can write your code in this editor

//refresh the room

room_goto(rm_SecondTest)

for (i = 0; i < ds_list_size(socket_list); i++)
{
	//send packet to create object
	var curr_socket = ds_list_find_value(socket_list, i)
	buffer_seek(server_buffer, buffer_seek_start, 0);
	buffer_write(server_buffer, buffer_u8, network.refresh_room);
	buffer_write(server_buffer, buffer_string, "rm_Level2")
	network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
}

