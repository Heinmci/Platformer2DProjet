extends TextureButton

func pressed():
	get_tree().change_scene("res://Scenes/Levels/LevelCentrale/Stage.tscn")
	Globals.set("number_of_lifes",2)
	Globals.set("has_sword",false)
	Globals.set("has_spear",false)
	Globals.set("current_level",1)
	Globals.set("Level1_apple",false)
	Globals.set("level2_apple",false)
	Globals.set("LevelCentrale_apple",false)
	Globals.set("coins_collected",0)
	Globals.set("equipped_weapon","none")
	Globals.set("central_recall_potion",0)

