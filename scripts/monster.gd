extends Area2D

class_name Monster
export(float) var SPEED: float
export(Vector2) var MOV_DIR: Vector2 = Vector2(-1, 0)
export(int) var MAX_HIT_POINTS: int
var hit_points: int

func _ready():
	$Timer.start()
	self.hit_points = self.MAX_HIT_POINTS

func _physics_process(delta):
	self.global_position += self.MOV_DIR*SPEED*delta

func got_damaged(damage: int) -> void:
	self.hit_points = int(clamp(self.hit_points-damage, 0, self.MAX_HIT_POINTS))
	if not self.hit_points:
		self.disable()

func disable() -> void:
	self.hide()
	$CollisionShape2D.call_deferred("set_disabled", true)
