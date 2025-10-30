extends PathFollow2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var flipped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	init()
	
func init():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rotation_degrees > -90 and rotation_degrees < 90:
		if flipped == true:
			$fish/AnimatedSprite.set_flip_v(false)
			flipped = false
	else:
		if flipped == false:
			$fish/AnimatedSprite.set_flip_v(true)
#			emit_signal("switch_rotation", flipped)
			flipped = true
