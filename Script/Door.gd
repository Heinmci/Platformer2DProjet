extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var scene_path = ""

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	get_parent().get_node("DoorLabel").set_text(get_parent().get_name())
	if (get_parent().get_parent().get_name() == "LevelCentrale"):
		determine_hidden_state()
	scene_path = "res://Scenes/Levels/" + get_parent().get_name() + "/Stage.tscn"
	connect("body_exit",self,"_on_Area2D_body_exit")
	pass
	
func _input(event):
	if (event.is_action_pressed("e_key") && overlaps_body(get_parent().get_parent().get_node("Player"))):
		if (get_parent().get_parent().get_name() == "Level4"):
			get_tree().change_scene("res://Scenes/MainMenu.tscn")
		if (get_parent().get_parent().get_name() != "LevelCentrale" && get_parent().get_parent().get_name() != "Merchant"):
			update_current_level()
		get_tree().change_scene(scene_path)

func update_current_level():
	var current_level = Globals.get("current_level")
	var new_level = int(get_parent().get_parent().get_name()[5]) + 1
	if (new_level > current_level):
		Globals.set("current_level",new_level)
	print(new_level)
	
func determine_hidden_state():
	if (get_parent().get_name() != "Merchant" && get_parent().get_name() != "LevelCentrale"):
		var current_level = Globals.get("current_level")
		var door_level = int(get_parent().get_name()[5])
		if (current_level < door_level):
			get_parent().hide()

func _on_Area2D_body_enter( body ):
	if (body.get_name() == "Player"):
		get_parent().get_node("Enter").show()
		
func _on_Area2D_body_exit( body ):
	if (body.get_name() == "Player"):
		get_parent().get_node("Enter").hide()
