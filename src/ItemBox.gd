extends StaticBody2D


const HIGHLIGHT_AMOUNT = 1.8

export var item := 2


func _ready():
	$Sprite.frame = item



# called from player when getting close or far
func highlight():
	modulate = Color(HIGHLIGHT_AMOUNT, HIGHLIGHT_AMOUNT, HIGHLIGHT_AMOUNT)
func unhighlight():
	modulate = Color.white
