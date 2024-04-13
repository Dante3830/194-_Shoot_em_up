extends Area2D

var speed = 2000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position.y -= delta * speed

func _on_body_entered(body):
	if body.has_method("enemy_hit"):
		body.enemy_hit()
		queue_free()

func _on_despawner_timeout():
	queue_free()
