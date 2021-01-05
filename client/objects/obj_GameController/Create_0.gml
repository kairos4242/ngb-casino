/// @description Insert description here
// You can write your code in this editor
draw_set_font(fnt_Anonymous_12)

default_username = ""
if (file_exists("preferences.ini"))
{
	//load username
	ini_open("preferences.ini")
	default_username = ini_read_string("user", "last_username", "")
	ini_close()
	
}
	
username_callback = get_string_async("Please Enter a Username", default_username)


//0 is name, 1 is script reference

//Initialize Spell Array

//[0] is name [1] is script reference
//to get card image, we're going to be fancy and do it dynamically
//note this also opens the door for getting script dynamically in future although that will be marginally harder
spells[0][0] = "Basic Attack"
spells[0][1] = "spell_basic_attack"
spells[1][0] = "Fireball"
spells[1][1] = "spell_fireball"
spells[2][0] = "Acrobatics"
spells[2][1] = "spell_acrobatics"
spells[3][0] = "Switch"
spells[3][1] = "spell_switch"
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
spells[10][0] = "Tag"
spells[10][1] = "spell_tag"
spells[11][0] = "Immolate"
spells[11][1] = "spell_immolate"
spells[12][0] = "Boomerang"
spells[12][1] = "spell_boomerang"
spells[13][0] = "Voodoo Doll"
spells[13][1] = "spell_voodoo_doll"
spells[14][0] = "Pillar";
spells[14][1] = "spell_pillar";
spells[15][0] = "Thorns";
spells[15][1] = "spell_thorns";

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

//Initialize Class Array
//0 name, 1 HP, 2 base mana, 3 mana regen, 4 speed, 5 jumps
//going to try hardcoding attack into spell_basic_attack
classes[0][0] = "Null"
classes[0][1] = 100
classes[0][2] = 100
classes[0][3] = 5
classes[0][4] = 8
classes[0][5] = 2
classes[1][0] = "Typhoon"
classes[1][1] = 250
classes[1][2] = 100
classes[1][3] = 5
classes[1][4] = 5
classes[1][5] = 2
classes[2][0] = "Akimbo"
classes[2][1] = 50
classes[2][2] = 75
classes[2][3] = 5
classes[2][4] = 10
classes[2][5] = 3
classes[3][0] = "Oracle"
classes[3][1] = 75
classes[3][2] = 150
classes[3][3] = 10
classes[3][4] = 8
classes[3][5] = 2
classes[4][0] = "Wraith"
classes[4][1] = 80
classes[4][2] = 0
classes[4][3] = 0
classes[4][4] = 10
classes[4][5] = 3
classes[5][0] = "Guerilla"
classes[5][1] = 50
classes[5][2] = 60
classes[5][3] = 15
classes[5][4] = 8
classes[5][5] = 3
classes[6][0] = "Redline"
classes[6][1] = 150
classes[6][2] = 100
classes[6][3] = 5
classes[6][4] = 11
classes[6][5] = 1
classes[7][0] = "Sentinel"
classes[7][1] = 150
classes[7][2] = 100
classes[7][3] = 5
classes[7][4] = 3
classes[7][5] = 6

//store selected class
selected_class = 0