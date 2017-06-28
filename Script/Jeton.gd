extends Area2D

# Member variables
var taken = false
export var value = 1


func _on_body_enter( body ):
	if (not taken and body extends preload("res://Scenes/Levels/Level1/Player.gd")):
		get_node("AnimJeton").play("taken")
		taken = true

func _on_coin_area_enter(area):
	pass # replace with function body


func _on_coin_area_enter_shape(area_id, area, area_shape, area_shape):
	pass # replace with function body

