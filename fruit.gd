extends PhysicsBody2D

@export var tier: int
var protected: bool = true

var sizes = [0.5, 0.75, 1, 1.25, 1.5, 2, 2.25, 2.75, 3.25, 3.75, 4.5]

var colors = [
	Color(1, 0, 0),
	Color(1, 0.5, 0.75),
	Color(0.55, 0, 1),
	Color(1, 0.70, 0.6),
	Color(1, 0.65, 0.2),
	Color(1, 0, 0),
	Color(1, 1, 0.5),
	Color(1, 0.5, 0.75),
	Color(1, 1, 0),
	Color(0.2, 0.75, 0),
	Color(0.1, 0.5, 0)
]

func _ready():
	protected = true

func _physics_process(_delta):
	update_scale(Vector2(sizes[tier], sizes[tier]))

func _on_body_entered(body):
	call_deferred("process_collision", body)

func process_collision(body):
	if is_queued_for_deletion() or body.is_queued_for_deletion():
		return
	if body.is_in_group("Fruit") and body.get_tier() == tier:
		body.queue_free()
		queue_free()
		get_parent().call("on_fruit_combined", body.position, tier+1)

func get_tier():
	return tier

func set_tier(t):
	self.tier = t
	$Sprite.modulate = colors[t]
	update_scale(Vector2(sizes[t], sizes[t]))

func get_protected():
	return self.protected

func update_scale(s):
	self.scale = s
	$FruitCollider.scale = s

func _on_spawn_prot_timeout():
	protected = false
