extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var selected_item = -1
var max_items = 2
var currently_hidden = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	#get_tree().set_pause(true)
	determine_inventory_content()
	var test = preload("res://Images/apple.png")
	get_node("Items").add_item("Apple",test,true)
	test = preload("res://Images/coin.png")
	get_node("Items").add_item("Coin",test,true)
	set_hidden(true)
	pass

func _input(event):
	if (event.is_action_pressed("i_key")):
		if (currently_hidden):
			set_hidden(false)
			currently_hidden = false
			get_tree().set_pause(true)
		else:
			set_hidden(true)
			currently_hidden = true
			get_tree().set_pause(false)
		#get_tree().change_scene("res://Scenes/Inventory.tscn")
	elif(event.is_action_pressed("ui_down")):
		if (selected_item +1 < max_items):
			selected_item +=1
			get_node("Items").select(selected_item,true)
		print(selected_item)
	elif(event.is_action_pressed("ui_up")):
		if (selected_item -1 >= 0):
			selected_item -=1
			get_node("Items").select(selected_item,true)


func determine_inventory_content():
	