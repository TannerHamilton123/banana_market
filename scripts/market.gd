
extends Node
var produce : Array = []
var ledger_text = ""

var test_scene = preload("res://scenes/test.tscn")
var farmer_scene = preload("res://scenes/farmer.tscn")
var monkey_scene = preload("res://scenes/monkey.tscn")
var banana_scene = preload("res://scenes/banana.tscn")
var n_farmers = 1
var n_monkeys = 1
var starting_price = 10
var time = 0 
var quantity_analysis : int = 0
var price_analysis : float = 0
var scatter_series = ScatterSeries.new(Color.RED, 5.0, ScatterSeries.SHAPE.CIRCLE)
var scatter_array = [scatter_series]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$UI/expiration/expiration_date.text= str("expiration date\n" + str(Global.expiration_time) + " seconds")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	time = Global.round_to_cent(time)
	$time_label.text = str(time)
	if produce.size() > 0:
			ledger_text = ""
			for banana in produce:
				ledger_text += str(banana[0]) + "\t" + str(banana[1]) + "\n"
			$banana_spawning/Ledger.text = ledger_text

func remove_banana(banana):
	for i in range(0,produce.size()):
		if produce[i][0] == banana.name:
			produce.remove_at(i)
			
			banana.queue_free()
			return
	


func analysis():
	var x : float = quantity_analysis / float(n_farmers)
	var y : float =  (price_analysis / quantity_analysis)
	scatter_array[-1].add_point(x,y)
	
	$graph_2d.add_series(scatter_array[-1])
	quantity_analysis = 0
	price_analysis = 0
	

func _on_market_analysis_timeout() -> void:
	analysis()
	pass # Replace with function body.
	



func _on_add_farmer_pressed() -> void:
	if n_farmers >= 20:
		return
	n_farmers += 1
	var farmer = farmer_scene.instantiate()
	$farmer_square.add_child(farmer)
	farmer.name = str("farmer",n_farmers)
	farmer.position = $farmer_square/farmer.position + Vector2(60 * (n_farmers-1),0)


func _on_subtract_farmer_pressed() -> void:

	if n_farmers == 1:
		return
	var removed = $farmer_square.get_child(-1)
	for banana in removed.get_children():
		remove_banana(banana)
	removed.queue_free()
	n_farmers -= 1

	print($expiration_date.get_wait_time())
func _on_add_monkey_pressed() -> void:
	if n_monkeys >= 20:
		return
	n_monkeys += 1
	var monkey = monkey_scene.instantiate()
	$monkey_square.add_child(monkey)
	monkey.name = str("monkey",n_monkeys)
	monkey.position = $monkey_square/monkey.position + Vector2(60 * (n_monkeys-1),0)



func _on_clear_graph_pressed() -> void:
	for series in scatter_array:
		series.clear_data()
	pass # Replace with function body.


func _on_expiration_value_changed(value: float) -> void:
	Global.expiration_time = value
	$UI/expiration/expiration_date.text= str("expiration date\n" + str(value) + "sec")
	pass # Replace with function body.


func _on_pause_toggled(toggled_on: bool) -> void:
	get_tree().paused = toggled_on


func _on_color_picker_button_color_changed(color: Color) -> void:
	var scatter_series_new = ScatterSeries.new(color, 5.0, ScatterSeries.SHAPE.CIRCLE)
	scatter_array.append(scatter_series_new)
	pass # Replace with function body.
