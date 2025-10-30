extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var skin


# Called when the node enters the scene tree for the first time.
func _ready():
	if skin == 0:
		$AnimatedSprite.play("oursin")
	else:
		$AnimatedSprite.play("etoile")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_PlayerDetector_body_entered(body):
	if Player == body:
		body.die()
