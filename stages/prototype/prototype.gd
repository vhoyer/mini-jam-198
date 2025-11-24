extends Node


var data: GameSaveData:
	get(): return SaveManager.data


func _ready() -> void:
	SaveManager.data.changed.connect(_on_save_data_changed)
	_on_save_data_changed('')


func _on_save_data_changed(what: String) -> void:
	if what == 'current_department':
		StageManager.reload_current_stage()
		pass
