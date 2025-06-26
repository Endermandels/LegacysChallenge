extends CharacterBody2D
class_name Enemy

@export_group("Nodes")
@export var player: Player ## TODO: Determine at runtime
@export_subgroup("Internal")
@export var sprite: Sprite2D
@export var basic_attack: EnemyBasicAttack

@export_group("Resources")
@export var stats: Stats

signal turn_ended
signal killed

func _ready() -> void:
    basic_attack.ended.connect(end_turn)
    stats.killed.connect(_die)
    stats.reset()

func start_turn() -> void:
    if not stats.dead():
        get_tree().create_timer(2).timeout.connect(basic_attack.start.bind([player]))

func end_turn() -> void:
    turn_ended.emit()

func get_hit(dmg: int) -> void:
    stats.take_dmg(dmg)
    print("Enemy hit for %d" % stats.get_adj_dmg(dmg))
    print("Enemy HP: %d" % stats.hp)

func _die() -> void:
    var tween = get_tree().create_tween()
    tween.tween_property(sprite, "modulate:a", 0, 0.8).finished.connect(_after_death)

func _after_death() -> void:
    get_tree().create_timer(2).timeout.connect(killed.emit)
