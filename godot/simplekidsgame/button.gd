extends Sprite2D

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		$"../cow_mixdown".play()
		
