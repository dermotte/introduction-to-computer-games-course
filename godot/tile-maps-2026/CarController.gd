# CarController.gd
extends RigidBody2D

@export var max_speed: float = 600.0
@export var accel_force: float = 1600.0
@export var brake_force: float = 1200.0
@export var turn_torque: float = 16000.0
@export var forward_linear_damp: float = 0.2
@export var idle_linear_damp: float = 1.5
@export var boost_multiplier: float = 2.0
@export var max_angular_speed: float = 8.0

func _ready():
	linear_damp = idle_linear_damp
	angular_damp = 3.0

func _physics_process(delta):
	var forward_pressed = Input.is_action_pressed("forward")
	var backward_pressed = Input.is_action_pressed("backward")
	var left_pressed = Input.is_action_pressed("left")
	var right_pressed = Input.is_action_pressed("right")
	var boosting = Input.is_action_pressed("boost")

	var forward_dir = -transform.y.normalized()  # change if your sprite faces another axis
	var vel = linear_velocity
	var forward_speed = vel.dot(forward_dir)

	# Set damping based on input
	if forward_pressed or backward_pressed:
		linear_damp = forward_linear_damp
	else:
		linear_damp = idle_linear_damp

	# Acceleration
	if forward_pressed:
		var effective_accel = accel_force * (boost_multiplier if boosting else 1.0)
		# Apply force in forward direction
		apply_central_force(forward_dir * effective_accel)

	# Brake / reverse
	if backward_pressed:
		if forward_speed > 0.0:
			apply_central_force(-forward_dir * brake_force)  # braking
		else:
			apply_central_force(-forward_dir * (accel_force * 0.6))  # reverse accel

	# Turning (binary input); steering effectiveness scales with forward speed
	var turn_dir = 0
	if left_pressed:
		turn_dir -= 1
	if right_pressed:
		turn_dir += 1

	if turn_dir != 0:
		var speed_factor = clamp(abs(forward_speed) / 200.0, 0.0, 1.0)
		var steer_invert = -1.0 if forward_speed < 0.0 else 1.0
		apply_torque(turn_dir * steer_invert * turn_torque * speed_factor)

	# Limit speed naturally through force application rather than direct velocity modification
	var current_speed = linear_velocity.length()
	if current_speed > max_speed:
		# Apply counter force to slow down instead of directly modifying velocity
		var counter_force = -linear_velocity.normalized() * (current_speed - max_speed) * 10.0
		apply_central_force(counter_force)

	# Limit angular velocity naturally
	var current_angular_speed = abs(angular_velocity)
	if current_angular_speed > max_angular_speed:
		# Apply counter torque to slow down rotation
		var counter_torque = -sign(angular_velocity) * (current_angular_speed - max_angular_speed) * 5.0
		apply_torque(counter_torque)
