extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var shop
var interaction_info
var buy_result

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	interaction_info = get_parent().get_parent().get_node("InteractionInfo")
	buy_result = get_parent().get_parent().get_node("BuyResult")
	interaction_info.hide()
	buy_result.hide()
	set_process_input(true)
	connect("body_exit",self,"_on_Area2D_body_exit")
	connect("body_enter",self,"_on_Area2D_body_enter")
	shop = get_parent().get_parent().get_node("Shop")
	pass

func _input(event):
	if (event.is_action_pressed("e_key") && overlaps_body(get_parent().get_parent().get_node("Player"))):
		shop.show()
		interaction_info.hide()

func _on_Area2D_body_enter(body):
	if (body.get_name() == "Player"):
		interaction_info.show()
			
func _on_Area2D_body_exit(body):
	if (body.get_name() == "Player"):
		shop.hide()
		interaction_info.hide()
		buy_result.hide()