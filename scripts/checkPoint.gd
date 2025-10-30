extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func set_checkpoint(body):
	if body == Player:
		Player.starting_point = Player.position
		print("checkpoint")

func _on_checkPoint_body_entered(body):
	set_checkpoint(body)


func _on_checkPoint_body_exited(body):
	set_checkpoint(body)
	
