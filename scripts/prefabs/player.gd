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

func _ready() -> void:
    hud.basic_attack_selected.connect(basic_attack.start.bind([enemy] as Array[Enemy]))
    basic_attack.ended.connect(end_turn)
    basic_attack.enemy_hit.connect(hit_enemy)

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
    stats.take_dmg(dmg)
    print("Player hit for %d" % stats.get_adj_dmg(dmg))
    print("Player HP: %d" % stats.hp)

func hit_enemy(category: String) -> void:
    stats.increase_mp(category)
