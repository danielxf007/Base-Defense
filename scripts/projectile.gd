extends Area2D

class_name Projectile

export(float) var SPEED: float
export(int) var INIT_DAMAGE: int
export(Dictionary) var DAMAGE_DATA: Dictionary = {"damage": 0}
var target_dir: Vector2

func increase_damage(amount: int) -> void:
	self.damage += amount

func enable() -> void:
	self.set_physics_process(true)
	self.show()

func disable() -> void:
	self.set_physics_process(false)
	self.hide()

func was_shoot(target_pos: Vector2) -> void:
	self.target_dir = (target_pos-self.global_position).normalized()
	self.look_at(target_pos)
	self.enable()

