extends EnemyAttack
class_name EnemyBasicAttack

@export_group("Settings")
@export var charge_time: float = 0.8

var target: Player = null

## Move to Player,
## Wind up sword swing (animation),
## Release sword swing,
## Deal damage to player if hitbox collided,
## Return to original position
func start(targets) -> void:
	assert(len(targets) == 1, "Should be exactly one enemy")
	target = targets[0]

	# Move forward
	var tween := get_tree().create_tween()
	tween.tween_property(sprite, "global_position", target.global_position + Vector2(50, 0), 1.2).finished.connect(_charge)

func _charge() -> void:
	print("* Charging swing for basic attack...")
	get_tree().create_timer(0.8).timeout.connect(_unleash)

func _unleash() -> void:
	# Reset position
	var tween := get_tree().create_tween()
	tween.tween_property(sprite, "position", Vector2(0, 0), 0.8).set_delay(0.2).finished.connect(ended.emit)

	# Deal damage
	if not target.ducking:
		target.get_hit(enemy.stats.atk)
	target = null
