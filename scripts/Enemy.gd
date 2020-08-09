extends Entity
class_name Enemy

export var value: int

func _physics_process(delta: float) -> void:
	position.x -= speed * delta
	

func _on_Enemy_area_entered(area):
	var bullet := area as Bullet
	if not bullet:
		return
	
	$HitSound.play()
	$AnimationPlayer.play("hit")
	bullet.queue_free()
	damage(self)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


