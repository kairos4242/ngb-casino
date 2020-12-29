/// @description Insert description here
// You can write your code in this editor

//Keyboard Input
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