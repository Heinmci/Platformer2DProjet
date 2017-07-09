extends TextureButton

func pressed():
	get_tree().change_scene("res://Scenes/Levels/LevelCentrale/Stage.tscn")
	if (!Globals.has("number_of_lifes")):
		Globals.set("number_of_lifes",1)

