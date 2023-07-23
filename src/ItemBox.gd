extends StaticBody2D




const HIGHLIGHT_AMOUNT = 1.5

export var item := 2

# called from player when getting close or far
func highlight():
	modulate = Color(HIGHLIGHT_AMOUNT, HIGHLIGHT_AMOUNT, HIGHLIGHT_AMOUNT)
func unhighlight():
	modulate = Color.white

func play_sound():
	$Pickup.play()
