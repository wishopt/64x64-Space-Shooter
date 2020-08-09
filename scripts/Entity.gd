extends Area2D
class_name Entity

# This script and the scripts that inherit from it assume that 
# get_parent() returns the "World" node

export(int) var speed = 30
export(int) var health = 3

const ExplosionEffect = preload("res://scenes/ExplosionEffect.tscn")

signal died(node)
signal damaged(node)

func _ready() -> void:
	connect("died", get_parent(), "entity_died")
	connect("damaged", get_parent(), "entity_damaged")


func die(node: Area2D) -> void:
	# Play explosion
	var explosion = ExplosionEffect.instance()
	explosion.position = position
	get_parent().add_child(explosion)
	
	# Tell the World script what died
	emit_signal("died", node)
	
	# Remove Entity
	queue_free()

func damage(node: Area2D) -> void:	
	health -= 1
	emit_signal("damaged", node)
	if health <= 0:
		die(node)
