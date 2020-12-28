// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function network_cast_spell(ability_to_cast, target_x, target_y){
	buffer_seek(obj_Client.client_buffer, buffer_seek_start, 0)
	buffer_write(obj_Client.client_buffer, buffer_u8, network.cast_spell)
	buffer_write(obj_Client.client_buffer, buffer_string, ability_to_cast)
	buffer_write(obj_Client.client_buffer, buffer_u16, mouse_x)
	buffer_write(obj_Client.client_buffer, buffer_u16, mouse_y)
	network_send_packet(obj_Client.client, obj_Client.client_buffer, buffer_tell(obj_Client.client_buffer));
}