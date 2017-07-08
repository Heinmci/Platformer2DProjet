extends Node2D

var coins_total = 0
var coins_collected = 0



func _ready():
	pass



func _on_Area2D_body_enter( body ):
	if (body.get_name() == "Player"):
		get_node("YOUWIN").show()
		get_tree().change_scene("res//Scenes/Levels/Level2/Stage.tscn")
