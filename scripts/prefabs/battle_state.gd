extends Node
class_name BattleState

@export_group("Nodes")
@export var player: Player
@export var enemy: Enemy

var player_turn: bool = true
var battle_over: bool = false

func _ready() -> void:
	player.turn_ended.connect(_on_turn_ended)
	enemy.turn_ended.connect(_on_turn_ended)
	enemy.killed.connect(_on_enemy_killed)

func _on_turn_ended() -> void:
	if battle_over:
		return
	if player_turn:
		print("* Enemy turn")
		enemy.start_turn()
	else:
		print("* Player turn")
		player.start_turn()
	player_turn = not player_turn

func _on_enemy_killed() -> void:
	battle_over = true
	get_tree().change_scene_to_file("res://scenes/win.tscn")