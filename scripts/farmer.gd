extends Node2D
var banana_scene = preload("res://scenes/banana.tscn")
var price : float = 10.0
var sold : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func determine_price():
	if sold:
		price = price + randf_range(0,10)
	else:
		price = price + randf_range(0,10)
	price = Global.round_to_cent(price)
	
func banana_to_market(banana_price):
	determine_price()
	var banana = banana_scene.instantiate()
	banana.price = banana_price
	banana.seller = self
	Global.market.add_banana(banana)
	
	

func _on_time_to_sell_timeout() -> void:
	banana_to_market(price)

	pass # Replace with function body.
