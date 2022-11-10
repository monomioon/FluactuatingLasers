extends KinematicBody2D

const UP = Vector2(0, -1)
const gravity = 20
const MAXFALLSPEED = 200
const MAXSPEED = 10
const jump = 300


var motion = Vector2()
var facing_right = true

func _ready():
	pass


func _physics_process(_delta):
	
	motion.y += gravity
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	#if facing_right == true:
		#$Sprite.scale.x = 1
	#else:
		#$Sprite.scale.x = -1
	
	if Input.is_action_pressed("right"):
		motion.x += MAXSPEED
		facing_right = true
		$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("left"):
		motion.x -= MAXSPEED
		facing_right = false
		$AnimationPlayer.play("Run")
	else:
		motion.x = lerp(motion.x, 0, 0.2)
	
	motion = move_and_slide(motion, UP)
	
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			motion.y = -jump

