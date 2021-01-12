/// @description Insert description here
// You can write your code in this editor
if room = rm_LobbyMenu
{
	username_rough = buttons[0][0].text_string
	username = string_delete(username_rough, 20, string_length(username_rough) - 19)
	if (audio_is_playing(snd_MenuMusic))
	{
		audio_stop_sound(snd_MenuMusic)
	}
	//audio_play_sound(snd_MainMusic, 1, 1)
	room_goto_next()
}