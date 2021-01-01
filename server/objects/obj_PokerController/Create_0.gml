/// @description Insert description here
// You can write your code in this editor
poker_step = 0//step controls which phase of the hand we are on
current_player = 0//controls who is currently betting
turn_length = 1500
card_count = 10///this needs to change whenever new cards are added, but surely there is a way to automate it
//deserves further thought
card_3 = irandom(card_count) + 1
card_4 = irandom(card_count) + 1
card_5 = irandom(card_count) + 1

master_turn_order = ds_priority_create()
temp_order = ds_priority_create()//for checking if everyone is settled after a bet

//initialize player balances
for (i = 0; i < ds_list_size(obj_Server.socket_list); i++)
{
	player_socket[i] = ds_list_find_value(obj_Server.socket_list, i)
	player_object[i] = ds_map_find_value(obj_Server.socket_to_instanceid, player_socket[i])
	ds_priority_add(master_turn_order, player_object[i], i)
}

current_max_bet = 0
current_bet = 0
pot = 0

turn_order = ds_priority_create()
ds_priority_copy(turn_order, master_turn_order)

//it is now the first round, choose the map and give each player their two cards
map = "Only Map"//obviously change this to an irandom later once we have more than one map
for (i = 0; i < ds_list_size(obj_Server.socket_list); i++)
{
	//deal two cards to player
	var card_1 = irandom(card_count) + 1 //to avoid somebody getting a second basic attack
	var card_2 = irandom(card_count) + 1//see prev
	//send the cards to the player
	var curr_socket = ds_list_find_value(obj_Server.socket_list, i)
	with obj_Server
	{
		var curr_socket = ds_list_find_value(socket_list, other.i)
		//send packet to modify card 1
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.modify_property)
		buffer_write(server_buffer, buffer_u16, poker_controller_id)
		buffer_write(server_buffer, buffer_string, "card_1")
		buffer_write(server_buffer, buffer_string, "u16")
		buffer_write(server_buffer, buffer_u16, card_1)
		network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
		
		//send packet to modify card 2
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.modify_property)
		buffer_write(server_buffer, buffer_u16, poker_controller_id)
		buffer_write(server_buffer, buffer_string, "card_2")
		buffer_write(server_buffer, buffer_string, "u16")
		buffer_write(server_buffer, buffer_u16, card_2)
		network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
	}
}
alarm[0] = turn_length//timeout alarm

//send out first packet to inform player it is their turn
current_player = ds_priority_find_max(other.turn_order)
with obj_Server {
	var curr_socket = other.current_player.socket
	//send packet to modify property
	buffer_seek(server_buffer, buffer_seek_start, 0);
	buffer_write(server_buffer, buffer_u8, network.modify_property)
	buffer_write(server_buffer, buffer_u16, poker_controller_id)
	buffer_write(server_buffer, buffer_string, "my_turn")
	buffer_write(server_buffer, buffer_string, "u16")
	buffer_write(server_buffer, buffer_u16, 1)
	network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
}