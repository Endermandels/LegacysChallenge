extends CharacterBody2D
class_name Enemy

@export_group("Resources")
@export var stats: Stats

func get_hit(dmg: int) -> void:
    stats.hp = clampi(stats.hp - dmg + stats.def, 0, stats.hp)
    print("Enemy hit for %d" % dmg)
    print("Enemy HP: %d" % stats.hp)