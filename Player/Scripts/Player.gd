extends "res://Script/character.gd"

# Grounded?
var grounded = false 
 
# Jumping
var can_jump = false
var jump_time = 0
const TOP_JUMP_TIME = 0.1 # in seconds
var popup_shown = false
 
# Start
func _ready():
    # Set player properties
	set_process_input(true)
	acceleration = 1000
	top_move_speed = 200
	top_jump_speed = 400
 
# Apply force
func apply_force(state):
    # Move Left
    if(Input.is_action_pressed("ui_left")):
        directional_force += DIRECTION.LEFT
     
    # Move Right
    if(Input.is_action_pressed("ui_right")):
        directional_force += DIRECTION.RIGHT
     
    # Jump
    if(Input.is_action_pressed("ui_select") && grounded):
        directional_force += DIRECTION.UP

    # Jump
#    if(Input.is_action_pressed("ui_select") && jump_time < TOP_JUMP_TIME && can_jump):
#        directional_force += DIRECTION.UP
#        jump_time += state.get_step()
#    elif(Input.is_action_just_released("ui_select")):
#    else:
#        can_jump = false # Prevents the player from jumping more than once while in air
     
    # While on the ground
    if(grounded):
        can_jump = true
        jump_time = 0
        

func _on_ground_check_body_enter( body ):
    grounded = true
    print("on ground")
    #When player is grounded the friction has to be set to 1
    set_friction(1)
    
     # Get groups
#    var groups = body.get_groups()
#
#    # If we are on a solid ground
#    if(groups.has("solid")):
#        grounded = true


func _on_ground_check_body_exit( body ):
    grounded = false
    print("on air")
    #When player is on air the friction has to be set to 0
    set_friction(0)

    # Get groups
#    var groups = body.get_groups()
#     
#    # If we are on a solid ground
#    if(groups.has("solid")):
#        grounded = false
