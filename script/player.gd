extends CharacterBody2D


const SPEED = 100.0
var current_dir = "none"
@onready var anim = $AnimatedSprite2D

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	if Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -SPEED
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = SPEED
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = SPEED
		velocity.y = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()

func play_anim(is_move):
	var dir = current_dir
	
	
	if dir == "right":
		anim.flip_h = false
		if is_move == 1:
			anim.play("side_walk")
		else:
			anim.play("side_idle")
	elif dir == "left":
		anim.flip_h = true
		if is_move == 1:
			anim.play("side_walk")
		else:
			anim.play("side_idle")	
	elif dir == "up":
		anim.flip_h = false
		if is_move == 1:
			anim.play("back_walk")
		else:
			anim.play("back_idle")
	elif dir == "down":
		anim.flip_h = false
		if is_move == 1:
			anim.play("front_walk")
		else:
			anim.play("front_idle")
		
		
