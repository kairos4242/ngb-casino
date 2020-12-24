/// @description Insert description here
// You can write your code in this editor
//Send off player position update packet
alarm[0] = update_delay
buffer_seek(obj_Client.client_buffer, buffer_seek_start, 0)
buffer_write(obj_Client.client_buffer, buffer_u8, network.move)
buffer_write(obj_Client.client_buffer, buffer_u16, x)
buffer_write(obj_Client.client_buffer, buffer_u16, y)
network_send_packet(obj_Client.client, obj_Client.client_buffer, buffer_tell(obj_Client.client_buffer));