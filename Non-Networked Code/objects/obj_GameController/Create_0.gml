/// @description Insert description here
// You can write your code in this editor
global.game_controller = id
enum damage_types {
	PHYSICAL,
	FIRE,
	COLD,
	POISON
}
spells[0][0] = "Fireball"
spells[0][1] = spell_fireball
spells[1][0] = "Refresh Jumps"
spells[1][1] = spell_refresh_jumps
spells[2][0] = "Swap Places"
spells[2][1] = spell_swap_places
spells[3][0] = "Wall"
spells[3][1] = spell_wall
spells[4][0] = "Passive Jump Height Increase"
spells[4][1] = spell_passive_jump_height_increase

effect_list = []

instance_create_layer(608, 352, "Instances", obj_Player)