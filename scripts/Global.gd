extends Node

@onready var market = $"../market"
@onready var Listings = "$../Market/UI/Listing"
# Called when the node enters the scene tree for the first time.
@onready var ID : int = 0
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func round_to_cent(price):
	return round(price * 100) / 100

func binary_search(price : float ,produce: Array):
	var left = 0
	var right = produce.size() - 1
	while left <= right:
		var mid = floor((right + left) / 2)
		if produce[mid][1] > price:
			right = mid - 1 
		else:
			left = mid + 1
	return left
	
#func update_listings(banana,price):
	
