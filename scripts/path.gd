extends Path2D

enum itineraire{
	a,
	b,
	c,
	d,
	e
}

enum poisson{
	bleu,
	rouge,
	lanterne,
	fugus
}

export(itineraire) var forme
export(poisson) var poisson_type


onready var follow = get_node("follow")


# Called when the node enters the scene tree for the first time.
func _ready():
	$follow/fish.set_type(poisson_type)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	follow.set_offset(follow.get_offset() + (150 + 100* sin(Time.get_ticks_msec() / 100))* delta)
	
