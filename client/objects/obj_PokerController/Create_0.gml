/// @description Insert description here
// You can write your code in this editor

//handles what the player sees and allows for the send of data if it is their turn
card_1 = -1
card_2 = -1
map = "?"
card_3 = "?"
card_4 = "?"
card_5 = "?"
my_turn = 0
abilities_sent = false
pot = 0

c_oxford_blue = make_color_rgb(15, 32, 55)
c_flame = make_color_rgb(229, 61, 0)
c_honeydew = make_color_rgb(223, 248, 235)

//create buttons
for (i = 0; i < 4; i++)
{
	buttons[i][0] = instance_create_layer(display_get_gui_width() - 38 - (i * 85), display_get_gui_height() - 38, "Instances", obj_UIButton1)
	buttons[i][1] = 0
}
//create custom bet amount box
bet_box = instance_create_layer(display_get_gui_width() * 3 / 4, display_get_gui_height() - 200, "Instances", obj_TextBox)

for (i = 0; i < 4; i++)
{
	with buttons[i][0]
	{
		owner = other.id
		i = other.i
	}
}

pot = 0
current_max_bet = 0