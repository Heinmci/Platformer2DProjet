extends Node2D

export var value = 1

func _ready():
	if get_owner() != null:
		get_owner().coins_total += value
		get_owner().get_node("CoinsView/CoinsTotal").set_text(str(" / ",get_owner().coins_total))
		
	get_node("Area2D").connect("body_enter", self, "_collect_coin")
	
	
func _collect_coin( body ):
	if get_owner() != null:
		get_owner().coins_collected += value
		print(get_owner().coins_collected)
		Globals.set("coins_collected",get_owner().coins_collected)
		get_owner().get_node("CoinsView/CoinsCollected").set_text(str("Coins : ",get_owner().coins_collected))	
	
	queue_free()
