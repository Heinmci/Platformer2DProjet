extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var selected_item = -1
var itemlist
var currently_hidden = true
var max_items = 0
var life_cost = 20

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	itemlist = get_node("ItemList")
	setup_shop()
	hide()
	pass

func _input(event):
	if(event.is_action_pressed("ui_down")):
		max_items = get_node("ItemList").get_item_count()
		if (selected_item +1 < max_items):
			selected_item +=1
			itemlist.select(selected_item,true)
		print(selected_item)
	elif(event.is_action_pressed("ui_up")):
		if (selected_item -1 >= 0):
			selected_item -=1
			itemlist.select(selected_item,true)
	elif(event.is_action_pressed("ui_accept") && !is_hidden()):
		selected_something()
func setup_shop():
	var apple = preload("res://Images/apple.png")
	itemlist.add_item("1 life for 5 coins",apple,true)
	
func selected_something():
	if (itemlist.get_item_text(selected_item) == "1 life for 5 coins"):
		get_parent().get_node("BuyResult").show()
		var player_coins = Globals.get("coins_collected")
		if (player_coins >= life_cost):
			Globals.set("coins_collected",player_coins - life_cost)
			var player_lives = Globals.get("number_of_lifes")
			Globals.set("number_of_lifes",player_lives+1)
			get_parent().get_node("BuyResult").set_text("You just bought a life")
		elif (player_coins < life_cost):
			get_parent().get_node("BuyResult").set_text("You don't have enough coins")