/// @description Insert description here
// You can write your code in this editor
if room == rm_LobbyMenu
{
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_set_color(c_white)
	draw_text(room_width / 2, room_height - 90, "Press Space to Enter Game")
	draw_text(room_width / 2, room_height - 60, spells[global.player_ability_1][0] + " " + spells[global.player_ability_2][0])
	draw_text(room_width / 2, room_height - 30, classes[selected_class][0])
	draw_text(room_width - 150, room_height - 30, "Change Character: A, D / Arrows\nScroll Cards: W, S / Arrows")
}