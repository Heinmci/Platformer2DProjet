extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var scene_path = ""

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	connect("body_exit",self,"_on_Area2D_body_exit")
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
		number_of_lifes=Globals.get("number_of_lifes"),
		has_sword=Globals.get("has_sword"),
		has_spear=Globals.get("has_spear"),
		current_level=Globals.get("current_level"),
		LevelCentrale_apple=Globals.get("LevelCentrale_apple"),
		Level1_apple=Globals.get("Level1_apple"),
		Level2_apple=Globals.get("Level2_apple"),
		coins_collected=Globals.get("coins_collected"),
		equipped_weapon=Globals.get("equipped_weapon"),
		central_recall_potion=Globals.get("central_recall_potion")
	}
	return savedict

func _on_Area2D_body_exit( body ):
	if (body.get_name() == "Player"):
		get_parent().get_node("saved_game").hide()