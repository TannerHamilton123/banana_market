extends Node2D
var produce : Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func add_banana(banana:Node2D,price:float):
	
	add_child(banana)
	Global.ID += 1
	banana.name = str("Banana_",Global.ID)
	var index = Global.binary_search(price,produce)
	produce.insert(index,[banana.name,price])
	banana.position.x = randf_range(100,1100)
	banana.position.y = randf_range(100,700)
	print(produce)
	
func remove_banana(banana):
	for i in range(0,produce.size()):
		if produce[i][0] == banana.name:
			produce.remove_at(i)
			
			banana.queue_free()
			return
	
