extends Sprite2D

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		# Check if the mouse click is within the button's area
		var button_position = $".".global_position
		var texture_size = texture.get_size() if texture else Vector2(100, 100)
		var click_pos = event.position
		
		# Check if click is within the button's bounding box
		if click_pos.x >= button_position.x and click_pos.x <= button_position.x + texture_size.x:
			if click_pos.y >= button_position.y and click_pos.y <= button_position.y + texture_size.y:
				$"../QwenTtsCowSays".play()
		


func _on_timer_timeout() -> void:
	pass # Replace with function body.
