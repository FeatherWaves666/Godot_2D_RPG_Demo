extends Node2D

func _ready():
	global.current_scene = "world"
	if global.is_first_player_loadin == true:
		$Player.position.x = global.player_start_posx
		$Player.position.y = global.player_start_posy
		global.is_first_player_loadin = false
	elif global.is_first_player_loadin == false:
		$Player.position.x = global.player_exit_cliffside_posx
		$Player.position.y = global.player_exit_cliffside_posy

func _process(delta):
	change_scene()


func _on_cliff_side_transition_area_body_entered(body):
	if body.has_method("player"):
		global.is_transition_scene = true
		global.will_scene = "cliff_side"


func _on_cliff_side_transition_area_body_exited(body):
	if body.has_method("player"):
		global.is_transition_scene = false
		global.will_scene = "none"

func change_scene():
	if global.is_transition_scene == true:
		if global.will_scene != "none":
			get_tree().change_scene_to_file("res://scene/" + global.will_scene + ".tscn")
			global.current_scene = global.will_scene
		
