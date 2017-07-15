extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_LoadGame_pressed():
	pass # replace with function body
	load_game()
	get_tree().change_scene("res://Scenes/Levels/LevelCentrale/Stage.tscn")
	if (!Globals.has("number_of_lifes")):
		Globals.set("number_of_lifes",1)
		

func load_game():
	var savegame = File.new()
	if !savegame.file_exists("user://savegame.save"):
		return #Error!  We don't have a save to load
	var currentline = {} # dict.parse_json() requires a declared dict.
	savegame.open("user://savegame.save", File.READ)
	while (!savegame.eof_reached()):
		currentline.parse_json(savegame.get_line())
		Globals.set("number_of_lifes",currentline["number_of_lifes"])
	savegame.close()