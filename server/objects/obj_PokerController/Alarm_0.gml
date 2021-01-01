/// @description Insert description here
// You can write your code in this editor

//increment the poker game
//first player is out of time or a bet has been received
show_message("Player bet " + string(current_bet))
pot += current_bet
with (current_player)
{
	//decrease balance by how much they bet
	balance -= other.current_bet
	current_bet = other.current_bet
	round_bet += other.current_bet
	total_bet += other.current_bet
}
if (current_player.round_bet > current_max_bet) 
{
	current_max_bet = current_player.round_bet
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
			//if current player has matched the maximum bet, move past them
			ds_priority_delete_max(temp_order)
		}
		else
		{
			everyone_even = false;
			current_player = ds_priority_find_max(temp_order)
			ds_priority_add(turn_order, current_player, ds_priority_find_priority(temp_order, current_player))
			break;
		}
	}
	//if everyone even, go onto next round and flip a card
	//otherwise, set alarm[0] to 1 which we are going to do now for testing
	if (everyone_even == true)
	{
		//go to next round and flip a card
		switch (poker_step)
		{
			default: break;
			case 0:
				//preflop done, flip the first card
				poker_step++
				with obj_Server
				{
					//send out notification of what the first card is
					network_modify_property(poker_controller_id, "common_card_1", "u16", other.common_card_1)
				}
				break;
			case 1:
				//second step, flip the second card
				poker_step++
				with obj_Server
				{
					//send out notification of what the second card is
					network_modify_property(poker_controller_id, "common_card_2", "u16", other.common_card_2)
				}
				break;
			case 2:
				//third step, flip the third card
				poker_step++
				with obj_Server
				{
					//send out notification of what the third card is
					network_modify_property(poker_controller_id, "common_card_3", "u16", other.common_card_3)
				}
				break;
			case 3:
				//all done betting, now its time to go to the game
				obj_Server.pot = pot
				room_goto(RoomViewTest)//temporary, eventually this will be whatever map was selected
				with obj_Server
				{
					//tell all clients to refresh their room
					for (i = 0; i < ds_list_size(socket_list); i++)
					{
						//send packet to create object
						var curr_socket = ds_list_find_value(socket_list, i)
						buffer_seek(server_buffer, buffer_seek_start, 0);
						buffer_write(server_buffer, buffer_u8, network.refresh_room);
						network_send_packet(curr_socket, server_buffer, buffer_tell(server_buffer))
					}
					network_destroy_object(poker_controller_id)
				}
				instance_destroy()
				exit;
		}
		//now that we have flipped cards, time for the next betting round
		//reset the round_bet of all players to 0
		with obj_Player
		{
			round_bet = 0
		}
		//reset the max bet to 0
		current_max_bet = 0
		//reset the turn order, and send out the first packet so we go again
		ds_priority_copy(turn_order, master_turn_order)//note this will exclude players who have folded
		alarm[0] = turn_length
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
		current_bet = 0
		
	}
	else
	{
		//somebody is still causing issues, so get their bet
		alarm[0] = turn_length
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
		current_bet = 0
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
	current_bet = 0
}