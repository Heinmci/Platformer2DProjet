extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	determine_already_eaten()
	connect("body_exit",self,"_on_Area2D_body_exit")
	pass


func determine_already_eaten():
	var eaten = Globals.get(get_parent().get_parent().get_name() + "_apple")
	if (eaten):
		get_parent().queue_free()
		
func _input(event):
	if (event.is_action_pressed("e_key") && overlaps_body(get_parent().get_parent().get_node("Player"))):
		print(get_pos())
		get_parent().queue_free()
		get_parent().get_parent().get_node("Player").number_of_lifes += 1
		var lives = Globals.get("number_of_lifes")
		Globals.set("number_of_lifes",lives +1)
		Globals.set(get_parent().get_parent().get_name() + "_apple",true)
		get_parent().get_parent().get_node("LifeInfo/Label").set_text(str("Number of lives : ",lives + 1))
		
		

func _on_Area2D_body_enter( body ):
	if (body.get_name() == "Player"):
		get_parent().get_node("TakeApple").show()
		
func _on_Area2D_body_exit( body ):
	if (body.get_name() == "Player"):
		get_parent().get_node("TakeApple").hide()