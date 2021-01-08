/// @description Insert description here
// You can write your code in this editor

//heal owner
owner.hp = min(owner.hp + heal_amount, owner.max_hp)
with obj_Server
{
	network_modify_player_property(other.owner.socket, "hp", "u16", other.owner.hp)
}
alarm[0] = 60