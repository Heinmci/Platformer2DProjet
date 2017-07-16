extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process_input(true)
	connect("body_exit",self,"_on_Area2D_body_exit")
	
func _input(event):
	if (event.is_action_pressed("e_key") && overlaps_body(get_parent().get_parent().get_node("Player"))):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _on_Area2D_body_enter( body ):
	if (body.get_name() == "Player"):
		get_parent().get_node("Enter").show()


func _on_Area2D_body_exit( body ):
	if (body.get_name() == "Player"):
		get_parent().get_node("Enter").hide()
