extends CharacterBody2D

@export var speed = 400
@export var acceleration = 1500
@export var friction = 1200

@onready var axis = Vector2.ZERO

var playerBullet = preload("res://Scenes/PlayerBullet.tscn")
var canShoot = true

var spawnPos1
var spawnPos2
var muzzleFlash1
var muzzleFlash2

var game_running : bool

func _ready():
	spawnPos1 = $SpawnPos1
	spawnPos2 = $SpawnPos2
	muzzleFlash1 = $Muzzleflash1
	muzzleFlash2 = $Muzzleflash2

func _physics_process(delta):
	move(delta)

func get_input_axis():
	axis.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	return axis.normalized()

func move(delta):
	axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		apply_friction(friction * delta)
	else:
		apply_movement(axis * acceleration * delta)
	
	move_and_slide()

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(speed)

func _on_shoot_speed_timeout():
	canShoot = true

func _process(_delta):
	if Input.is_action_pressed("Shoot") and canShoot:
		shoot()

func shoot():
	# Spawn Position 1
	var bullet = playerBullet.instantiate()
	bullet.position = spawnPos1.global_position
	get_tree().current_scene.add_child(bullet)
	
	muzzleFlash1.play("MuzzleFlash")
	$ShootSpeed.start()
	canShoot = false
	
	# Spawn Position 2
	var bullet2 = playerBullet.instantiate()
	bullet2.position = spawnPos2.global_position
	get_tree().current_scene.add_child(bullet2)
	
	muzzleFlash2.play("Muzzleflash2")
	$ShootSpeed.start()
	canShoot = false

func player_hit():
	Global.health -= 1
	if Global.health <= 0:
		get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")
		queue_free()
		print("MORISTE")
