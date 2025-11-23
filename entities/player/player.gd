extends VehicleBody3D


const MAX_STEER = 0.8
const ENGINE_POWER = 100


@onready
var _center_of_mass_marker: Marker3D = %CenterOfMass

@onready
var _camera_pivot: Node3D = %CameraPivot

@onready
var _camera_main: Camera3D = %CameraMain

@onready
var _camera_base_look_at: Marker3D = %BaseCameraLookAt

@onready
var _looking_product_position: Marker3D = %LookingProductPosition

@onready
var _base_camera_position: Marker3D = %BaseCameraPosition


@onready
var _hands_reach_area: Area3D = %HandsReachArea3D


@onready
var _velocity_label: Label = %Velocity


var _look_from_pos: Vector3 = Vector3.ZERO
var _look_at_pos: Vector3

var _closest_product: ProductBox = null:
	set(value):
		_closest_product = value
		ProductBox.current_selected = value

var _products_in_range: Array = []
var _hand_pos: Vector3:
	get(): return _hands_reach_area.global_position


func _ready() -> void:
	center_of_mass = _center_of_mass_marker.position

	## camera stuff
	_camera_pivot.top_level = true
	_look_at_pos = _camera_base_look_at.global_position


func _physics_process(delta: float) -> void:
	## car move stuff
	steering = move_toward(steering, Input.get_axis('right', 'left') * MAX_STEER, delta * 2.5)
	engine_force = Input.get_axis('backward', 'forward') * ENGINE_POWER

	## product logic stuff
	if _products_in_range.size() <= 0:
		_closest_product = null
	else:
		var distance_to_closest_product:= _closest_product.global_position.distance_squared_to(_hand_pos) \
				if _closest_product else INF
		for candidate: ProductBox in _products_in_range:
			if distance_to_closest_product < candidate.global_position.distance_squared_to(_hand_pos):
				continue
			_closest_product = candidate
			distance_to_closest_product = _closest_product.global_position.distance_squared_to(_hand_pos)

	## camera stuff
	_camera_pivot.global_position = _camera_pivot.global_position.lerp(self.global_position, delta * 20.0)
	_camera_pivot.transform = _camera_pivot.transform.interpolate_with(self.transform, delta * 2.5)

	var look_at_point:= _camera_base_look_at.global_position
	_look_from_pos = _base_camera_position.global_position

	if self.linear_velocity.length_squared() > 2:
		look_at_point = look_at_point + self.linear_velocity
	elif _closest_product:
		_look_from_pos = _looking_product_position.global_position
		look_at_point = _closest_product.global_position

	_camera_main.global_position = _camera_main.global_position.lerp(_look_from_pos, delta * 2.5)

	_look_at_pos = _look_at_pos.lerp(look_at_point, delta * 5.0)
	_camera_main.look_at(_look_at_pos)

	_camera_main.fov = lerp(75, 90, self.linear_velocity.length_squared() * 0.001)


func _process(_delta: float) -> void:
	## debug
	_velocity_label.text = '√%.1f m/s' % [self.linear_velocity.length_squared()]


func _on_hands_reach_area_3d_body_entered_or_exited(_body: Node3D) -> void:
	_products_in_range = _hands_reach_area.get_overlapping_bodies()
