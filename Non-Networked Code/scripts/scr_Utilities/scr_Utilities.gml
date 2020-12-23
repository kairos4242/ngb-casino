
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function create_effect(effect_to_create, effect_caster, effect_target){
	//Create effect and add both to relevant players and to global effect list
	//Effect is in the form of a struct
	//right now effect_caster and effect_target unused, both built into effect struct
	
	//if effect is unique, check if it already exists first
	var global_effect_list = global.game_controller.effect_list
	if (effect_to_create.unique == true)
	{
		for (i = 0; i < array_length(global_effect_list); i++)
		{
			if ((global_effect_list[i].id == effect_to_create.id) && (global_effect_list[i].passive_target == effect_to_create.passive_target))
			{
				//effect already exists, so break
				exit;
			}
		}
	}
	//either effect unique and not included, or effect not unique so let's append it to both the effect target and the global list
	array_push(global_effect_list, effect_to_create)
	array_push(effect_to_create.passive_target.effect_list, effect_to_create)
}