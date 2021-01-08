/// @description Insert description here
// You can write your code in this editor
draw_set_colour(c_white)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_font(fnt_Anonymous_24)
for (i = 0; i < button_count; i++)
{
	draw_text(128, display_get_gui_height() - 256, buttons[i][2])
}

//draw two columns credits text
draw_set_halign(fa_right)
draw_text(display_get_gui_width() / 2 - 50, display_get_gui_height() / 2, "DIRECTOR\nLEAD PROGRAMMER\nASSISTANT PROGRAMMER\nMUSIC AND SOUND\nARTWORK\nQA\n\nSPECIAL THANKS TO\n\n\n\n\n")
draw_set_halign(fa_left)
draw_text(display_get_gui_width() / 2 + 50, display_get_gui_height() / 2, "Riley Ward\nRiley Ward\nJerry Ju\nNick Lange\nCale Kristel\nMilan Kalra\nShauniv Kumar\nJim Ward\nAlex Ward\nLinnea Ward\nEthan Kurian\nIshaan Patel")