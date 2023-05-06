extends CharacterBody2D


const SPEED = 45
var is_chase_player = false
var player = null
var health = 100
var is_player_inattack_zone = false
var is_can_taking_damage = true


func _physics_process(delta):
	deal_with_damage()
	update_health()
	
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
	
func enemy():
	pass
	
	
#这段代码是用 GDScript 编写的，它是 Godot 引擎的内置脚本语言。这段代码的功能是让一个继承自 CharacterBody2D 的节点（可能是一个敌人或者怪物）在检测到玩家时追踪玩家，而在失去玩家时停止追踪。代码的解释如下：
#
#- 第一行 `extends CharacterBody2D` 表示这个脚本继承自 CharacterBody2D 类，这是一个用于创建具有物理属性的角色的类。
#- 第二行 `const SPEED = 50` 定义了一个常量 SPEED，表示节点追踪玩家的速度。
#- 第三行 `var is_chase_player = false` 定义了一个变量 is_chase_player，表示节点是否正在追踪玩家，初始值为 false。
#- 第四行 `var player = null` 定义了一个变量 player，表示玩家节点的引用，初始值为 null。
#- 第六行 `func _physics_process(delta):` 定义了一个内置函数 _physics_process，它会在每一帧根据物理时间间隔 delta 被调用。
#- 第七行 `if is_chase_player:` 判断是否正在追踪玩家。
#- 第八行 `position += (player.position - position) / SPEED` 更新节点的位置，让它朝着玩家的方向移动，移动距离与 SPEED 和 delta 成正比。
#- 第十一行 `func _on_detection_player_body_entered(body):` 定义了一个信号处理函数 _on_detection_player_body_entered，它会在节点的子节点 detection_player（可能是一个 Area2D）检测到一个物理体进入时被调用，参数 body 是进入的物理体。
#- 第十二行 `player = body` 将 player 的值设为 body，即检测到的物理体。
#- 第十三行 `is_chase_player = true` 将 is_chase_player 的值设为 true，表示开始追踪玩家。
#- 第十六行 `func _on_detection_player_body_exited(body):` 定义了一个信号处理函数 _on_detection_player_body_exited，它会在节点的子节点 detection_player 检测到一个物理体离开时被调用，参数 body 是离开的物理体。
#- 第十七行 `player = null` 将 player 的值设为 null，表示没有玩家节点的引用。
#- 第十八行 `is_chase_player = false` 将 is_chase_player 的值设为 false，表示停止追踪玩家。


func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		is_player_inattack_zone = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		is_player_inattack_zone = false
		
func deal_with_damage():
	if is_player_inattack_zone and global.is_player_current_attack:
		if is_can_taking_damage:
			health -= 20
			print("slime health:", health)
			$take_damage_cooldown.start()
			is_can_taking_damage = false
			if health <= 0:
				self.queue_free()


func _on_take_damage_cooldown_timeout():
	is_can_taking_damage = true

func update_health():
	var health_bar = $Health_bar
	health_bar.value = health
	
	if health < 100:
		health_bar.visible = true
	elif health >= 100:
		health_bar.visible = false
