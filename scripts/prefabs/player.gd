extends CharacterBody2D
class_name Player

@export_group("Nodes")
@export var sprite: Sprite2D
@export var atk_btn: Button
@export var basic_attack: PlayerAttack

@export_group("Stats")
@export var hp: int = 100
@export var atk: int = 5
@export var def: int = 3
@export var spd: int = 10

func _ready() -> void:
	atk_btn.pressed.connect(basic_attack.start)
	
