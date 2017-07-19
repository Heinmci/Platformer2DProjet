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
		init_globals()
		
func init_globals():
	Globals.set("number_of_lifes",1)
	Globals.set("has_sword",false)
	Globals.set("current_level",1)
	Globals.set("Level1_apple",false)
	Globals.set("level2_apple",false)
	Globals.set("LevelCentrale_apple",false)
	Globals.set("coins_collected",0)
	
func load_game():
	var savegame = File.new()
	if !savegame.file_exists("user://savegame.save"):
		return #Error!  We don't have a save to load
	var currentline = {} # dict.parse_json() requires a declared dict.
	savegame.open("user://savegame.save", File.READ)
	while (!savegame.eof_reached()):
		currentline.parse_json(savegame.get_line())
		Globals.set("number_of_lifes",currentline["number_of_lifes"])
		Globals.set("has_sword",currentline["has_sword"])
		Globals.set("current_level",currentline["current_level"])
		Globals.set("Level1_apple",currentline["Level1_apple"])
		Globals.set("Level2_apple",currentline["Level2_apple"])
		Globals.set("LevelCentrale_apple",currentline["LevelCentrale_apple"])
		Globals.set("coins_collected",currentline["coins_collected"])
	savegame.close()