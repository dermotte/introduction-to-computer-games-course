extends Sprite2D

var target = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var src = get_global_position()
	if (src-target).length() > 5:
		var move = (target-src).normalized()*100*delta + src
		set_global_position(move)
