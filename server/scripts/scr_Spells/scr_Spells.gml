// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//Target is an array of [x, y] so target[0] will get target xpos and target[1] will get target ypos

function spell_basic_attack(caster, target){
	
	basic_projectile_speed = 15
	switch caster.attack_speed
	{
		default: break;
		case "Slow": basic_projectile_speed = 15
		case "Fast": basic_projectile_speed = 30
	}
	cast_direction = point_direction(caster.x, caster.y, target[0], target[1])
	if caster.attack_type == "Ranged"
	{
		//shoot a projectile
		if collision_line(caster.x, caster.y, caster.x + lengthdir_x(caster.sprite_width, cast_direction), caster.y + lengthdir_y(caster.sprite_height, cast_direction), obj_Wall, false, false) != noone exit;
		var basic_projectile = instance_create_layer(caster.x + lengthdir_x(caster.sprite_width, cast_direction), caster.y + lengthdir_y(caster.sprite_height, cast_direction), "Instances", obj_BasicProjectile)
		with basic_projectile {
			owner = caster//for purposes of checking hit
			network_id = new_network_id()
			image_angle = other.cast_direction
			x_speed = lengthdir_x(other.basic_projectile_speed, other.cast_direction)
			y_speed = lengthdir_y(other.basic_projectile_speed, other.cast_direction)
			damage = caster.attack_damage
		}
		//send packet to all players to create a projectile object then send a packet to change fireball angle
		network_create_object("obj_BasicProjectile", basic_projectile.network_id, basic_projectile.x, basic_projectile.y)
		network_modify_property(basic_projectile.network_id, "image_angle", "u16", cast_direction)
		network_modify_property(basic_projectile.network_id, "x_speed", "s16", lengthdir_x(basic_projectile_speed, cast_direction))
		network_modify_property(basic_projectile.network_id, "y_speed", "s16", lengthdir_y(basic_projectile_speed, cast_direction))
	}
	else if caster.attack_type == "Melee"
	{
		//check for collision in line"
		with caster
		{
			var melee_target = collision_line(x, y, x + lengthdir_x(100, other.cast_direction), y + lengthdir_y(100, other.cast_direction), obj_Player, false, true)
			if (melee_target != noone)
			{
				deal_damage(caster.attack_damage, caster, melee_target)
			}
		}
		if melee_target != noone
		{
			network_modify_player_property(melee_target.socket, "hp", "u16", melee_target.hp)
			network_create_object("obj_Explosion", -1, melee_target.x, melee_target.y)
		}
	}
		
	
	//send cooldown packets
	network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 60)
	network_modify_player_property(caster.socket, "ability_to_set", "string", "Basic Attack")
}

function spell_fireball(caster, target){
	var mana_cost = 15
	if caster.mana < mana_cost exit;
	caster.mana -= mana_cost
	//create server representation
	fireball_speed = 20
	cast_direction = point_direction(caster.x, caster.y, target[0], target[1])
	//originally this was sprite_width / 2
	var fireball = instance_create_layer(caster.x + lengthdir_x(caster.sprite_width, cast_direction), caster.y + lengthdir_y(caster.sprite_height, cast_direction), "Instances", obj_Fireball)
	with fireball {
		owner = caster//for purposes of checking hit
		network_id = new_network_id()
		image_angle = other.cast_direction
		x_speed = lengthdir_x(other.fireball_speed, other.cast_direction)
		y_speed = lengthdir_y(other.fireball_speed, other.cast_direction)
	}
	//send packet to all players to create a fireball object then send a packet to change fireball angle
	network_create_object("obj_Fireball", fireball.network_id, fireball.x, fireball.y)
	network_modify_property(fireball.network_id, "image_angle", "u16", cast_direction)
	network_modify_property(fireball.network_id, "x_speed", "s16", lengthdir_x(fireball_speed, cast_direction))
	network_modify_property(fireball.network_id, "y_speed", "s16", lengthdir_y(fireball_speed, cast_direction))
	
	//send cooldown packets
	network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 120)
	network_modify_player_property(caster.socket, "ability_to_set", "string", "Fireball")
	
	//send mana packet
	network_modify_player_property(caster.socket, "mana", "f32", caster.mana)
}

function spell_acrobatics(caster, target){
	var mana_cost = 5
	if caster.mana < mana_cost exit;
	caster.mana -= mana_cost
	
	//change server side
	caster.jumps = caster.max_jumps
	
	//change client side
	network_modify_player_property(caster.socket, "jumps", "u16", caster.max_jumps)
	
	//send cooldown packets
	network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 240)
	network_modify_player_property(caster.socket, "ability_to_set", "string", "Acrobatics")
	
	//send mana packet
	network_modify_player_property(caster.socket, "mana", "f32", caster.mana)
}

function spell_switch(caster, target){
	var mana_cost = 20
	if caster.mana < mana_cost exit;
	caster.mana -= mana_cost
	
	//update server representation
	var collision_radius = 32
	target_object = collision_rectangle(target[0] - collision_radius, target[1] - collision_radius, target[0] + collision_radius, target[1] + collision_radius, obj_Player, false, true)
	if target_object = noone exit
	else
	{
		var temp_x = target_object.x
		var temp_y = target_object.y
		target_object.x = caster.x
		target_object.y = caster.y
		caster.x = temp_x
		caster.y = temp_y
	}
	
	//update client representation
	
	//update player
	network_modify_player_property(caster.socket, "x", "u16", caster.x)
	network_modify_player_property(caster.socket, "y", "u16", caster.y)
	
	//update other player
	network_modify_player_property(target_object.socket, "x", "u16", target_object.x)
	network_modify_player_property(target_object.socket, "y", "u16", target_object.y)
	
	//send cooldown packets
	network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 240)
	network_modify_player_property(caster.socket, "ability_to_set", "string", "Switch")
	
	//send mana packet
	network_modify_player_property(caster.socket, "mana", "f32", caster.mana)
}

function spell_wall(caster, target){
	var mana_cost = 10
	if caster.mana < mana_cost exit;
	caster.mana -= mana_cost
	
	//server implementation
	cast_direction = point_direction(caster.x, caster.y, target[0], target[1])
	cast_direction = round(cast_direction / 90) * 90 //round to the nearest 90 degrees
	if (place_meeting(target[0], target[1], obj_Player)) exit;
	var wall = instance_create_layer(caster.x + 2 * lengthdir_x(caster.sprite_width, cast_direction), caster.y + 2 * lengthdir_y(caster.sprite_height, cast_direction), "Instances", obj_Wall)
	var collision = false;//check if colliding with player
	with wall {
		image_angle = other.cast_direction
		image_yscale = 3
		network_id = new_network_id()
		alarm[0] = 1200
		if place_meeting(x, y, obj_Player) collision = true
	}
	if (collision)
	{
		with wall
		{
			instance_destroy()//since player not allowed to be stuck in a wall by wall
		}
	}
	else
	{
		//network implementation
		network_create_object("obj_Wall", wall.network_id, wall.x, wall.y)
		network_modify_property(wall.network_id, "image_angle", "u16", wall.image_angle)
		network_modify_property(wall.network_id, "image_yscale", "u16", wall.image_yscale)
	
		//send cooldown packets
		network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 60)
		network_modify_player_property(caster.socket, "ability_to_set", "string", "Wall")
	}
	
	//send mana packet
	network_modify_player_property(caster.socket, "mana", "f32", caster.mana)
	
}

function spell_antigravity(caster, target){
	/*jump_passive = {
		passive_id: "0000",
		name: "Antigravity Passive",
		type: "Subtract",
		unique: true,
		passive_target: caster,
		passive_source: caster,
		passive_target_variable: "grav"
	}
	create_effect(jump_passive, caster, target)*/
	var mana_cost = 5
	if caster.mana < mana_cost exit;
	caster.mana -= mana_cost
	if !(variable_instance_exists(id, "antigravity_on"))
	{
		antigravity_on = true
		network_modify_player_property(caster.socket, "grav", "f32", 0.2)
	}
	else
	{
		//if antigravity off, turn it on
		if (antigravity_on == false)
		{
			network_modify_player_property(caster.socket, "grav", "f32", 0.2)
			antigravity_on = true
		}
		else
		{
			//antigravity on, turn it off
			network_modify_player_property(caster.socket, "grav", "f32", 0.4)
			antigravity_on = false
		}
	}
	
	//send cooldown packets, but does antigravity even need a cooldown?
	network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 15)
	network_modify_player_property(caster.socket, "ability_to_set", "string", "Antigravity")
	
	//send mana packet
	network_modify_player_property(caster.socket, "mana", "f32", caster.mana)
}

function spell_turret(caster, target){
	var mana_cost = 45
	if caster.mana < mana_cost exit;
	caster.mana -= mana_cost
	
	turret_max_cast_distance = 200
	cast_distance = point_distance(caster.x, caster.y, target[0], target[1])
	if cast_distance > turret_max_cast_distance exit
	var turret = instance_create_layer(target[0], target[1], "Instances", obj_Turret)
	with turret {
		owner = caster//for purposes of checking hit
		network_id = new_network_id()
	}
	//send packet to all players to create a turret object
	network_create_object("obj_Turret", turret.network_id, turret.x, turret.y)
	
	//send cooldown packets
	network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 720)
	network_modify_player_property(caster.socket, "ability_to_set", "string", "Turret")
	
	//send mana packet
	network_modify_player_property(caster.socket, "mana", "f32", caster.mana)
}

function spell_heal(caster, target){
	var mana_cost = 20
	if caster.mana < mana_cost exit;
	caster.mana -= mana_cost
	
	//just a self heal right now, target does nothing
	//can be changed later if game design team wants to make it more versatile
	heal_amount = 7
	caster.hp = min(caster.max_hp, caster.hp + heal_amount)
	network_modify_player_property(caster.socket, "hp", "u16", caster.hp)
	
	//send cooldown packets
	network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 240)
	network_modify_player_property(caster.socket, "ability_to_set", "string", "Heal")
	
	//send mana packet
	network_modify_player_property(caster.socket, "mana", "f32", caster.mana)
}

function spell_terrify(caster, target){
	var mana_cost = 30
	if caster.mana < mana_cost exit;
	caster.mana -= mana_cost
	
	//prevents player from moving themself, but does not freeze all player movement
	var radius = 200
	var collision_list = ds_list_create()
	var collision_count = collision_rectangle_list(caster.x - radius, caster.y - radius, caster.x + radius, caster.y + radius, obj_Player, false, true, collision_list, false)
	//var target_player = collision_point(target[0], target[1], obj_Player, false, false)
	//if (target_player == noone) exit
	if collision_count == 0
	{
		show_message("No collisions found")
		exit;
	}
	for (j = 0; j < ds_list_size(collision_list); j++)
	{
		var target_player = ds_list_find_value(collision_list, j)
		if (target_player != caster)//so we dont terrify ourself
		{
			with obj_Server
			{
				network_modify_player_property(target_player.socket, "can_move", "u16", 0)
				//reset player xspeed to 0 otherwise they keep skating for the two seconds
				network_modify_player_property(target_player.socket, "x_speed", "u16", 0)
			}
			var passive = instance_create_layer(0, 0, "Instances", obj_Passive)
			with passive
			{
				alarm[0] = 120
				target_socket = target_player.socket
				target_variable = "can_move"
				target_variable_type = "u16"
				target_value = 1
			}
		}
	}
	
	//send cooldown packets
	network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 480)
	network_modify_player_property(caster.socket, "ability_to_set", "string", "Terrify")
	
	//send mana packet
	network_modify_player_property(caster.socket, "mana", "f32", caster.mana)
}

function spell_knockback(caster, target){
	var mana_cost = 5
	if caster.mana < mana_cost exit;
	caster.mana -= mana_cost
	
	//setup
	var knockback_duration = 15
	var knockback_amount = 20
	var target_player = collision_point(target[0], target[1], obj_Player, false, true)
	if (target_player == noone) exit
	var knockback_direction = point_direction(caster.x, caster.y, target[0], target[1])
	var knockback_x = lengthdir_x(knockback_amount, knockback_direction)
	var knockback_y = lengthdir_y(knockback_amount, knockback_direction)
	//change variables
	target_player.can_move = 0
	target_player.x_speed = knockback_x
	target_player.y_speed = knockback_y
	
	//send messages
	with obj_Server
	{
		network_modify_player_property(target_player.socket, "can_move", "u16", 0)
		network_modify_player_property(target_player.socket, "x_speed", "s16", knockback_x)
		network_modify_player_property(target_player.socket, "y_speed", "s16", knockback_y)
	}
	
	//create passive to undo movement
	var passive = instance_create_layer(0, 0, "Instances", obj_Passive)
	with passive
	{
		alarm[0] = knockback_duration
		target_socket = target_player.socket
		target_variable = "can_move"
		target_variable_type = "u16"
		target_value = 1
	}
	
	//send cooldown packets
	with obj_Server
	{
		network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 480)
		network_modify_player_property(caster.socket, "ability_to_set", "string", "Knockback")
	}
	
	//send mana packet
	network_modify_player_property(caster.socket, "mana", "f32", caster.mana)
}

function spell_tag(caster, target)
{
	//check if variable exists
	if !variable_instance_exists(caster, "tag_active")
	{
		caster.tag_active = 0//initialize to false
	}
	//check if projectile already cast or not
	if (caster.tag_active == 0)
	{
		//projectile not cast, cast projectile
		caster.tag_active = 1
		tag_projectile_speed = 10
		cast_direction = point_direction(caster.x, caster.y, target[0], target[1])
		caster.tag_projectile = instance_create_layer(caster.x + lengthdir_x(caster.sprite_width, cast_direction), caster.y + lengthdir_y(caster.sprite_height, cast_direction), "Instances", obj_TagProjectile)
		with caster.tag_projectile {
			owner = caster//for purposes of checking hit
			network_id = new_network_id()
			image_angle = other.cast_direction
			x_speed = lengthdir_x(other.tag_projectile_speed, other.cast_direction)
			y_speed = lengthdir_y(other.tag_projectile_speed, other.cast_direction)
		}
		//send packet to all players to create a tag object then send a packet to change tag angle
		network_create_object("obj_TagProjectile", caster.tag_projectile.network_id, caster.tag_projectile.x, caster.tag_projectile.y)
		network_modify_property(caster.tag_projectile.network_id, "image_angle", "u16", cast_direction)
		network_modify_property(caster.tag_projectile.network_id, "x_speed", "s16", lengthdir_x(tag_projectile_speed, cast_direction))
		network_modify_property(caster.tag_projectile.network_id, "y_speed", "s16", lengthdir_y(tag_projectile_speed, cast_direction))
	}
	else
	{
		var mana_cost = 15
		if caster.mana < mana_cost exit;
		caster.mana -= mana_cost
		//projectile exists, teleport to it
		caster.tag_active = 0
		caster.x = caster.tag_projectile.x
		caster.y = caster.tag_projectile.y
		
		//send out network information
		network_modify_player_property(caster.socket, "x", "u16", caster.x)
		network_modify_player_property(caster.socket, "y", "u16", caster.y)
		network_destroy_object(caster.tag_projectile.network_id)
		
		//destroy tag as it has been used
		instance_destroy(caster.tag_projectile)
		
		//send cooldown packets (tag should only go on cooldown when you teleport to it)
		network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 120)
		network_modify_player_property(caster.socket, "ability_to_set", "string", "Tag")
		
		//send mana packet (tag should only cost mana when you teleport to it)
		network_modify_player_property(caster.socket, "mana", "f32", caster.mana)
		
	}
}

function spell_immolate(caster, target)
{
	var mana_cost = 50
	if caster.mana < mana_cost exit;
	caster.mana -= mana_cost
	
	var immolate = instance_create_layer(caster.x, caster.y, "Instances", obj_Immolate)
	with immolate {
		owner = caster//for purposes of checking hit
		network_id = new_network_id()
	}
	//send packet to all players to create a turret object
	network_create_object("obj_Immolate", immolate.network_id, immolate.x, immolate.y)
	network_modify_property(immolate.network_id, "owner", "u16", caster.socket)
	//damage self
	deal_damage(10, caster, caster)
	network_modify_player_property(caster.socket, "hp", "u16", caster.hp)
	
	//send cooldown packets
	network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 120)
	network_modify_player_property(caster.socket, "ability_to_set", "string", "Immolate")
	
	//send mana packet
	network_modify_player_property(caster.socket, "mana", "f32", caster.mana)
}

function spell_boomerang(caster, target)
{
	var mana_cost = 15
	if caster.mana < mana_cost exit;
	caster.mana -= mana_cost
	
	boomerang_speed = 30
	cast_direction = point_direction(caster.x, caster.y, target[0], target[1])
	var boomerang = instance_create_layer(caster.x + lengthdir_x(caster.sprite_width, cast_direction), caster.y + lengthdir_y(caster.sprite_height, cast_direction), "Instances", obj_Boomerang)
	with boomerang {
		owner = caster//for purposes of checking hit
		network_id = new_network_id()
		image_angle = other.cast_direction
		x_speed = lengthdir_x(other.boomerang_speed, other.cast_direction)
		y_speed = lengthdir_y(other.boomerang_speed, other.cast_direction)
		x_dir = dcos(other.cast_direction)
		y_dir = -dsin(other.cast_direction)
	}
	//send packet to all players to create a fireball object then send a packet to change boomerang angle
	network_create_object("obj_Boomerang", boomerang.network_id, boomerang.x, boomerang.y)
	network_modify_property(boomerang.network_id, "image_angle", "u16", cast_direction)
	network_modify_property(boomerang.network_id, "x_speed", "s16", lengthdir_x(boomerang_speed, cast_direction))
	network_modify_property(boomerang.network_id, "y_speed", "s16", lengthdir_y(boomerang_speed, cast_direction))
	
	//send cooldown packets
	network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 60)
	network_modify_player_property(caster.socket, "ability_to_set", "string", "Boomerang")
	
	//send mana packet
	network_modify_player_property(caster.socket, "mana", "f32", caster.mana)
}

function spell_voodoo_doll(caster, target)
{
	var cast_radius = 500
	if point_distance(caster.x, caster.y, target[0], target[1]) <= cast_radius
	{
		var mana_cost = 30
		if caster.mana < mana_cost exit;
		caster.mana -= mana_cost
		
		var voodoo_doll = instance_create_layer(target[0], target[1], "Instances", obj_VoodooDoll)
		with voodoo_doll{
			network_id = new_network_id()
			owner = caster
		}
		
		//send packet to all players to create a voodoo doll
		network_create_object("obj_VoodooDoll", voodoo_doll.network_id, voodoo_doll.x, voodoo_doll.y)
		//send cooldown packets
		network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 240)
		network_modify_player_property(caster.socket, "ability_to_set", "string", "Voodoo Doll")
		
		//send mana packet
		network_modify_player_property(caster.socket, "mana", "f32", caster.mana)
	}
}

function spell_pillar(caster, target)
{
	//To implement: make sure only placed on ground/walls 
	/*
	angle = point_direction(caster.x, caster.y, target[0], target[1]);
	
	cast_dir = !(angle >= 90 && angle <= 270); //Determines if facing left (-) or right (+)
		
	var pillar = instance_create_layer(clamp(caster.x + caster.sprite_width*cast_dir, 0, room_width), caster.y, "Instances", obj_Pillar);
			
	with pillar{
		network_id = new_network_id();
		owner = caster;
	}
	
	//send packet to all players to create a pillar
	network_create_object("obj_Pillar", pillar.network_id, pillar.x, pillar.y)*/
	
}

function spell_pulse(caster, target)
{
	/*//This function is only used as part of the pillar spell
	
	var pulse = instance_create_layer(target[0], target[1], "Instances", obj_Pulse);
	
	with pulse{
		owner = caster;
		network_id = new_network_id();
	}
	
	//Send packet to create pulse obj
	network_create_object("obj_Pulse", pulse.network_id, pulse.x, pulse.y);
	network_modify_property(pulse.network_id, "owner", "u16", caster.socket);*/
}

function spell_thorns(caster, target)
{
	var CAST_RADIUS = 350;
	
	if((point_distance(caster.x, caster.y, target[0], target[1]) <= CAST_RADIUS) and (!place_meeting(target[0], target[1], obj_Player)))
	{
		var mana_cost = 20
		if caster.mana < mana_cost exit;
		caster.mana -= mana_cost
		var thorns = instance_create_layer(target[0], target[1], "Instances", obj_Thorns);
		
		with thorns{
			network_id = new_network_id();
			owner = caster;
		}
	
		network_create_object("obj_Thorns", thorns.network_id, thorns.x, thorns.y);
		//send cooldown packets
		network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 60)
		network_modify_player_property(caster.socket, "ability_to_set", "string", "Thorns")
	
		//send mana packet
		network_modify_player_property(caster.socket, "mana", "f32", caster.mana)
	}
}

function spell_totem(caster, target)
{
	var cast_radius = 350
	if(point_distance(caster.x, caster.y, target[0], target[1]) <= cast_radius)
	{
		var mana_cost = 20
		if caster.mana < mana_cost exit;
		caster.mana -= mana_cost
		
		var totem = instance_create_layer(target[0], target[1], "Instances", obj_Totem);
		
		with totem{
			network_id = new_network_id();
			owner = caster;
		}
	
		network_create_object("obj_Totem", totem.network_id, totem.x, totem.y);
		//send cooldown packets
		network_modify_player_property(caster.socket, "cooldown_to_set", "f32", 480)
		network_modify_player_property(caster.socket, "ability_to_set", "string", "Totem")
	
		//send mana packet
		network_modify_player_property(caster.socket, "mana", "f32", caster.mana)
	}
}