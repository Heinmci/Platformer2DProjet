extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var scene_path = ""

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	scene_path = "res://Scenes/Levels/" + get_parent().get_name() + "/Stage.tscn"
	pass
	
func _input(event):
	if (event.is_action_pressed("e_key") && overlaps_body(get_parent().get_parent().get_node("Player"))):
		print(scene_path)
		print(get_pos())
		get_tree().change_scene(scene_path)
	
	
func body_enter(body):
	print(body)
	
func _on_body_enter(body):
    print("Body entered the area")
