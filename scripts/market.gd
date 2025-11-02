extends Node2D
var produce : Array = []
var ledger_text = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$time_to_buy.time = randf_range(0,1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if produce.size() > 0:
		ledger_text = ""
		for banana in produce:
			ledger_text += str(banana) + "\n"
		$Ledger.text = ledger_text
		pass



func add_banana(banana:Node2D):
	
	add_child(banana)
	Global.ID += 1
	var b_name = str("Banana_",Global.ID)
	banana.name = b_name
	var price = banana.price
	var index = Global.binary_search(price,produce)
	produce.insert(index,[b_name,price])
	banana.position.x = randf_range(100,1100)
	banana.position.y = randf_range(100,700)
	
func remove_banana(banana):
	for i in range(0,produce.size()):
		if produce[i][0] == banana.name:
			produce.remove_at(i)
			
			banana.queue_free()
			return
	
func _on_child_exiting_tree(node: Node) -> void:
	var farmer = node.seller
	if node.sold == true:
		farmer.sold = true
	else:
		node.seller.sold = false
		#print(node ," not sold")
	pass # Replace with function body.
