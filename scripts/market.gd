extends Node
var produce : Array = []
var ledger_text = ""
var label_scene = preload("res://scenes/leave_label.tscn")
var test_scene = preload("res://scenes/test.tscn")
var farmer_scene = preload("res://scenes/farmer.tscn")
var monkey_scene = preload("res://scenes/monkey.tscn")
var n_farmers = 5
var n_monkeys = 5

var quantity_analysis : int = 0
var price_analysis : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pop_market()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if produce.size() > 0:
		ledger_text = ""
		for banana in produce:
			ledger_text += str(banana[0]) + "\t" + str(banana[1]) + "\n"
		$banana_spawning/Ledger.text = ledger_text
		pass



func add_banana(banana:Node2D):
	add_child(banana)
	Global.ID += 1
	var b_name = str("Banana_",Global.ID)
	banana.name = b_name
	var price = banana.price
	var index = Global.binary_search(price,produce)
	produce.insert(index,[b_name,price])
	banana.position = banana.seller.position + Vector2(0,10)
	print(banana.seller.position)
	#banana.position.x = randf_range(100,1100)
	#banana.position.y = randf_range(100,700)
	
func remove_banana(banana):
	for i in range(0,produce.size()):
		if produce[i][0] == banana.name:
			produce.remove_at(i)
			
			banana.queue_free()
			return
	
func _on_child_exiting_tree(node: Node) -> void:
	if node.is_in_group("banana"):
		var farmer = node.seller

		if node.sold == true:
			farmer.sold = true
			add_label(node,"sold")
		else:
			node.seller.sold = false
			add_label(node,"expired")

func add_label(banana: Node2D,text: String) :

	var label = label_scene.instantiate()
	add_child.call_deferred(label)
	label.position = banana.position
	label.get_node("leave_label").text = text
	label.get_node("AnimationPlayer").play("new_animation")
	
	
func pop_market():
	for i in n_farmers:
		var farmer = farmer_scene.instantiate()
		add_child(farmer)
		farmer.position = $farmer_square.position + Vector2(i * 50 + 15,15)
	for i in n_monkeys:
		var monkey = monkey_scene.instantiate()
		add_child(monkey)
		monkey.position = $monkey_square.position + Vector2(i * 50 + 15,15)


func analysis():
	var x =quantity_analysis
	var y = -price_analysis
	var graph_origin = Vector2(650,800)
	var point = Sprite2D.new()
	point.texture = "res://assets/point.png"
	point.position = graph_origin + Vector2(x,y)
