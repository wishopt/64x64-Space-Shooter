extends Entity
class_name Player

const Bullet = preload("res://scenes/Bullet.tscn")

var move_direction: Vector2
var motion: Vector2


func _physics_process(delta: float) -> void:
	move(delta)
	
	if Input.is_action_just_pressed("shoot"):
		fire_bullet()


func move(delta: float) -> void:
	var window = get_viewport_rect()
	position += get_move_direction() * speed * delta
	
	# Keep player inside window - Could probably be optimized a lot
		# Bug: Player can slip throw the corner when going diagonally. 
		# Snaps back immediately when he lets go of the keys, so it's not a problem
	if position.x <= 0:
		position.x = 1
	elif position.x > window.size.x:
		position.x = window.size.x - 1
	elif position.y <= 0:
		position.y = 1
	elif position.y > window.size.y:
		position.y = window.size.y - 1
	
	
func get_move_direction() -> Vector2:
	var x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	var y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))	
	return Vector2(x, y).normalized()


func fire_bullet() -> void:	
	var bullet = Bullet.instance()
	var offset = Vector2(6, 0)
	bullet.position = position + offset
	get_parent().add_child(bullet)


func _on_Player_area_entered(area):
	var enemy := area as Enemy
	if not enemy:
		return
	
	enemy.die(enemy)
	damage(self)
