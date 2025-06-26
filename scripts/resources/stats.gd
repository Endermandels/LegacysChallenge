extends Resource
class_name Stats

@export_group("Stats")
@export var max_hp: int = 50
@export var atk: int = 5
@export var def: int = 5
@export var spd: int = 10
@export var max_mp: int = 10 ## Player only
@export_subgroup("Hidden")
@export var min_dmg_received: int = 5 ## Minimum damage received upon a hit
@export var ok_mp_gain: int = 1 ## MP gained from OK attack
@export var good_mp_gain: int = 2 ## MP gained from GOOD attack
@export var great_mp_gain: int = 4 ## MP gained from GREAT attack
@export var excellent_mp_gain: int = 6 ## MP gained from EXCELLENT attack

var hp: int = max_hp
var mp: int = max_mp

signal hp_changed(amount: int)
signal mp_changed(amount: int)
signal killed

func reset() -> void:
    hp = max_hp
    mp = max_mp

func dead() -> bool:
    return hp < 1

func get_adj_dmg(dmg: int) -> int:
    var adj_dmg = dmg - def
    if adj_dmg < min_dmg_received:
        adj_dmg = min_dmg_received
    return adj_dmg

func take_dmg(amount: int) -> void:
    set_hp(hp - get_adj_dmg(amount))

func increase_mp(category: String) -> void:
    if category == "OK":
        set_mp(mp + ok_mp_gain)
    elif category == "GOOD":
        set_mp(mp + good_mp_gain)
    elif category == "GREAT":
        set_mp(mp + great_mp_gain)
    elif category == "EXCELLENT":
        set_mp(mp + excellent_mp_gain)
    else:
        print("!!! Unknown category: %s" % category)

func set_hp(new_hp: int) -> void:
    var og_hp = hp
    hp = clampi(new_hp, 0, max_hp)
    if hp < 1:
        killed.emit()
    hp_changed.emit(hp - og_hp)

func set_mp(new_mp: int) -> void:
    var og_mp = mp
    mp = clampi(new_mp, 0, max_mp)
    mp_changed.emit(mp - og_mp)
