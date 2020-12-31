/// @description Insert description here
// You can write your code in this editor

if (my_turn == 1)
{
	//check for keypresses to see what we want to do
	if keyboard_check_pressed(ord("1"))
	{
		//send packet to bet 100
		my_turn = 0
		with obj_Client
		{
			buffer_seek(client_buffer, buffer_seek_start, 0)
			buffer_write(client_buffer, buffer_u8, network.poker_bet)
			buffer_write(client_buffer, buffer_u16, 100)
			network_send_packet(client, client_buffer, buffer_tell(client_buffer));
		}
	}
	else if keyboard_check_pressed(ord("2"))
	{
		//send packet to fold
		my_turn = 0
		with obj_Client
		{
			buffer_seek(client_buffer, buffer_seek_start, 0)
			buffer_write(client_buffer, buffer_u8, network.poker_bet)
			buffer_write(client_buffer, buffer_u16, 0)
			network_send_packet(client, client_buffer, buffer_tell(client_buffer));
		}
	}
	else if keyboard_check_pressed(ord("3"))
	{
		//send packet to bet 200
		my_turn = 0
		with obj_Client
		{
			buffer_seek(client_buffer, buffer_seek_start, 0)
			buffer_write(client_buffer, buffer_u8, network.poker_bet)
			buffer_write(client_buffer, buffer_u16, 200)
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