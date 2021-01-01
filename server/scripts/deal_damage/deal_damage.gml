// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function deal_damage(amount, source, target){
	//will be more here later, just encapsulating this for ease of use later on
	target.hp -= amount
	
	//we could put the network calls here, not sure what the impacts of that design decision are
	//warrants further study
	
	//next, check for death
	if target.hp <= 0
	{
		//first set hp to 0 to avoid buffer overflow when sending hp
		target.hp = 0
		
		//target has been killed, check what target is
		if (object_get_name(target.object_index) == "obj_Player")
		{
			//a player has been killed, so we need to end the game for that player
			show_debug_message("Player killed: " + string(target.socket))
			target.sprite_index = spr_DeadPlayer
			target.alive = 0
			with obj_Server
			{
				network_kill_player(other.target.socket)	
			}
			//if only one player left alive, declare victory for that player
			alive_count = 0
			alive_player = -1
			for (i = 0; i < instance_number(obj_Player); i++)
			{
				if (instance_find(obj_Player, i).alive == 1)
				{
					//player is alive, add one to our alive count
					//note checking based on sprite is kinda hacky and we should probably
					//have a boolean is_alive or something instead
					alive_count++
					alive_player = instance_find(obj_Player, i)
				}
			}
			if alive_count == 1
			{
				//only one player alive, declare victory for said player
				with obj_Server
				{
					network_declare_victory(other.alive_player.socket, other.alive_player.username)
				}
			}
		}
		else
		{
			//not a player so we can just send a network_destroy_object
			with obj_Server
			{
				network_destroy_object(other.target.network_id)
			}
		}
	}
}