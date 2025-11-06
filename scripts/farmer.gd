extends Node2D
var banana_scene = preload("res://scenes/banana.tscn")
var price : float = 10.0
var sold : bool = false
var will_sell : bool = false
var willing_to_sell: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Global.market.connect("banana_sold","banana_to_market")
	$time_to_sell.set_wait_time(randf_range(1,2))
	pass # Replace with function body.

func _process(delta: float) -> void:
	$willingness.text = str(floor(willing_to_sell) , "%")

func determine_price():
	if sold:
		price = price + randf_range(0,10)
	else:
		price = price - randf_range(0,10)
	price = Global.round_to_cent(price)
	
func banana_to_market(banana_price):
	var banana = banana_scene.instantiate()
	banana.price = banana_price
	banana.seller = self
	Global.market.add_banana(banana)

func decide_to_sell(banana_price):
	willing_to_sell = banana_price
	var chance = randi() % 100
	if chance < willing_to_sell:
		will_sell = true
	else:
		will_sell = false

func _on_time_to_sell_timeout() -> void:
	determine_price()
	decide_to_sell(price)
	if will_sell:
		banana_to_market(price)
		$selling.text = "selling"
		$selling.add_theme_color_override("font_color",Color.GREEN)
	else:
		$selling.text = "closed"
		$selling.add_theme_color_override("font_color",Color.RED)

	pass # Replace with function body.
