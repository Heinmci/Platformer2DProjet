extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var scene_path = ""

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	pass
	
func _input(event):
	if (event.is_action_pressed("e_key") && overlaps_body(get_parent().get_parent().get_node("Player"))):
		#print(Globals.save())
		save_game()
		get_parent().get_node("saved_game").show()

func save_game():
    var savegame = File.new()
    savegame.open("user://savegame.save", File.WRITE)
    var nodedata = save()
    savegame.store_line(nodedata.to_json())
    savegame.close()

func save():
    var savedict = {
       number_of_lifes=Globals.get("number_of_lifes")
    }
    return savedict