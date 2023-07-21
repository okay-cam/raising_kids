extends StaticBody2D




export var item := 0



# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.frame = item


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
