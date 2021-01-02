/// @description Insert description here
// You can write your code in this editor

//alive check
if (alive == false) exit


//Spells
if mouse_check_button_pressed(mb_left)
{
	//notify the server that the basic attack was used
	network_cast_spell("spell_basic_attack", mouse_x, mouse_y)
}
if mouse_check_button_pressed(mb_right)
{
	//notify the server that ability 1 was used
	network_cast_spell(obj_GameController.spells[card_1][1],mouse_x, mouse_y)
}
if keyboard_check_pressed(ord("W"))
{
	//notify the server that ability 2 was used
	network_cast_spell(obj_GameController.spells[card_2][1],mouse_x, mouse_y)
}
if keyboard_check_pressed(vk_shift)
{
	//use common ability 1
	network_cast_spell(obj_GameController.spells[card_3][1],mouse_x, mouse_y)
}
if keyboard_check_pressed(ord("S"))
{
	//use common ability 2
	network_cast_spell(obj_GameController.spells[card_4][1],mouse_x, mouse_y)
}
if keyboard_check_pressed(ord("Q"))
{
	//use common ability 3
	network_cast_spell(obj_GameController.spells[card_5][1],mouse_x, mouse_y)
}

//Keyboard Input for Movement
key_left = keyboard_check(ord("A"))
key_right = keyboard_check(ord("D"))
key_jump = keyboard_check_pressed(vk_space)

//Movement
var move = key_right - key_left
if (can_move)
{
	x_speed = move * walk_speed
}
y_speed = y_speed + grav

if (place_meeting(x, y + 1, obj_Wall))
{
	jumps = max_jumps
}

if (key_jump) && (jumps > 0)
{
	jumps -= 1
	y_speed = -jump_speed
}

//Horizontal Collision
if (place_meeting(x + x_speed, y, obj_Wall))
{
	while (!place_meeting(x + sign(x_speed), y, obj_Wall))
	{
		x += sign(x_speed)
	}
	x_speed = 0
}
x += x_speed

//Vertical Collision
if (place_meeting(x, y + y_speed, obj_Wall))
{
	
	while (!place_meeting(x, y + sign(y_speed), obj_Wall))
	{
		y += sign(y_speed)
	}
	y_speed = 0
}
y += y_speed

//snap to in bounds
x = min(x, room_width)
x = max(x, 0)
y = max(y, 0)
y = min(y, room_height)

//check if we have received a cooldown from the server to update
if (cooldown_to_set != 0)
{
	//check if basic attack first
	if (ability_to_set == "Basic Attack")
	{
		cooldown[0] = cooldown_to_set
	}
	else
	{
		//iterate through all spells and if any of them match set their cooldown to 0
		//this means that if you have multiple copies of a spell then all copies go on cooldown
		for (i = 1; i < 6; i++)
		{
			if variable_instance_get(id, "card_" + string(i))
			{
				variable_instance_set(id, "card_" + string(i), cooldown_to_set)
			}
		}
	}
	cooldown_to_set = 0;//reset so we dont keep on resetting the cooldown
	ability_to_set = ""//should never matter but a bit of extra safety never hurts
}