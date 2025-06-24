extends CharacterBody2D
class_name Player

@export_group("Nodes")
@export var battle_state: BattleState ## Battle State
@export var hud: HUD
@export var enemy: Enemy ## TODO: Add selection option
@export_subgroup("Internal")
@export var sprite: Sprite2D ## Player sprite
@export var basic_attack: PlayerBasicAttack

@export_group("Resources")
@export var stats: Stats

var ducking = false

signal turn_ended
signal turn_started
signal got_hit(amount, stats)

func _ready() -> void:
    hud.basic_attack_selected.connect(basic_attack.start.bind([enemy] as Array[Enemy]))
    basic_attack.ended.connect(end_turn)

func _process(_delta: float) -> void:
    if not ducking and not battle_state.player_turn and Input.is_action_just_pressed("btn1"):
        duck()
    elif ducking and (not Input.is_action_pressed("btn1") or battle_state.player_turn):
        rise()

func start_turn() -> void:
    turn_started.emit()

func end_turn() -> void:
    turn_ended.emit()

func duck() -> void:
    ducking = true
    var tween = get_tree().create_tween()
    tween.tween_property(sprite, "scale", Vector2(1,0.5), 0.1)
    get_tree().create_timer(1.5).timeout.connect(rise)

## After ducking
func rise() -> void:
    if not ducking:
        return
    var tween = get_tree().create_tween()
    tween.tween_property(sprite, "scale", Vector2(1,1), 0.1).finished.connect(func (): ducking = false)

func get_hit(dmg: int) -> void:
    var adj_dmg = clampi(dmg - stats.def, 5, dmg)
    stats.hp = clampi(stats.hp - adj_dmg, 0, stats.hp)
    print("Player hit for %d" % adj_dmg)
    print("Player HP: %d" % stats.hp)
    got_hit.emit(adj_dmg, stats)
