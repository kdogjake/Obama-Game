extends Node2D

@export var FruitScene: PackedScene

var score = 0

var points = [1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 66]

func _ready():
	$Canvas/GameOver.visible = false

func on_fruit_combined(pos, tier):
	increase_score(points[tier-1])
	if tier <= 10:
		var new_fruit = FruitScene.instantiate()
		new_fruit.position = pos
		call_deferred("add_child", new_fruit)
		new_fruit.call_deferred("set_tier", tier)

func spawn_fruit(pos, tier):
	var new_fruit = FruitScene.instantiate()
	new_fruit.position = pos
	call_deferred("add_child", new_fruit)
	new_fruit.call_deferred("set_tier", tier)

func increase_score(increase):
	score += increase
	$Score.text = str(score)

func _on_top_body_entered(body):
	if body.is_in_group("Fruit"):
		if not body.get_protected():
			game_over()

func game_over():
	$Canvas/GameOver.visible = true
	$Canvas/GameOver/VBoxContainer/FinalScore.text = "Final Score: " + str(score)
	get_tree().paused = true

func _on_quit_pressed():
	get_tree().quit()
