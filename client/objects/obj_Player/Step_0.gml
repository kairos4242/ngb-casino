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
	network_cast_spell(obj_GameController.spells[common_card_1][1],mouse_x, mouse_y)
}
if keyboard_check_pressed(ord("S"))
{
	//use common ability 2
	network_cast_spell(obj_GameController.spells[common_card_2][1],mouse_x, mouse_y)
}
if keyboard_check_pressed(ord("Q"))
{
	//use common ability 3
	network_cast_spell(obj_GameController.spells[common_card_3][1],mouse_x, mouse_y)
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
	x_speed = 0
	while (!place_meeting(x + move, y, obj_Wall))
	{
		x += move
	}
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