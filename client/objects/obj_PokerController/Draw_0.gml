/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_white)
draw_text(obj_Player.x, obj_Player.y  - 128, "Card 1: " + string(card_1) + ", Card 2: " + string(card_2))
if (my_turn == true)
{
	draw_text(obj_Player.x, obj_Player.y - 192, "Press 1 to bet 100, press 2 to fold, or press 3 to bet 200")
}