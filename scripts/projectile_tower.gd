extends "res://scripts/tower.gd"

export(PackedScene) var PROJECTILE_SCENE: PackedScene 
export(int) var N_PROJECTILES: int
var projectiles: Array
var addr: int

func _ready():
	self.init()

func init() -> void:
	.init()
	var projectile: Projectile
	self.projectiles = []
	self.addr = 0
	for _i in range(self.N_PROJECTILES):
		projectile = self.PROJECTILE_SCENE.instance()
		self.add_child(projectile)
		self.projectiles.append(projectile)

func _on_ShootClock_timeout() -> void:
	if self.main_target:
		var projectile: Projectile = self.projectiles[self.addr]
		projectile.global_position = self.barrel_pos.global_position
		projectile.was_shoot(self.main_target.global_position)
		self.addr = (self.addr+1)%self.N_PROJECTILES

func _physics_process(_delta):
	if self.main_target:
		var v: Vector2 = self.main_target.global_position-self.global_position
		var angle: float = rad2deg(v.angle())
		self.update_look_dir(angle)
