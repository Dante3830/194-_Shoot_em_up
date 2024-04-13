extends Timer

var minTime = 1
var maxTime = 3

func _ready():
	spawntime()
	timeout.connect(spawntime)

func spawntime():
	set_wait_time(randi_range(minTime, maxTime))
