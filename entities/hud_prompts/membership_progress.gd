extends MarginContainer


@onready
var current_dep: Label = %CurrentDep

@onready
var progress: ProgressBar = %MembershipProgress


var data: GameSaveData:
	get(): return SaveManager.data


func _ready() -> void:
	SaveManager.data.changed.connect(_on_save_data_changed)
	_on_save_data_changed('')


func _on_save_data_changed(what: String) -> void:
	if not what or what == 'balance':
		progress.value = data.spent
	if not what or what == 'current_limit':
		progress.max_value = data.current_limit
	if not what or what == 'current_department':
		current_dep.text = 'current: %s' % data.current_department
	pass
