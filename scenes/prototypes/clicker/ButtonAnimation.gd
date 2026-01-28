class_name ButtonAnimation
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
	_reset_instant()

# ----------------
# Hover
# ----------------

func _on_mouse_entered() -> void:
	is_hovered = true
	_animate_scale()

func _on_mouse_exited() -> void:
	is_hovered = false
	_animate_scale()

func _animate_scale() -> void:
	if scale_tween:
		scale_tween.kill()

	scale_tween = create_tween()
	scale_tween.tween_property(
		self,
		"scale",
		_get_rest_scale(),
		0.12
	)

func _get_rest_scale() -> Vector2:
	return HOVER_SCALE if is_hovered else Vector2.ONE

# ----------------
# Click
# ----------------

func _on_pressed() -> void:
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
		0.08
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	scale_tween.tween_property(
		self,
		"scale",
		_get_rest_scale(),
		0.14
	)

# ----------------
# Visibility safety
# ----------------

func _notification(what):
	if what == NOTIFICATION_VISIBILITY_CHANGED and visible:
		call_deferred("_reset_instant")

func _reset_instant():
	if scale_tween:
		scale_tween.kill()
	if rotation_tween:
		rotation_tween.kill()

	scale = Vector2.ONE
	rotation = 0.0
	is_hovered = false
