username = "NULL USER"

walk_speed = 8
jump_speed = 14
jumps = 2
max_jumps = 2
grav = 0.4
can_move = 1
alive = true

x_speed = 0
y_speed = 0

hp = 100
max_hp = 100

update_delay = 2//in frames
alarm[0] = update_delay

//Abilities
//breaks my little heart to not have this in an array or some more sophisticated structure
//hopefully that will come
card_1 = global.player_ability_1
card_2 = global.player_ability_2
card_3 = -1
card_4 = -1
card_5 = -1


balance = 1000//chips
pot = 0


//Ability Cooldowns
for (i = 0; i < 6; i++)
{
	cooldown[i] = 0.0
	max_cooldown[i] = 0.0//for purposes of drawing cooldown box
}
//cooldown[0] corresponds to basic attack
//every cooldown after that corresponds to the ability of said number

//Vars for cooldown info from server
cooldown_to_set = 0
ability_to_set = ""