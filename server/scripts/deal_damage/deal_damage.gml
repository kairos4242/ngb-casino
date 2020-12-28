// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function deal_damage(amount, source, target){
	//will be more here later, just encapsulating this for ease of use later on
	target.hp -= amount
	
	//we could put the network calls here, not sure what the impacts of that design decision are
	//warrants further study
}