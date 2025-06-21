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
@export var sprite: Sprite2D

@export_group("Settings")
@export var ok_thresh: float = 0.3
@export var good_thresh: float = 0.7
@export var great_thresh: float = 1.2
@export var excellent_thresh: float = 1.7
@export var charge_time: float = 1.8

var stored_power: float = 0.0

func _unhandled_key_input(event: InputEvent) -> void:
    if stored_power > 0.01 and event.is_action_pressed("btn1"):
        _unleash()
        
func _process(delta: float) -> void:
    if stored_power > 0.01:
        _increase_power(delta)

func start() -> void:
    '''
    Move forward a bit,
    Start raising staff (animation),
    Press and hold Button 1 within the grace period,
    Release Button 1 before the timer runs out,
    Spawn roots from floor corresponding to power threshold (animation),
    Deal damage to enemy,
    Return to original position
    '''

    # Move forward
    var tween := get_tree().create_tween()
    tween.tween_property(sprite, "position", Vector2(50, 0), 0.6).finished.connect(_charge)

func _charge() -> void:
    print("* Charging power for basic attack...")

    stored_power = 0.02

    var timer := get_tree().create_timer(charge_time)
    timer.timeout.connect(_unleash)

func _increase_power(delta: float):
    stored_power += delta

func _unleash() -> void:
    if stored_power < 0.01:
        return

    # Power thresholds
    # OK
    # GOOD
    # GREAT
    # EXCELLENT
    # OK

    if stored_power < ok_thresh:
        print("! OK")
    elif stored_power < good_thresh:
        print("! GOOD")
    elif stored_power < great_thresh:
        print("! GREAT")
    elif stored_power < excellent_thresh:
        print("! EXCELLENT")
    else:
        print("! OK")

    stored_power = 0.0
    
    # Reset position
    var tween := get_tree().create_tween()
    tween.tween_property(sprite, "position", Vector2(0, 0), 0.8)
