extends VehicleBody3D


const MAX_STEER = 0.8
const ENGINE_POWER = 100


@onready
var center_of_mass_marker: Marker3D = %CenterOfMass

@onready
var camera_pivot: Node3D = %CameraPivot

@onready
var camera_main: Camera3D = %CameraMain

@onready
var camera_base_look_at: Marker3D = %BaseCameraLookAt

@onready
var velocity_label: Label = %Velocity


var look_at_pos: Vector3


func _ready() -> void:
	center_of_mass = center_of_mass_marker.position

	## camera stuff
	camera_pivot.top_level = true
	look_at_pos = camera_base_look_at.global_position


func _physics_process(delta: float) -> void:
	steering = move_toward(steering, Input.get_axis('right', 'left') * MAX_STEER, delta * 2.5)
	engine_force = Input.get_axis('backward', 'forward') * ENGINE_POWER

	## camera stuff
	camera_pivot.global_position = camera_pivot.global_position.lerp(self.global_position, delta * 20.0)
	camera_pivot.transform = camera_pivot.transform.interpolate_with(self.transform, delta * 2.5)

	look_at_pos = look_at_pos.lerp(camera_base_look_at.global_position + self.linear_velocity, delta * 5.0)
	camera_main.look_at(look_at_pos)

	## debug
	velocity_label.text = '%.3f m/s' % [self.linear_velocity.length()]
