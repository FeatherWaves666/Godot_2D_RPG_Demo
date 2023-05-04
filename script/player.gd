extends CharacterBody2D

var is_enemy_inattack_range = false
var is_enemy_attack_cooldown = true
var health = 100
var is_player_alive = true

var is_attack_ip = false

const SPEED = 100.0
var current_dir = "none"
@onready var anim = $AnimatedSprite2D

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	if global.is_player_current_attack == false:
		player_movement(delta)
	enemy_attack()
	attack()
	
	if health <= 0:
		is_player_alive = false
		health = 0
		print("player has been killed")
		self.queue_free()
		
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
			if is_attack_ip == false:
				anim.play("side_idle")
	elif dir == "left":
		anim.flip_h = true
		if is_move == 1:
			anim.play("side_walk")
		else:
			if is_attack_ip == false:
				anim.play("side_idle")	
	elif dir == "up":
		anim.flip_h = false
		if is_move == 1:
			anim.play("back_walk")
		else:
			if is_attack_ip == false:
				anim.play("back_idle")
	elif dir == "down":
		anim.flip_h = false
		if is_move == 1:
			anim.play("front_walk")
		else:
			if is_attack_ip == false:
				anim.play("front_idle")
		
		
func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		is_enemy_inattack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		is_enemy_inattack_range = false

func enemy_attack():
	if is_enemy_inattack_range and is_enemy_attack_cooldown:
		health -= 20
		is_enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)

func _on_attack_cooldown_timeout():
	is_enemy_attack_cooldown = true

func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		global.is_player_current_attack = true
		is_attack_ip = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		elif dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		elif dir == "up":
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()
		elif dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.is_player_current_attack = false
	is_attack_ip = false
