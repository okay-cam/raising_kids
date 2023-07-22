extends CanvasLayer

#export var MainGameScene : PackedScene
#export var MenuGameScene : PackedScene

const Game = "res://src/Level.tscn"
const MainMenu = "res://src/start_menu.tscn"

var pause_state := false

func _ready():
	pause_state = false
	hide()

func toggle_pause():
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
	get_tree().change_scene(MainMenu)

func _on_Restart_button_pressed():
	toggle_pause()
	get_tree().reload_current_scene()
#	get_tree().changes_scene(MainGameScene.resource_path)
