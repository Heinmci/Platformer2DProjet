extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    get_node("AnimationPlayer").play("top_down_anmation")
    get_node("sword_check").connect("body_enter", self, "_collect_sword")
    if (Globals.get("has_sword")):
        queue_free()

func _collect_sword( body ):
    #queue_free()
    pass
