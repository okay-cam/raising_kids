extends CanvasLayer

#export var MainGameScene : PackedScene
#export var MenuGameScene : PackedScene

const Game = "res://src/Level.tscn"
const MainMenu = "res://src/start_menu.tscn"

var alive_stats
var dead_stats




func _ready():
	hide()

func activate():
	
	$Cheer.play()
	
	if alive_stats == 1:
		$Control/VBox/Alive.text = "You successfully raised 1 child!"
	else:
		$Control/VBox/Alive.text = "You successfully raised {0} children!".format([alive_stats])
	
	if dead_stats == 1:
		$Control/VBox/Dead.text = "You are responsible for the death of 1 child."
	else:
		$Control/VBox/Dead.text = "You are responsible for the death of {0} children.".format([dead_stats])
	
	match dead_stats:
		0:
			$Control/VBox/Custom.text = "You must be an experienced parent! Or you hid the bodies really well!"
		1:
			$Control/VBox/Custom.text = "Good job! Nobody really liked Jimmy anyway."
		2:
			$Control/VBox/Custom.text = "I guess 3 out of 5 is still a passing grade!"
		3:
			$Control/VBox/Custom.text = "That's odd, the house seems a bit quieter now."
		4:
			$Control/VBox/Custom.text = "One is better than none!"
		_:
			$Control/VBox/Custom.text = "Uhh.. If anyone asks, I never saw any of this."
	
	
	show()
	get_tree().paused = true
	

func _on_Quit_buton_button_up():
	get_tree().quit()

func _on_Menu_buton_button_up():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene(MainMenu)

func _on_Restart_button_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
#	get_tree().changes_scene(MainGameScene.resource_path)
