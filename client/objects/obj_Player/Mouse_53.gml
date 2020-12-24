//ability 1, not doing hotkeys for now

//cast ability 1
//script_execute(abilities[0][1],id, -1)

//notify the server that ability 1 was used
buffer_seek(obj_Client.client_buffer, buffer_seek_start, 0)
buffer_write(obj_Client.client_buffer, buffer_u8, network.cast_spell)
buffer_write(obj_Client.client_buffer, buffer_string, abilities[0][1])
network_send_packet(obj_Client.client, obj_Client.client_buffer, buffer_tell(obj_Client.client_buffer));