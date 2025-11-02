extends Node2D

var current_name : String
var price : float
var seller
var sold = false
signal did_not_sell
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$expiration.play("expire")
	current_name = self.name
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_expiration_date_timeout() -> void:
	Global.market.remove_banana(self)
	seller.sold = false
	did_not_sell.emit()
