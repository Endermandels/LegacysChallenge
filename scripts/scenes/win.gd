extends Node
class_name WinScene

func _unhandled_key_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        # get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
        get_tree().quit()
    elif event.is_action_pressed("reset"):
        get_tree().change_scene_to_file("res://scenes/battle.tscn")
