extends Node2D


export(PackedScene) var Enemy
var last_spawn_point: Position2D = null


func get_spawn_point() -> Position2D:
	# Get random spawn point
	var spawn_points = $SpawnPoints.get_children()
	var spawn_point = spawn_points[randi() % spawn_points.size()]
	
	# Avoid repeating the same spawn point
	if spawn_point == last_spawn_point:
		spawn_point = get_spawn_point()
	last_spawn_point = spawn_point
	
	return spawn_point


func spawn_enemy() -> void:
	var spawn: Position2D = get_spawn_point()
	var enemy = Enemy.instance()
	enemy.position = spawn.position
	get_parent().add_child(enemy)


func _on_Timer_timeout():
	spawn_enemy()
