extends CharacterBody2D

@onready var gun_pivot: Marker2D = $"Gun Pivot"
@onready var gun: Marker2D = $"Gun Pivot/Gun"
@onready var bullet = preload("res://Top-Down Shooter Minigame/bullet.tscn")

const speed = 100
var bullet_speed = 900

var direction = Vector2.ZERO

func _physics_process(delta: float) -> void:
	
	var last_dir = []
	
	direction = Input.get_vector("a",
	"d",
	"w",
	"s")
	
	gun_pivot.rotation = lerp_angle(gun_pivot.rotation, (get_global_mouse_position() - global_position).angle(), 6.5 * delta)
	
	if Input.is_action_just_pressed("space") == true:
		var bullet = bullet.instantiate()
		bullet.position = gun.global_position
		bullet.rotation_degrees = gun_pivot.rotation_degrees
		bullet.apply_impulse(Vector2(bullet_speed, 0).rotated(gun_pivot.rotation))
		get_tree().get_root().add_child(bullet)
	
	velocity = speed * direction
	
	move_and_slide()
