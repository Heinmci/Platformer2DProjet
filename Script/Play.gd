extends TextureButton

func pressed():
	get_tree().change_scene("res://Scenes/Levels/LevelCentrale/Stage.tscn")
	Globals.set("number_of_lifes",1)
	Globals.set("has_sword",false)
	Globals.set("current_level",1)
	Globals.set("Level1_apple",false)
	Globals.set("level2_apple",false)
	Globals.set("LevelCentrale_apple",false)

