extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var lives = get_parent().get_node("Player").number_of_lifes;
	get_node("Label").set_text(str("Number of lifes : ",lives))
	
	pass
