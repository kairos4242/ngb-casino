//0 is name, 1 is script reference

//Initialize Variables

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

global.player_ability_1 = 0 //Fireball by default
global.player_ability_2 = 2 //Swap places by default


//Create Cards
for (i = 0; i < array_length(spells); i++)
{
	card = instance_create_layer(0 + (128 * (i % 3)), 0 + (256 * floor(i / 3)), "Instances", obj_Card)
	with card
	{
		name = other.spells[other.i][0]
		card_id = other.i
	}
}