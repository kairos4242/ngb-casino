/// @description Insert description here
// You can write your code in this editor
if room == rm_MainMenu
{
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text(room_width / 2, room_height / 2, "Press Space to Enter Game")
	draw_set_color(c_white)
	draw_text(room_width / 2, room_height - 30, string(global.player_ability_1) + " " + string(global.player_ability_2))
}
