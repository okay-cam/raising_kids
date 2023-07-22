extends CanvasLayer

export var MainGameScene : PackedScene
export var MenuGameScene : PackedScene


func _on_Game_buton_button_up():
	get_tree().change_scene(MainGameScene.resource_path)
	
func _on_Main_menu_button_button_up():
	get_tree().change_scene(MenuGameScene.resource_path)
