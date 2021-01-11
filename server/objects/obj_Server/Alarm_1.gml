/// @description Insert description here
// You can write your code in this editor

//mana regen alarm, shall trigger every 2.5
with obj_Player
{
	mana = min(mana + mana_regen, max_mana)
	
}
for (i = 0; i < instance_number(obj_Player); i++)
{
	var curr_player = instance_find(obj_Player, i)
	network_modify_player_property(curr_player.socket, "mana", "f32", curr_player.mana)
}
alarm[1] = 150//trigger again in 2.5