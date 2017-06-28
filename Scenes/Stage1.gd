extends Node2D

var jetons_total = 0
var jetons_pris = 0

var popup_shown = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	pass
	
func _process(delta):
	if (Input.is_action_pressed("i_key")):
		if (!popup_shown):
			print("Toggled false")
			var scene = load("res://Scenes/Inventory.tscn")
			var node = scene.instance()
			node.set_pos(get_pos())
			
			get_parent().add_child(node)
			get_parent().get_node("Inventory").popup_centered()
			popup_shown = true
		else:
			print("Toggled true")
			get_parent().get_node("Inventory").queue_free()
			popup_shown = false
		#get_tree().change_scene("res://Scenes/Inventory.tscn")

