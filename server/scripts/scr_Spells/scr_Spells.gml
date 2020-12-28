// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//Target is an array of [x, y] so target[0] will get target xpos and target[1] will get target ypos

function spell_basic_attack(caster, target){
	basic_projectile_speed = 10
	cast_direction = point_direction(caster.x, caster.y, target[0], target[1])
	var basic_projectile = instance_create_layer(caster.x + lengthdir_x(caster.sprite_width, cast_direction), caster.y + lengthdir_y(caster.sprite_height, cast_direction), "Instances", obj_BasicProjectile)
	with basic_projectile {
		owner = caster//for purposes of checking hit
		network_id = new_network_id()
		image_angle = other.cast_direction
		x_speed = lengthdir_x(other.basic_projectile_speed, other.cast_direction)
		y_speed = lengthdir_y(other.basic_projectile_speed, other.cast_direction)
	}
	//send packet to all players to create a fireball object then send a packet to change fireball angle
	network_create_object("obj_BasicProjectile", basic_projectile.network_id, basic_projectile.x, basic_projectile.y)
	network_modify_property(basic_projectile.network_id, "image_angle", "u16", cast_direction)
	network_modify_property(basic_projectile.network_id, "x_speed", "s16", lengthdir_x(basic_projectile_speed, cast_direction))
	network_modify_property(basic_projectile.network_id, "y_speed", "s16", lengthdir_y(basic_projectile_speed, cast_direction))
}

function spell_fireball(caster, target){
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
}

function spell_refresh_jumps(caster, target){
	//change server side
	caster.jumps = caster.max_jumps
	
	//change client side
	network_modify_player_property(caster.socket, "jumps", "u16", caster.max_jumps)
}

function spell_swap_places(caster, target){
	//update server representation
	target_object = collision_point(target[0], target[1], obj_Player, false, true)
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
}

function spell_wall(caster, target){
	//server implementation
	cast_direction = point_direction(caster.x, caster.y, target[0], target[1])
	cast_direction = round(cast_direction / 90) * 90 //round to the nearest 90 degrees
	var wall = instance_create_layer(caster.x + 2 * lengthdir_x(caster.sprite_width, cast_direction), caster.y + 2 * lengthdir_y(caster.sprite_height, cast_direction), "Instances", obj_Wall)
	with wall {
		image_angle = other.cast_direction
		image_yscale = 3
		network_id = new_network_id()
	}
	
	//network implementation
	network_create_object("obj_Wall", wall.network_id, wall.x, wall.y)
	network_modify_property(wall.network_id, "image_angle", "u16", wall.image_angle)
	network_modify_property(wall.network_id, "image_yscale", "u16", wall.image_yscale)
	
}

function spell_passive_jump_height_increase(caster, target){
	jump_passive = {
		passive_id: "0000",
		name: "Antigravity Passive",
		type: "Subtract",
		unique: true,
		passive_target: caster,
		passive_source: caster,
		passive_target_variable: "grav"
	}
	create_effect(jump_passive, caster, target)
}

function spell_turret(caster, target){
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
}

function spell_heal(caster, target){
	//just a self heal right now, target does nothing
	//can be changed later if game design team wants to make it more versatile
	heal_amount = 7
	caster.hp = min(caster.max_hp, caster.hp + heal_amount)
	network_modify_player_property(caster.socket, "hp", "u16", caster.hp)
}