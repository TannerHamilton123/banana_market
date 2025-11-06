extends Node2D

var current_name : String
var price : float
var seller
var sold = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$expiration_date.set_wait_time(Global.expiration_time)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_expiration_date_timeout() -> void:
	print("expired")
	print($expiration_date.get_wait_time())
	Global.market.remove_banana(self)
	seller.sold = false



func _on_tree_exiting() -> void:
	if sold:
		Global.market.quantity_analysis += 1
		Global.market.price_analysis += price
