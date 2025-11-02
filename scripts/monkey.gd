extends Node2D
var buy : bool
var banana_considering
var price
var index
var banana_name
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_time_to_buy_timeout() -> void:
	if Global.market.produce.size() > 0:
		look_at_market()
	
func look_at_market():
	print("monkey looking")
	banana_considering = Global.market.produce[0]
	banana_name= banana_considering[0]
	price= banana_considering[1]
	#index = banana_considering[2]
	demand_algorithm(price)


func demand_algorithm(b_price):
	var probability = 100 - b_price
	var chance = randi() % 100
	if chance < probability:
		buy_banana()
	else:
		print("not buying")
		
func buy_banana():

	var banana_node = Global.market.get_node(banana_name)
	banana_node.sold = true
	Global.market.produce.pop_front()
	print("bought ", banana_name)
	banana_node.queue_free()
