extends Control
var price
var banana_name
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#if Global.market.produce.size() > 0:
		#for row in Global.market.produce:
			#banana_name = row[0]
			#price = row[1]
			#update_listings(banana_name,price)
		


func update_listings(banana_name,price):
	print("making listing for ",banana_name)
	var new_listing = HBoxContainer.new()
	var new_price = Label.new()
	new_price.text = str(price)
	var new_name = Label.new()
	new_name.text = banana_name
	new_listing.add_child(new_name)
	new_listing.add_child(new_price)
	$Listing.add_child(new_listing)
	
