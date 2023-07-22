extends CanvasLayer

export var MainGameScene : PackedScene
export var MenuGameScene : PackedScene
export var PauseGameScene : PackedScene

var pause_state := false

func _input(event):
	if event.is_action_pressed("pause"):
		pause_state = !pause_state
		update_pause_screen()

func update_pause_screen():
	if pause_state:
		get_tree().paused = true
		visible = true
	else:
		get_tree().paused = false
		visible = false

func _on_Resume_buton_button_up():
	pause_state = false
	update_pause_screen()

func _on_Quit_buton_button_up():
	get_tree().quit()

func _on_Menu_buton_button_up():
	get_tree().change_scene(MenuGameScene.resource_path)

