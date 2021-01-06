/// @description Insert description here
// You can write your code in this editor
if buttons[0][1] == 1
{
	//button pressed to go to game
	buttons[0][1] = 0//unpress button
	room_goto(rm_LobbyMenu)
}
if buttons[1][1] == 1
{
	//button pressed to go to Instructions
	buttons[1][1] = 0
	room_goto(rm_Instructions)
}
if buttons[2][1] == 1
{
	//button pressed to go to settings
	buttons[2][1] = 0
	room_goto(rm_Settings)
}
if buttons[3][1] == 1
{
	//button pressed to go to about
	buttons[3][1] = 0
	room_goto(rm_About)
}