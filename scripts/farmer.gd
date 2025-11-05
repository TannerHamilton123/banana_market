extends Node2D
var banana_scene = preload("res://scenes/banana.tscn")
var price : float = 10.0
var sold : bool = false
var will_sell : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$time_to_sell.set_wait_time(randf_range(.5,1))
	price = Global.market.starting_price
	pass # Replace with function body.

func determine_price():
	if sold and will_sell:
		price = price + randf_range(0,5)
	if not sold and will_sell:
		price = price - randf_range(0,5)
	if not will_sell:
		price = price
		
	price = Global.round_to_cent(price)
	
func banana_to_market(banana_price):
	var banana = banana_scene.instantiate()
	banana.price = banana_price
	banana.seller = self
	Global.market.add_banana(banana)

func supply_algorithm(banana_price):
	var willing_to_sell = banana_price
	var chance = randi() % 100
	if chance < willing_to_sell:
		will_sell = true
	else:
		will_sell = false

func _on_time_to_sell_timeout() -> void:
	determine_price()
	supply_algorithm(price)

	$price.text = str("$",price)
	if will_sell:
		banana_to_market(price)
		$selling.text = "selling"
		$selling.add_theme_color_override("font_color",Color.GREEN)
	else:
		$selling.text = "closed"
		$selling.add_theme_color_override("font_color",Color.RED)

	pass # Replace with function body.
