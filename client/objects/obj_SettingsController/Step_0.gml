/// @description Insert description here
// You can write your code in this editor
if buttons[0][1] == 1
{
	//button pressed to toggle fullscreen
	buttons[0][1] = 0
	window_set_fullscreen(not window_get_fullscreen())
}
//back button
if buttons[1][1] == 1
{
	//button pressed to go back
	buttons[1][1] = 0//unpress button
	room_goto(rm_MainMenu)
}