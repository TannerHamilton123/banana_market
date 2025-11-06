extends Node2D
var banana_scene = preload("res://scenes/banana.tscn")
var label_scene = preload("res://scenes/leave_label.tscn")
var price : float = 90.0
var sold : bool = false
var will_sell : bool = false
var willing_to_sell: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Global.market.connect("banana_sold","banana_to_market")
	$time_to_sell.set_wait_time(randf_range(1,2))
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

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

func determine_price():
	if will_sell:
		if sold:
			price = price + randf_range(0,10)
		else:
			price = price - randf_range(0,10)
		price = Global.round_to_cent(price)
	$price.text = str("$",price)
	


func decide_to_sell(banana_price):
	willing_to_sell = banana_price
	$willingness.text = str(floor(willing_to_sell) , "%")
	var chance = randi() % 100
	if chance < willing_to_sell:
		will_sell = true
	else:
		will_sell = false

func banana_to_market(banana_price):
	var banana = banana_scene.instantiate()
	banana.price = banana_price
	banana.seller = self
	add_child(banana)
	Global.ID += 1
	var b_name = str("Banana_",Global.ID)
	banana.name = b_name
	banana.position =Vector2(0,10)
	var index = Global.binary_search(price,Global.market.produce)
	Global.market.produce.insert(index,[b_name,price,banana.get_path()])
	
func add_label(banana: Node2D,text: String) :

	var label = label_scene.instantiate()
	add_child.call_deferred(label)
	label.position = banana.position
	label.get_node("leave_label").text = text
	label.get_node("AnimationPlayer").play("new_animation")




func _on_child_exiting_tree(node: Node) -> void:
	if node.is_in_group("banana"):
		var farmer = node.seller

		if node.sold == true:
			farmer.sold = true
			add_label(node,"sold")
		else:
			node.seller.sold = false
			add_label(node,"expired")
