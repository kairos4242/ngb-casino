/// @description Insert description here
// You can write your code in this editor
username = get_string("Please Enter a Username", "")

//0 is name, 1 is script reference

//Initialize Variables
spells[0][0] = "Basic Attack"
spells[0][1] = "spell_basic_attack"
spells[1][0] = "Fireball"
spells[1][1] = "spell_fireball"
spells[2][0] = "Refresh Jumps"
spells[2][1] = "spell_refresh_jumps"
spells[3][0] = "Swap Places"
spells[3][1] = "spell_swap_places"
spells[4][0] = "Wall"
spells[4][1] = "spell_wall"
spells[5][0] = "Antigravity"
spells[5][1] = "spell_antigravity"
spells[6][0] = "Turret"
spells[6][1] = "spell_turret"
spells[7][0] = "Heal"
spells[7][1] = "spell_heal"
spells[8][0] = "Terrify"
spells[8][1] = "spell_terrify"
spells[9][0] = "Knockback"
spells[9][1] = "spell_knockback"

global.player_ability_1 = 1 //Fireball by default
global.player_ability_2 = 6 //turret by default


//Create Cards
row_length = 5
for (i = 1; i < array_length(spells); i++)//we start on i=1 so as to avoid including the basic attack in the list of pickable spells
{
	card = instance_create_layer(0 + (128 * ((i - 1) % row_length)), 0 + (256 * floor((i - 1) / row_length)), "Instances", obj_Card)
	with card
	{
		name = other.spells[other.i][0]
		card_id = other.i
	}
}