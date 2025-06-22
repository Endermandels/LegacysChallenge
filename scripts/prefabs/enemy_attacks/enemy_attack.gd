extends Node
class_name EnemyAttack

'''
Main functions:
    move sprites
    play animations (signal)
    spawn attacks
    handle attack timed inputs
    deal damage
'''

@export_group("Nodes")
@export var enemy: Enemy
@export var sprite: Sprite2D ## Enemy sprite

signal ended

## TODO: Implement
func start(targets) -> void:
    pass

