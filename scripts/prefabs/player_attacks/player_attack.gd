extends Node
class_name PlayerAttack

'''
Main functions:
    move sprites
    play animations (signal)
    spawn attacks
    handle attack timed inputs
    deal damage
'''

@export_group("Nodes")
@export var player: Player
@export var sprite: Sprite2D ## Player sprite

@export_group("Settings")
@export var ok_thresh: float = 0.3 ## Amount of time/number of hits needed for OK attack
@export var good_thresh: float = 0.7 ## Amount of time/number of hits needed for GOOD attack
@export var great_thresh: float = 1.2 ## Amount of time/number of hits needed for GREAT attack
@export var excellent_thresh: float = 1.7 ## Amount of time/number of hits needed for EXCELLENT attack
@export var max_thresh: float = 1.8 ## Maximum amount of time/number of hits

var stored_power: float = 0.0 ## Amount of time/number of hits stored up

signal ended ## When the attack ends

## When the enemy is struck by the attack. [br]
## 
## category: "OK" | "GOOD" | "GREAT" | "EXCELLENT" 
signal enemy_hit(category: String) 

## TODO: Implement
func start(enemies: Array[Enemy]) -> void:
    pass

