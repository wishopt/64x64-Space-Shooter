extends Node

var score: int = 0 setget update_score
var is_game_over: bool = false

func _ready() -> void:
	$GameOverScreen.visible = false
	$Score.visible = true


func _input(event) -> void:
	if event.is_action_pressed("restart") && is_game_over:
		restart()


func update_score(new_value) -> void:
	score = new_value
	$Score.text = str(score)


func entity_died(entity):
	if entity is Enemy:
		self.score += entity.value
	
	elif entity is Player:
		game_over()


func entity_damaged(entity):
	if entity is Player:
		print("oof")
		$HP.text = "HP: " + str(entity.health)


func game_over() -> void:
	is_game_over = true
	$GameOverScreen/Label.text = "Game Over\nYour Score: " + str(score) + "\nR to restart"
	$GameOverScreen.visible = true
	$Score.visible = false


func restart() -> void:
	get_tree().reload_current_scene()

