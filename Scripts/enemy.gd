extends CharacterBody2D

var player
var speed = 5
var canShoot = true
var enemyHealth = 6
var Bullet = preload("res://Scenes/EnemyBullet.tscn")
var Explosion = preload("res://Scenes/Explosion.tscn")

# Posiciones de spawneo de las balas
var spawnPos1
var spawnPos2
var spawnPos3
var spawnPos4

func _ready():
	spawnPos1 = $SpawnPos1
	spawnPos2 = $SpawnPos2
	spawnPos3 = $SpawnPos3
	spawnPos4 = $SpawnPos4

func _on_detection_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _physics_process(_delta):
	var movement = Vector2(0, -2)
	
	if player != null:
		movement = position.direction_to(player.position) * speed
	movement = move_and_collide(movement)

func _on_shoot_speed_timeout():
	canShoot = true
	if player != null:
		shoot()

func shoot():
	if canShoot:
		var bullet = Bullet.instantiate()
		
		# Spawn Position 1
		bullet.position = spawnPos1.global_position
		get_parent().add_child(bullet)
		$ShootSpeed.start()
		canShoot = false
		
		var bullet2 = Bullet.instantiate()
		
		# Spawn Position 2
		bullet2.position = spawnPos2.global_position
		get_parent().add_child(bullet2)
		$ShootSpeed.start()
		canShoot = false
		
		var bullet3 = Bullet.instantiate()
		
		# Spawn Position 1
		bullet3.position = spawnPos3.global_position
		get_parent().add_child(bullet3)
		$ShootSpeed.start()
		canShoot = false
		
		var bullet4 = Bullet.instantiate()
		
		# Spawn Position 1
		bullet4.position = spawnPos4.global_position
		get_parent().add_child(bullet4)
		$ShootSpeed.start()
		canShoot = false

func enemy_hit():
	enemyHealth -= 1
	print(enemyHealth)
	Global.score += 100
	if enemyHealth == 0:
		print("ENEMIGO MUERTO")
		queue_free()
	
	if enemyHealth == 0:
		Global.camera.screen_shake(5, 5, 0.05)
		var explosion = Explosion.instantiate()
		explosion.global_position = global_position
		get_tree().current_scene.add_child(explosion)
