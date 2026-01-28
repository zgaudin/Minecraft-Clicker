class_name GeneratorAnimation
extends Button

var scale_tween: Tween
var rotation_tween: Tween
var rock_dir := 1
var is_hovered := false

const HOVER_SCALE := Vector2(1.2, 1.2)
const CLICK_SCALE := Vector2(1.35, 1.35)
const ROCK_ANGLE := deg_to_rad(15)

func _ready() -> void:
	pivot_offset = size / 2


func Animate() -> void:
	# ROTATION: fully isolated
	if rotation_tween:
		rotation_tween.kill()

	rotation = 0.0

	rotation_tween = create_tween()

	rotation_tween.tween_property(
		self,
		"rotation",
		ROCK_ANGLE * rock_dir,
		0.08
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	rotation_tween.tween_property(
		self,
		"rotation",
		0.0,
		0.12
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	rock_dir *= -1

	# SCALE pop (does NOT interfere with hover)
	if scale_tween:
		scale_tween.kill()

	scale_tween = create_tween()
	scale_tween.tween_property(
		self,
		"scale",
		CLICK_SCALE,
		0.06
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	scale_tween.tween_property(
		self,
		"scale",
		_get_rest_scale(),
		0.14
	)


func _get_rest_scale() -> Vector2:
	return HOVER_SCALE if is_hovered else Vector2.ONE
