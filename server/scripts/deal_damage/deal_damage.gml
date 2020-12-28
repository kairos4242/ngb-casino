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
		//target has been killed, check what target is
		if (object_get_name(target.object_index) == "obj_Player")
		{
			//a player has been killed, so we need to end the game for that player
			show_debug_message("Player killed: " + string(target.socket))
			target.sprite_index = spr_DeadPlayer
			with obj_Server
			{
				network_kill_player(other.target.socket)
				
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