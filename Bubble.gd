extends Area2D
var velocidad : int


func _process(delta):
	global_position.x += velocidad * delta


func _on_VisibilityEnabler2D_screen_exited():
	queue_free()
