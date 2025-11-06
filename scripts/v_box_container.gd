@tool
extends VBoxContainer

var colors : Array = [
		Color.RED,
		Color.HOT_PINK,
		Color.GREEN,
		Color.WHITE,
		Color.SKY_BLUE
	]
var Swatch = preload("res://scenes/ColorSwatch.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("colors created")
	for color in colors:
		var swatch : Button = Swatch.instantiate()
		swatch.get_node("ColorRect").color = color
		add_child(swatch)
		swatch.pressed.connect(_on_swatch_pressed.bind(color))

func _process(delta: float) -> void:
	pass
	
func _on_swatch_pressed(selected_color: Color) -> void:
	print("pressed")
	print(selected_color)
	pass
