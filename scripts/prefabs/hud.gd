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
@export var mp_bar: ProgressBar
@export var hp_label: Label
@export var mp_label: Label

signal basic_attack_selected

func _ready() -> void:
    # Signals
    player.turn_started.connect(func (): atk_btn.disabled = false)
    player.turn_ended.connect(func (): atk_btn.disabled = true)
    player.stats.hp_changed.connect(_change_hp)
    player.stats.mp_changed.connect(_change_mp)
    atk_btn.pressed.connect(basic_attack_selected.emit)

    # Stats
    hp_bar.max_value = player.stats.max_hp
    hp_bar.value = player.stats.hp
    hp_label.text = "%s/%s" % [player.stats.hp, player.stats.max_hp]
    mp_bar.max_value = player.stats.max_mp
    mp_bar.value = player.stats.mp
    mp_label.text = "%s/%s" % [player.stats.mp, player.stats.max_mp]

func _change_hp(amount: int) -> void:
    var tween = get_tree().create_tween()
    tween.tween_property(hp_bar, "value", player.stats.hp, 0.2).set_delay(0.1)
    hp_label.text = "%s/%s" % [player.stats.hp, player.stats.max_hp]

func _change_mp(amount: int) -> void:
    var tween = get_tree().create_tween()
    tween.tween_property(mp_bar, "value", player.stats.mp, 0.2).set_delay(0.1)
    mp_label.text = "%s/%s" % [player.stats.mp, player.stats.max_mp]
