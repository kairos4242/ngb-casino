/// @description Insert description here
// You can write your code in this editor
obj_Player.round_bet = 0
obj_Player.current_max_bet = 0

//destroy all button children
for (i = 0; i < array_length(buttons); i++)
{
	with buttons[i][0] instance_destroy()
}
with bet_box instance_destroy()