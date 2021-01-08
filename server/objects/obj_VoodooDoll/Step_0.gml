/// @description Insert description here
// You can write your code in this editor

if (hp_previous != hp)
{
	var hp_difference = hp_previous - hp
	if hp_difference <= 0 exit
	var target_player = instance_nearest(x, y, obj_Player)
	if (target_player == owner)
	{
		target_player = instance_nth_nearest(x, y, obj_Player, 2)
	}
	//deal damage
	if distance_to_object(target_player) < effect_radius
	{
		deal_damage(hp_difference, id, target_player)
		with obj_Server
		{
			network_modify_player_property(target_player.socket, "hp", "u16", target_player.hp)
		}
	}
}


//set hp_previous equal to hp
hp_previous = hp
hp = 1000