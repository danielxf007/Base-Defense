extends Projectile

class_name RocketProjectile

export(float) var EXPLOSION_RADIUS: float
export(float) var CONTACT_RADIUS: float
var damage: int
var contact_area: CircleShape2D
var explosion_time: Timer

func _ready():
	self.damage = self.INIT_DAMAGE
	self.explosion_time = $ExplosionTime
	self.contact_area = $CollisionShape2D.shape
	self.disable()

func _on_RocketProjectile_area_entered(target: Monster) -> void:
	if $AnimationPlayer.current_animation != "explosion":
		$AnimationPlayer.play("explosion")
	var target_d: float = (target.global_position-self.global_position).length()
	var real_damage: int = ceil(self.damage*(1/target_d))
	real_damage = real_damage if real_damage > 0 else 1
	target.got_damaged(real_damage)
	if self.explosion_time.is_stopped():
		self.explosion_time.start()
		self.set_physics_process(false)

func _on_ExplosionTime_timeout() -> void:
	self.disable()
	$AnimationPlayer.play("normal")
	self.contact_area.radius = self.CONTACT_RADIUS

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






