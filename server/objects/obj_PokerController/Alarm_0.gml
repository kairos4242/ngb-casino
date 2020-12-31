/// @description Insert description here
// You can write your code in this editor

//increment the poker game
//first player is out of time or a bet has been received
show_message("Player bet " + string(current_bet))
pot += current_bet

if current_bet > current_max_bet current_max_bet = current_bet
with (current_player)
{
	//decrease balance by how much they bet
	balance -= other.current_bet
	current_bet = other.current_bet
	round_bet += other.current_bet
}
if (current_bet == 0) and (current_max_bet != 0)
{
	//player has folded, remove them from all turn orders
	show_message("Player folded")
	ds_priority_delete_value(master_turn_order, current_player)
	ds_priority_delete_value(turn_order, current_player)
	ds_priority_delete_value(temp_order, current_player)
}
with obj_Server
{
	network_modify_player_property(other.current_player.socket, "balance", "u16", other.current_player.balance)
	network_modify_player_property(other.current_player.socket, "pot", "u16", other.pot)
}

ds_priority_delete_max(turn_order)//get rid of the person who just bet

current_player = ds_priority_find_max(turn_order)
if (is_undefined(current_player))
{
	//nobody left in the queue, so let's check if anybody bet more than the other guys
	//and if they did, lets make everyone else bet that amount too
	ds_priority_copy(temp_order, master_turn_order)
	current_player = ds_priority_find_max(temp_order)
	//check if everyone has bet the current_max_bet amount
	everyone_even = true
	while !(is_undefined(ds_priority_find_max(temp_order)))
	{
		if (ds_priority_find_max(temp_order).round_bet == current_max_bet)
		{
			ds_priority_delete_max(temp_order)
		}
		else
		{
			everyone_even = false;
			var player_uneven = ds_priority_find_max(temp_order)
			ds_priority_add(turn_order, player_uneven, ds_priority_find_priority(temp_order, player_uneven))
			break;
		}
	}
	show_message("Everyone even: " + string(everyone_even))
	//if everyone even, go onto next round and flip a card
	//otherwise, set alarm[0] to 1 which we are going to do now for testing
	if (everyone_even == true)
	{
		//go to next round and flip a card
		show_message("Go to next round and flip a card")
	}
	else
	{
		//somebody is still causing issues, so get their bet
		alarm[0] = 1500
		//get the next player's bet
		current_player = ds_priority_find_max(turn_order)
		with obj_Server
		{
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
	}
	
}
else
{
	//get the next player's bet
	with obj_Server
	{
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
}