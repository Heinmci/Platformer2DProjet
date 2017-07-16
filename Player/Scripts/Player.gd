extends "res://Script/character.gd"

# Grounded?
var grounded = false 
 
# Jumping
var can_jump = false
var jump_time = 0
const TOP_JUMP_TIME = 0.1 # in seconds

var number_of_lifes = 1
var anim = ""
var siding_left = false

var popup_shown = false

var armed = false
 
# Start
func _ready():
    # Set player properties
	set_fixed_process(true)
	set_process_input(true)
	acceleration = 1000
	top_move_speed = 150
	top_jump_speed = 400
	if (Globals.has("number_of_lifes")):
		number_of_lifes = Globals.get("number_of_lifes")
 
func _fixed_process(delta):
    if (number_of_lifes == 0):
        number_of_lifes = 1
        Globals.set("number_of_lifes", number_of_lifes)
        get_tree().change_scene("res://Scenes/MainMenu.tscn")

# Apply force
func apply_force(state):

    var new_anim = anim
    var new_siding_left = siding_left

    # Move Left
    if(Input.is_action_pressed("ui_left")):
        directional_force += DIRECTION.LEFT
        if (!armed):
            new_anim = "runv2"
        else:
            new_anim = "run_armed"
        new_siding_left = true
     
    # Move Right
    if(Input.is_action_pressed("ui_right")):
        directional_force += DIRECTION.RIGHT
        if (!armed):
            new_anim = "runv2"
        else:
            new_anim = "run_armed"
        new_siding_left = false
     
    # Jump
    if(Input.is_action_pressed("ui_select") && grounded):
        directional_force += DIRECTION.UP
        new_anim = "stop"

         
    # The player does nothing
    if (!Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right") && !Input.is_action_pressed("ui_select")):
        new_anim = "stop"

    # While on the ground
    if(grounded):
        can_jump = true
        jump_time = 0
        
    # Change animation
    if (new_anim != "" && new_anim != anim):
        if (new_anim != "stop"):
            anim = new_anim
            get_node("AnimationPlayer").play(anim)
        else:
            anim = new_anim
            get_node("AnimationPlayer").stop()

    # Change player side
    if (new_siding_left != siding_left):
        if (new_siding_left):
            get_node("Sprite").set_scale(Vector2(-1, 1))
        else:
            get_node("Sprite").set_scale(Vector2(1, 1))
        siding_left = new_siding_left

    # Attack
    if Input.is_action_pressed("attack"):
        get_node("AnimationPlayer").stop()
        if (armed):
            get_node("AnimationPlayer").play("attack")

func _on_ground_check_body_enter( body ):
    grounded = true
    #When player is grounded the friction has to be set to 1
    set_friction(1)


func _on_ground_check_body_exit( body ):
    grounded = false
    #When player is on air the friction has to be set to 0
    set_friction(0)


func _on_item_check_area_enter( area ):
    if (area.get_name() == "sword_check"):
        area.get_parent().queue_free()
        armed = true
    if (area.get_name() == "obstacle_check"):
        number_of_lifes -= 1
        Globals.set("number_of_lifes", number_of_lifes)
        get_parent().get_node("LifeInfo/Label").set_text(str("Number of lives : ", number_of_lifes))

