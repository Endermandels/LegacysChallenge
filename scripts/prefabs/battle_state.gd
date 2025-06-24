extends Node
class_name BattleState

@export_group("Nodes")
@export var player: Player
@export var enemy: Enemy

var player_turn: bool = true

func _ready() -> void:
	player.turn_ended.connect(_on_turn_ended)
	enemy.turn_ended.connect(_on_turn_ended)

func _on_turn_ended() -> void:
	if player_turn:
		print("* Enemy turn")
		enemy.start_turn()
	else:
		print("* Player turn")
		player.start_turn()
	player_turn = not player_turn
