extends KinematicBody2D

const acceleration = 70
const max_speed = 320

var speed = 10
var jump_speed = 620
var gravity = 22

export (PackedScene) var bubble

var velocity = Vector2.ZERO

func _ready():
	$AnimatedSprite.animation = "Idle"
	$AnimatedSprite.playing = true

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_x"):
		shootBubble()
		
	move()
	velocity.y += gravity
	jump()
		
	velocity = move_and_slide(velocity, Vector2(-1,-1))

func move():
	if Input.is_action_pressed("ui_right"):
		velocity.x = min(velocity.x + acceleration, max_speed)
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - acceleration, -max_speed)
		$AnimatedSprite.flip_h = true
	else:
		velocity.x = 0
	
	if velocity.x == 0:
		$AnimatedSprite.animation = "Idle"
	elif velocity.x > 0 or velocity.x < 0:
		$AnimatedSprite.animation = "Run"

func jump():
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y -= jump_speed
	
	if !is_on_floor():
		if velocity.y < -1:
			$AnimatedSprite.animation = "Jump"
		if velocity.y > 1:
			$AnimatedSprite.animation = "Fall"


func shootBubble():
	var shoot_bubble = bubble.instance()
	if $AnimatedSprite.flip_h:
		$Shoot.scale.x = -1
		shoot_bubble.scale = Vector2(-3.8,3.8)
		shoot_bubble.velocidad = -320
		
	else:
		$Shoot.scale.x = 1
		shoot_bubble.scale = Vector2(3.8,3.8)
		shoot_bubble.velocidad = 320
		
	shoot_bubble.global_position = $Shoot/Direcion.global_position
	get_tree().call_group("Word", "add_child", shoot_bubble)
