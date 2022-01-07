extends Projectile

class_name MachineGunProjectile

var damage: int

func _ready():
	self.damage = self.INIT_DAMAGE
	self.disable()

func _on_MGProjectile_area_entered(target: Monster) -> void:
	target.got_damaged(self.damage)
	self.disable()

func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float) -> Vector2:
	var q0: Vector2 = p0.linear_interpolate(p1, t)
	var q1: Vector2 = p1.linear_interpolate(p2, t)
	var r: Vector2 = q0.linear_interpolate(q1, t)
	return r

func _physics_process(delta):
#	var p0: Vector2 = self.global_position
#	var p2: Vector2 = self.target_pos
#	var p1 = (p2-p0).rotated(deg2rad(-40.0)) + p0
#	self.global_position = self._quadratic_bezier(p0, p1, p2, self.W)
	#self.global_position = self.global_position.linear_interpolate(self.target_pos, W)
	self.global_position += self.target_dir*SPEED*delta
