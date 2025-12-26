extends Area2D

@export var stats : Resource

@onready var particles: CPUParticles2D = $Particles
@onready var sprite_2d: Sprite2D = $Sprite2D

var fall_speed
var value
var color

func _ready() -> void:
	value = stats.value
	fall_speed = stats.fall_speed
	particles.color = stats.color

func _process(delta: float) -> void:
	position += Vector2(0, fall_speed/10)

func _on_body_entered(body: Node2D) -> void:
	particles.emitting = true
	sprite_2d.visible = false
	collision_layer = 12


func _on_particles_finished() -> void:
	queue_free()
