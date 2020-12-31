//ability 1, not doing hotkeys for now

//cast ability 1
//script_execute(abilities[0][1],id, -1)

//notify the server that ability 1 was used
//network_cast_spell(abilities[0][1], mouse_x, mouse_y)
network_cast_spell(obj_GameController.spells[card_1][1],mouse_x, mouse_y)