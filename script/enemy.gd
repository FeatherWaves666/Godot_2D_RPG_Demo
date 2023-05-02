extends CharacterBody2D


const SPEED = 45
var is_chase_player = false
var player = null

func _physics_process(delta):
	if is_chase_player:
		position += (player.position - position) / SPEED
		if (player.position.x - position.x < 0):
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")

func _on_detection_player_body_entered(body):
	player = body
	is_chase_player = true


func _on_detection_player_body_exited(body):
	player = null
	is_chase_player = false
