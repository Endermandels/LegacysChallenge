extends Control
class_name HUD

@export_group("Nodes")
@export var player: Player
@export_subgroup("Internal")
@export var atk_btn: Button

signal basic_attack_selected

func _ready() -> void:
	player.turn_started.connect(func (): atk_btn.disabled = false)
	player.turn_ended.connect(func (): atk_btn.disabled = true)
	atk_btn.pressed.connect(basic_attack_selected.emit)
