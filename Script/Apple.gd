extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	pass

func _input(event):
	if (event.is_action_pressed("e_key") && overlaps_body(get_parent().get_parent().get_node("Player"))):
		print(get_pos())
		get_parent().queue_free()
		get_parent().get_parent().get_node("Player").number_of_lifes += 1
		var lives = Globals.get("number_of_lifes")
		Globals.set("number_of_lifes",lives +1)
		get_parent().get_parent().get_node("LifeInfo/Label").set_text(str("Number of lives : ",lives + 1))
		
		