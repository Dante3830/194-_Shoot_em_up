extends Camera2D

var startShake = false
var shakeInstensity : float = 0.0
var shakeDampening = 0

var shakeTime

# Called when the node enters the scene tree for the first time.
func _ready():
	shakeTime = $ShakeTime
	Global.camera = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if startShake == true:
		offset.x = randi_range(-1, 1) * shakeInstensity
		offset.y = randi_range(-1, 1) * shakeInstensity
		shakeInstensity = lerp(shakeInstensity, 0.0, shakeDampening)
	else:
		offset = Vector2(0, 0)

func screen_shake(intensity, duration, dampening):
	shakeInstensity = intensity
	shakeDampening = dampening
	shakeTime.start(duration)
	startShake = true

func _on_shake_time_timeout():
	startShake = false

