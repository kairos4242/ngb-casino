/// @description Insert description here
// You can write your code in this editor

if (my_turn == true)
{
	//check for keypresses to see what we want to do
	if keyboard_check_pressed(ord("1"))
	{
		//send packet to bet 100
		my_turn = false
	}
	else if keyboard_check_pressed(ord("2"))
	{
		//send packet to fold
		my_turn = false
	}
}