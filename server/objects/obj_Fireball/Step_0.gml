/// @description Insert description here
// You can write your code in this editor

//if outside room, send off destruction packets and then destroy self
event_inherited()
if (x < 0) or (y < 0) or (x > room_width) or (y > room_height)
{
	//destroy
	with obj_Server
	{
		for (i = 0; i < ds_list_size(socket_list); i++)
		{
			var curr_socket = ds_list_find_value(socket_list, i)
			buffer_seek(server_buffer, buffer_seek_start, 0)
			buffer_write(server_buffer, buffer_u8, network.destroy_object)
			buffer_write(server_buffer, buffer_u16, other.network_id)
			network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer));
		}
	}
	instance_destroy()
}