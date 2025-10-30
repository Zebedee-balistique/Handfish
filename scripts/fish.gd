extends Area2D
enum poisson{
	bleu,
	rouge,
	lanterne,
	fugus
}

export(poisson) var poisson_type

# Called when the node enters the scene tree for the first time.
func _ready():
	init()


func init():
	pass#connect("area_entered", Player, "_poisson_collision", [self])
	
func _flip(mode):
	$AnimatedSprite.set_flip_h(mode)

func _process(delta):
	set_rotation(cos(Time.get_ticks_msec() / 280.0)/3)
	
func set_type(type):
	poisson_type = type
	$AnimatedSprite.play(poisson.keys()[type])
	
func get_eaten():
	Player.eat(poisson_type)
	free_poisson()
	

func free_poisson():
	if poisson_type == poisson.bleu or\
	poisson_type == poisson.rouge or\
	poisson_type == poisson.lanterne:
		get_parent().get_parent().queue_free()
		queue_free()

func _on_fish_body_entered(body):
	if (body == Player):
		get_eaten()
