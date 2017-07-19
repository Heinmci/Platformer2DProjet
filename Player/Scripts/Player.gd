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
	get_node("attack_ennemy_check").hide()
	if (Globals.has("number_of_lifes")):
		number_of_lifes = Globals.get("number_of_lifes")
	if Globals.get("has_sword"):
		armed = Globals.get("has_sword")
	if Globals.get("has_spear"):
		armed = Globals.get("has_spear")
 
func _fixed_process(delta):
    if (number_of_lifes == 0):
        number_of_lifes = 1
        Globals.set("number_of_lifes", number_of_lifes)
        get_tree().change_scene("res://Scenes/GameOver.tscn")

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
            if Globals.get("has_sword"):
                new_anim = "run_armed"
            if Globals.get("has_spear"):
               new_anim = "run_with_spear"
        new_siding_left = true
     
    # Move Right
    if(Input.is_action_pressed("ui_right")):
        directional_force += DIRECTION.RIGHT
        if (!armed):
            new_anim = "runv2"
        else:
            if Globals.get("has_sword"):
               new_anim = "run_armed"
            if Globals.get("has_spear"):
               new_anim = "run_with_spear"
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
            if Globals.get("has_sword") == true:
                get_node("AnimationPlayer").play("attack")
            if Globals.get("has_spear") == true:
                get_node("AnimationPlayer").play("attack_with_spear")
            get_node("attack_ennemy_check").show()
    else:
        get_node("attack_ennemy_check").hide()

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
		Globals.set("has_sword",true)
		deal_with_inventory()
		if !Globals.get("has_spear"):
			area.get_parent().queue_free()
			armed = true
			Globals.set("has_sword",true)
			Globals.set("has_spear",false)
		else:
			if Input.is_action_pressed("e_key"):
				area.get_parent().queue_free()
				armed = true
				Globals.set("has_sword",true)
				Globals.set("has_spear",false)
	if (area.get_name() == "spear_check"):
		if !Globals.get("has_sword"):
			area.get_parent().queue_free()
			armed = true
			Globals.set("has_spear",true)
			Globals.set("has_sword",false)
		else:
			if Input.is_action_pressed("e_key"):
				area.get_parent().queue_free()
				armed = true
				Globals.set("has_spear",true)
				Globals.set("has_sword",false)
	if (area.get_name() == "obstacle_check"):
		number_of_lifes -= 1
		Globals.set("number_of_lifes", number_of_lifes)
		get_parent().get_node("LifeInfo/Label").set_text(str("Number of lives : ", number_of_lifes))



func _on_attack_ennemy_check_area_enter( area ):
    if get_node("attack_ennemy_check").is_visible():
        print(area.get_name())

func deal_with_inventory():
	var itemlist = get_node("Camera2D/Inventory/Items")
	var sword_in_inventory = false
	for i in range(itemlist.get_item_count()):
		if (itemlist.get_item_text(i) == "Sword"):
			sword_in_inventory = true
	if (!sword_in_inventory):
		var sword_image = preload("res://Images/sword.png")
		itemlist.add_item("Sword",sword_image,true)

