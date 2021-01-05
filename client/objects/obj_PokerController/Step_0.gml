/// @description Insert description here
// You can write your code in this editor

if (my_turn == 1)
{
	if buttons[0][1] == 1
	{
		//button pressed to call
		buttons[0][1] = 0//unpress button
		var amount_to_bet = obj_Player.current_max_bet - obj_Player.round_bet
		my_turn = 0
		with obj_Client
		{
			buffer_seek(client_buffer, buffer_seek_start, 0)
			buffer_write(client_buffer, buffer_u8, network.poker_bet)
			buffer_write(client_buffer, buffer_u16, amount_to_bet)
			network_send_packet(client, client_buffer, buffer_tell(client_buffer));
		}
	}
	if buttons[1][1] == 1
	{
		//button pressed to bet pot
		buttons[1][1] = 0//unpress button
		var amount_to_bet = obj_Player.pot
		my_turn = 0
		with obj_Client
		{
			buffer_seek(client_buffer, buffer_seek_start, 0)
			buffer_write(client_buffer, buffer_u8, network.poker_bet)
			buffer_write(client_buffer, buffer_u16, amount_to_bet)
			network_send_packet(client, client_buffer, buffer_tell(client_buffer));
		}
	}
	if buttons[2][1] == 1
	{
		//button pressed to bet half pot
		buttons[2][1] = 0//unpress button
		var amount_to_bet = floor(obj_Player.pot / 2)
		my_turn = 0
		with obj_Client
		{
			buffer_seek(client_buffer, buffer_seek_start, 0)
			buffer_write(client_buffer, buffer_u8, network.poker_bet)
			buffer_write(client_buffer, buffer_u16, amount_to_bet)
			network_send_packet(client, client_buffer, buffer_tell(client_buffer));
		}
	}
	if buttons[3][1] == 1
	{
		//buttons pressed for custom bet, so get custom bet amount and send it
		buttons[3][1] = 0//unpress button
		var amount_to_bet = real(string_digits(bet_box.text_string))
		my_turn = 0
		with obj_Client
		{
			buffer_seek(client_buffer, buffer_seek_start, 0)
			buffer_write(client_buffer, buffer_u8, network.poker_bet)
			buffer_write(client_buffer, buffer_u16, amount_to_bet)
			network_send_packet(client, client_buffer, buffer_tell(client_buffer));
		}
	}
}
//check whether to send spells to player
if abilities_sent == false
{
	//send spells to player
	obj_Player.card_1 = card_1
	obj_Player.card_2 = card_2
	abilities_sent = true
}