extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if $leave_label.text == "sold":
		$leave_label.add_theme_color_override("font_color",Color.GREEN)
	else:
		$leave_label.add_theme_color_override("font_color",Color.RED)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
	pass # Replace with function body.
