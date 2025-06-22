extends CharacterBody2D
class_name Player

@export_group("Nodes")
@export var enemy: Enemy ## TODO: Add selection option
@export var atk_btn: Button
@export var basic_attack: PlayerBasicAttack

@export_group("Resources")
@export var stats: Stats

func _ready() -> void:
	atk_btn.pressed.connect(basic_attack.start.bind([enemy] as Array[Enemy]))
	
