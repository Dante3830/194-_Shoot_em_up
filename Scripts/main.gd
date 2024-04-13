extends Node

var Enemy = preload("res://Scenes/Enemy.tscn")
var Boss = preload("res://Scenes/Boss.tscn")

func _on_spawn_timer_timeout():
	var enemy = Enemy.instantiate()
	enemy.position = Vector2(randi_range(0, 768), randi_range(0, -192))
	add_child(enemy)

func _on_boss_timer_timeout():
	$SpawnTimer.stop()
	var boss = Boss.instantiate()
	boss.position = Vector2(375, -150)
	print("APARECIO EL JEFE")
	add_child(boss)
	$BossTimer.stop()
