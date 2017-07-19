extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var selected_item = -1
var max_items = 2
var currently_hidden = true
var itemlist

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	#get_tree().set_pause(true)
	itemlist = get_node("Items")
	var test = preload("res://Images/apple.png")
	itemlist.add_item("Lives (" + str(Globals.get("number_of_lifes")) + ")",test,true)
	test = preload("res://Images/single_coin.png")
	itemlist.add_item("Coins (" + str(Globals.get("coins_collected")) + ")",test,true)
	if (Globals.get("has_sword")):
		var sword_image = preload("res://Images/sword.png")
		itemlist.add_item("Sword",sword_image,true)
	if (Globals.get("has_spear")):
		var sword_image = preload("res://Images/small_spear.png")
		itemlist.add_item("Spear",sword_image,true)
	if (Globals.get("central_recall_potion") > 0):
		var potion = preload("res://Images/potion.png")
		itemlist.add_item("Central Recall potion (" + str(Globals.get("central_recall_potion")) + ")",potion,true)
	set_hidden(true)
	pass

func _input(event):
	if (event.is_action_pressed("i_key")):
		if (currently_hidden):
			set_hidden(false)
			currently_hidden = false
			get_tree().set_pause(true)
			update_inventory_info()
		else:
			set_hidden(true)
			currently_hidden = true
			get_tree().set_pause(false)
		#get_tree().change_scene("res://Scenes/Inventory.tscn")
	elif(event.is_action_pressed("ui_down")):
		max_items = get_node("Items").get_item_count()
		if (selected_item +1 < max_items):
			selected_item +=1
			get_node("Items").select(selected_item,true)
		print(selected_item)
	elif(event.is_action_pressed("ui_up")):
		if (selected_item -1 >= 0):
			selected_item -=1
			get_node("Items").select(selected_item,true)
	elif(event.is_action_pressed("ui_accept")):
		print("aeazeaze")
		selected_something()


func update_inventory_info():
	for i in range(get_node("Items").get_item_count()):
		if (itemlist.get_item_text(i).findn("Lives") != -1):
			itemlist.set_item_text(i,"Lives (" + str(Globals.get("number_of_lifes")) + ")")
		elif (itemlist.get_item_text(i).findn("Coins") != -1):
			itemlist.set_item_text(1,"Coins (" + str(Globals.get("coins_collected")) + ")")

func selected_something():
	if (itemlist.get_item_text(selected_item) == "Sword"):
		Globals.set("equipped_weapon","sword")
		print(Globals.get("equipped_weapon"))
	elif (itemlist.get_item_text(selected_item) == "Spear"):
		Globals.set("equipped_weapon","spear")
	if (itemlist.get_item_text(selected_item).findn("Central Recall potion") != -1):
		var potion_count = Globals.get("central_recall_potion")
		if (potion_count > 0):
			Globals.set("central_recall_potion",potion_count-1)
			set_hidden(true)
			currently_hidden = true
			get_tree().set_pause(false)
			get_tree().change_scene("res://Scenes/Levels/LevelCentrale/Stage.tscn")