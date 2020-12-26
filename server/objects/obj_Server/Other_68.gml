/// @description Insert description here
// You can write your code in this editor
type_event = ds_map_find_value(async_load, "type")

switch (type_event) {
	default: break;
	
	case network_type_connect:
		socket = ds_map_find_value(async_load, "socket")
		ds_list_add(socket_list, socket);
		
		buffer_seek(server_buffer, buffer_seek_start, 0)
		buffer_write(server_buffer, buffer_u8, network.player_establish)//event is a player establish
		buffer_write(server_buffer, buffer_u8, socket);//socket to establish is this socket
		network_send_packet(socket, server_buffer, buffer_tell(server_buffer));
		
		break;
	case network_type_disconnect:
		socket = ds_map_find_value(async_load, "socket")
		ds_list_delete(socket_list, ds_list_find_index(socket_list, socket))
		with ds_map_find_value(socket_to_instanceid, socket)
		{
			instance_destroy()
		}
		
		ds_map_delete(socket_to_instanceid, socket)
		
		for (i = 0; i < ds_list_size(socket_list); i++)
		{
			var curr_socket = ds_list_find_value(socket_list, i)
			buffer_seek(server_buffer, buffer_seek_start, 0)
			buffer_write(server_buffer, buffer_u8, network.player_disconnect)//event is a server disconnect
			buffer_write(server_buffer, buffer_u8, socket);//socket disconnecting is this socket
			network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer));
		}
		break;
		
	case network_type_data:
		buffer = ds_map_find_value(async_load, "buffer")
		socket = ds_map_find_value(async_load, "id")
		buffer_seek(buffer, buffer_seek_start, 0);
		receive_packet(buffer, socket)
}