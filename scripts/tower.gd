extends Area2D

enum {DOWN, LEFT, LEFTDOWN, LEFTUP, RIGHT, RIGHTDOWN, RIGHTUP, UP}
const SELECT_COLOR: Color = Color(255, 255, 255, 64)
const UNSELECT_COLOR: Color = Color(255, 255, 255, 255)
const ANIM_NAME: String = "lvl_%d_%d"
const ANGLE_OFFSET: float = 20.0
const MAX_LVL: int = 3
export(float) var SHOT_RADIUS: float
var lvl: int
var active: bool
var selected: bool
var targets: Array
var main_target: Monster
var range_area: CircleShape2D
var anim_player: AnimationPlayer
var barrel_pos: Position2D

func init() -> void:
	self.lvl = 1
	self.active = true
	self.selected = false
	self.targets = []
	self.main_target = null
	self.range_area = $RangeArea.shape
	self.range_area.radius = self.SHOT_RADIUS
	self.anim_player = $AnimationPlayer
	self.barrel_pos = $BarrelPos

func _on_Tower_area_entered(target: Monster) -> void:
	if not self.main_target:
		self.main_target = target
	else:
		self.targets.append(target)

func _on_Tower_area_exited(target: Monster) -> void:
	if self.main_target == target:
		self.main_target = self.targets.pop_front() if self.targets else null
	else:
		self.targets.erase(target)

# warning-ignore:unused_argument
func set_active(value: bool) -> void:
	pass

func destroy() -> void:
	self.hide()
	self.set_active(false)

func select() -> void:
	self.modulate = self.SELECT_COLOR
	self.selected = true

func unselect() -> void:
	self.modulate = self.UNSELECT_COLOR
	self.selected = false

func update_look_dir(angle: float):
	if angle > 0.0:
		if angle < self.ANGLE_OFFSET:
			self.anim_player.play(self.ANIM_NAME%[self.lvl, DOWN])
		elif angle < 90.0-self.ANGLE_OFFSET:
			self.anim_player.play(self.ANIM_NAME%[self.lvl, RIGHTDOWN])
		elif angle < 90.0+self.ANGLE_OFFSET:
			self.anim_player.play(self.ANIM_NAME%[self.lvl, DOWN])
		elif angle < 180.0-self.ANGLE_OFFSET:
			self.anim_player.play(self.ANIM_NAME%[self.lvl, LEFTDOWN])
		else:
			self.anim_player.play(self.ANIM_NAME%[self.lvl, LEFT])
	else:
		if angle > -self.ANGLE_OFFSET:
			self.anim_player.play(self.ANIM_NAME%[self.lvl, RIGHT])
		elif angle > -90.0+self.ANGLE_OFFSET:
			self.anim_player.play(self.ANIM_NAME%[self.lvl, RIGHTUP])
		elif angle > -90.0-self.ANGLE_OFFSET:
			self.anim_player.play(self.ANIM_NAME%[self.lvl, UP])
		elif angle > -180.0+self.ANGLE_OFFSET:
			self.anim_player.play(self.ANIM_NAME%[self.lvl, LEFTUP])
		else:
			self.anim_player.play(self.ANIM_NAME%[self.lvl, LEFT])
