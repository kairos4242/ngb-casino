/// @description Insert description here
// You can write your code in this editor
//draw balance in upper left
draw_text(16, 32, string(balance))

//dynamically get and draw sprites of spells
for (i = 0; i < 5; i++)
{
	var current_spell = variable_instance_get(id, "card_" + string(i + 1))
	if current_spell == -1 break;
	var temp_card_to_draw = obj_GameController.spells[current_spell][1]
	var card_to_draw = string_delete(temp_card_to_draw, 1, 5)
	card_to_draw = "card" + card_to_draw
	draw_sprite_ext(asset_get_index(card_to_draw), 0, 165 * i, display_get_gui_height() - 225, 0.2, 0.2, 0, c_white, 0.5)
	var box_value = 1 - cooldown[i + 1] / max_cooldown[i + 1]
	if box_value != 1//catches case where cooldown done
	{
		draw_set_alpha(0.5)
		draw_set_color(c_black)
		draw_rectangle_cd_inverse(165 * i, display_get_gui_height() - 225, (165 * i) + 165, display_get_gui_height(), box_value)
		draw_set_color(c_white)
		draw_set_alpha(1)
	}
}
//draw hotkey text
draw_text(0, display_get_gui_height() - 250, "Right Click")
draw_text(165, display_get_gui_height() - 250, "W")
draw_text(330, display_get_gui_height() - 250, "S")
draw_text(495, display_get_gui_height() - 250, "Shift")
draw_text(660, display_get_gui_height() - 250, "Q")

//draw mana bar
draw_healthbar(0, 0, display_get_gui_width(), 25, (mana / max_mana) * 100, c_black, c_red, c_blue, 0, false, true)