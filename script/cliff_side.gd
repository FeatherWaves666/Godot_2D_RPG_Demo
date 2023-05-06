extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	global.current_scene = "cliff_side"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()


func _on_world_transition_area_body_entered(body):
	if body.has_method("player"):
		global.is_transition_scene = true
		global.will_scene = "world"


func _on_world_transition_area_body_exited(body):
	if body.has_method("player"):
		global.is_transition_scene = false
		global.will_scene = "world"

func change_scene():
	if global.is_transition_scene == true:
		if global.will_scene != "none":
			get_tree().change_scene_to_file("res://scene/" + global.will_scene + ".tscn")
			global.current_scene = "world"
