/// @description Insert description here
// You can write your code in this editor
//draw balance in upper left
draw_text(16, 16, string(balance))

//dynamically get and draw sprites of spells
for (i = 0; i < 5; i++)
{
	var current_spell = variable_instance_get(id, "card_" + string(i + 1))
	if current_spell == -1 break;
	var temp_card_to_draw = obj_GameController.spells[current_spell][1]
	var card_to_draw = string_delete(temp_card_to_draw, 1, 5)
	card_to_draw = "card" + card_to_draw
	draw_sprite_ext(asset_get_index(card_to_draw), 0, 165 * i, window_get_height() - 225, 0.2, 0.2, 0, c_white, 0.5)
}