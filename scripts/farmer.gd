extends Node2D
var banana_scene = preload("res://scenes/banana.tscn")
var price : float = 10.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func sale_success():
	pass

func determine_price():
	price = price + randf_range(-1,1)
	price = Global.round_to_cent(price)
	
func banana_to_market():
	determine_price()
	var banana = banana_scene.instantiate()
	
	Global.market.add_banana(banana,price)


func _on_time_to_sell_timeout() -> void:
	banana_to_market()

	pass # Replace with function body.
