extends CharacterBody2D

var BossBullet = preload("res://Scenes/BossBullet.tscn")

var canShoot = false
var player = null

var speed = 1
var health = 100

var travel = false
var startPos = 0
var distance = 300

var spawnPos1
var spawnPos2

# Called when the node enters the scene tree for the first time.
func _ready():
	startPos = position.x
	spawnPos1 = $SpawnPos1
	spawnPos2 = $SpawnPos2

func _on_detection_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _physics_process(_delta):
	var movement = Vector2(0, speed)
	
	if player:
		movement = Vector2(0, 0)
		_travel()
		shoot()
	
	movement = move_and_collide(movement)

func _travel():
	if position.x > startPos + distance:
		travel = false
	
	if position.x < startPos - distance:
		travel = true
		
	if travel == true:
		right()
	else:
		left()

func left():
	position.x -= 2

func right():
	position.x += 2

func _on_shoot_speed_timeout():
	canShoot = true

func shoot():
	if canShoot:
		# Spawn Position 1
		var bullet1 = BossBullet.instantiate()
		bullet1.position = spawnPos1.global_position
		get_parent().add_child(bullet1)
		
		$ShootSpeed.start()
		canShoot = false
		
		# Spawn Position 2
		var bullet2 = BossBullet.instantiate()
		bullet2.position = spawnPos2.global_position
		get_parent().add_child(bullet2)
		
		$ShootSpeed.start()
		canShoot = false

func enemy_hit():
	health -= 1
	if health <= 0:
		Global.score += 10000
		print("JEFE DERROTADO")
		queue_free()
	
	if health <= 0:
		get_tree().change_scene_to_file("res://Scenes/Victory.tscn")
