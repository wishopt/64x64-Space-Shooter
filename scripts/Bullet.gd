extends Area2D
class_name Bullet

export(int) var speed = 400

func _physics_process(delta: float) -> void:
	position.x += speed * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
