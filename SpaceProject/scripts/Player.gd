extends KinematicBody2D

const UP = Vector2(0, -1)
const gravity = 20
const MAXFALLSPEED = 200
var speed = 5
const MAXSPEED = 7
const jump = 300
const tot_dark_matter = 10 ##inserire il numero totale di dark matter presente nel gioco, o nel livello

##per effettuare la divisione scrivere i numeri così
var score = 0.0
var divisione = 0.0
var percentuale = 0.0

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
		motion.x += speed
		if speed == MAXSPEED:
			speed = MAXSPEED
		facing_right = true
		$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("left"):
		motion.x -= speed
		if speed == MAXSPEED:
			speed = MAXSPEED
		facing_right = false
		$AnimationPlayer.play("Run")
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		$AnimationPlayer.play("idle")
	
	motion = move_and_slide(motion, UP)
	
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			motion.y = -jump
	
	if Input.is_key_pressed(KEY_E) and $SeedCooldown.time_left == 0:
		$SeedCooldown.start()
		launch_seed()





func _on_dark_matter_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	score += 1
	print("score:", score)
	divisione =  score/tot_dark_matter
	percentuale = divisione*100
	print("percentuale di raccolta dark_matter:", percentuale, "%")
	#$ProgressBar.value=percentualE
	get_tree().get_root().get_node("World/GUI").updateProgress(percentuale)


func launch_seed(): 
 var seed_scene = load("res://entities/attack/Attack.tscn") 
 var seed_node = seed_scene.instance() 
 seed_node.position = self.position + $RayCast2D.cast_to.normalized()*32 
 seed_node.apply_impulse(Vector2(), $RayCast2D.cast_to.normalized()*600) 
 get_node("/root/World").add_child(seed_node)
