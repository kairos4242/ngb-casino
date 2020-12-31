/// @description Insert description here
// You can write your code in this editor

//increment the poker game
//first player is out of time or a bet has been received
show_message("Player bet " + string(current_bet))

//get the next player's bet
with obj_Server
{
	var curr_object = ds_priority_find_max(other.turn_order)
	var curr_socket = curr_object.socket
	//send packet to modify property
	buffer_seek(server_buffer, buffer_seek_start, 0);
	buffer_write(server_buffer, buffer_u8, network.modify_property)
	buffer_write(server_buffer, buffer_u16, poker_controller_id)
	buffer_write(server_buffer, buffer_string, "my_turn")
	buffer_write(server_buffer, buffer_string, "u16")
	buffer_write(server_buffer, buffer_u16, 1)
	network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
	ds_priority_delete_max(other.turn_order)
}