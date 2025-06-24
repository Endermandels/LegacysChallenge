extends Control
class_name HUD

'''
Player's HUD
'''

@export_group("Nodes")
@export var player: Player
@export_subgroup("Internal")
@export var atk_btn: Button
@export var hp_bar: ProgressBar
@export var hp_label: Label

signal basic_attack_selected

func _ready() -> void:
	player.turn_started.connect(func (): atk_btn.disabled = false)
	player.turn_ended.connect(func (): atk_btn.disabled = true)
	player.got_hit.connect(_handle_hit)
	atk_btn.pressed.connect(basic_attack_selected.emit)
	hp_bar.max_value = player.stats.max_hp
	hp_label.text = "%s/%s" % [player.stats.hp, player.stats.max_hp]

func _handle_hit(amount: int, stats: Stats) -> void:
	hp_bar.value = stats.hp
	hp_label.text = "%s/%s" % [stats.hp, stats.max_hp]

