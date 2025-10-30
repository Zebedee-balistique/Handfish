extends KinematicBody2D

enum poisson{
	bleu,
	rouge,
	lanterne,
	fugus
}

var enduranceMAX = 150
var endurance = enduranceMAX
var starting_point 
var gonfle = false
const GRAVITY = 3

const WALK_SPEED = 200
const DASH_CHARGING_SPEED = 5
const JUMP_FORCE = 180
const MAX_GRAVITY = 300
const FRICTION = .90
var jump = 1
var velocity = Vector2()
var gravity = Vector2()
var dash_charge = 0
var dash_charging = false

func _poisson_collision(area):
	print("ok")
	
func dash(charge):
	var mousePos = get_global_mouse_position()
	var angle = atan2(mousePos.y - position.y, mousePos.x - position.x) 
	var dash = Vector2(cos(angle), sin(angle)) * charge
	velocity = dash
	
	
func _physics_process(delta):
	if gonfle == false:
		#La gravité
		if (!is_on_floor()):
			velocity.y += GRAVITY
		if (velocity.y > MAX_GRAVITY):
			velocity.y = MAX_GRAVITY
		
		#Les mouvements du joueur
		if Input.is_action_pressed("move-left"):
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("move-right"):
			velocity.x =  WALK_SPEED
		velocity.x *= FRICTION
		if velocity.y < 0:
			velocity.y *= FRICTION
		
		if Input.is_action_pressed("jump"):
			if jump == 1:
				velocity.y = -JUMP_FORCE
				jump = 0
				$Jump.start()
				
		if Input.is_action_just_pressed("dash"):
			dash_charging = true
		
		if Input.is_action_just_released("dash"):
			dash_charging = false
			dash(dash_charge)
			dash_charge = 0
			
		if dash_charging:
			if endurance > 0:
				dash_charge += 10 * DASH_CHARGING_SPEED
				endurance -= DASH_CHARGING_SPEED
		else:
			if is_on_floor():
				endurance += 3
			else:
				endurance += 1
			if endurance > enduranceMAX:
				endurance = enduranceMAX
				
		#Les animations
		if is_on_floor():
			$AnimatedSprite.animation = "walk"
		else:
			$AnimatedSprite.animation = "swim"
		if velocity.x != 0:	
			$AnimatedSprite.flip_h = velocity.x < 0
		
		
		#La compilation de tout dans move_and_slide
		
		move_and_slide(velocity, Vector2(0,-1))
		var collision = get_last_slide_collision()
		if (collision != null):
			var normal = collision.get_normal()
			if normal.y != -1:
				normal.y *= -1
				if normal.x > 0:
					normal.x *= -1
				velocity *= normal
				
				
		if is_on_floor():
			if abs( velocity.x) <= 20:
				$AnimatedSprite.stop()
			else:
				$AnimatedSprite.play("walk")	
	else:
		move_and_slide(Vector2(0, -150), Vector2.UP)

	
func _on_Jump_timeout():
	jump = 1
	
func die():
	position = starting_point
	endurance = enduranceMAX
	
func eat(poisson_type):
	$crunch.play()
	match (poisson_type):
		poisson.bleu:
			boost(40)
		poisson.rouge:
			boost(20)
		poisson.lanterne:
			boost(75)
		poisson.fugus:
			$AnimatedSprite.play("gonfle")
			gonfle = true
			$gonfle.start()
			
func boost(power):
	enduranceMAX += power
	endurance = enduranceMAX

func _ready():
	starting_point = position
	
func _on_gonfle_timeout():
	gonfle = false
