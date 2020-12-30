/// @description Insert description here
// You can write your code in this editor
poker_step = 0//step controls which phase of the hand we are on
current_player = 0//controls who is currently betting
turn_length = 1500

master_turn_order = ds_priority_create()

//initialize player balances
for (i = 0; i < ds_list_size(obj_Server.socket_list); i++)
{
	player_balance[i] = 10000
	player_socket[i] = ds_list_find_value(obj_Server.socket_list, i)
	player_object[i] = ds_list_find_value(obj_Server.socket_to_instanceid, player_socket[i])
	player_pot = 0
	player_state = "In"
	ds_priority_add(master_turn_order, player_object[i], i)
}

current_max_bet = 0

turn_order = ds_priority_create()
ds_priority_copy(turn_order, master_turn_order)

//it is now the first round, choose the map and give each player their two cards
map = "Only Map"//obviously change this to an irandom later once we have more than one map
for (i = 0; i < ds_list_size(obj_Server.socket_list); i++)
{
	//deal two cards to player
	var card_1 = irandom(8) + 1 //to avoid somebody getting a second basic attack
	var card_2 = irandom(8) + 1
	//send the cards to the player
	var curr_socket = ds_list_find_value(obj_Server.socket_list, i)
	with obj_Server
	{
		//send packet to modify property
		var curr_socket = ds_list_find_value(socket_list, i)
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.modify_property)
		buffer_write(server_buffer, buffer_u16, other.network_id)
		buffer_write(server_buffer, buffer_string, "card_1")
		buffer_write(server_buffer, buffer_string, "u16")
		buffer_write(server_buffer, buffer_u16, card_1)
		network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
	}
}
alarm[0] = 1500