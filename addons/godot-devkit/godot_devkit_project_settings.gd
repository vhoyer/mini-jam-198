class_name GodotDevkitSettings
extends RefCounted

const ROOT = 'godot_devkit'
const CONFIG:= {
	'transition_scene': {
		'category': 'stage_manager',
		'basic': true,
		'default': 'res://addons/godot-devkit/StageManager/transition/stage_manager_transition.tscn',
		'type': TYPE_STRING,
		'hint': PROPERTY_HINT_FILE,
		'hint_string': '*.tscn,*.scn',
	},
	'custom_empty_save_data_type': {
		'category': 'save_manager',
		'basic': false,
		'default': '',
		'type': TYPE_STRING,
		'hint': PROPERTY_HINT_TYPE_STRING,
		'hint_string': 'SaveData',
	},
}


static func _get_key(name: String) -> String:
	return '%s/%s/%s' % [
		ROOT,
		CONFIG[name].category,
		name]


static func setup_settings() -> void:
	for name: String in CONFIG.keys():
		var config = CONFIG[name]
		var key = _get_key(name)
		ProjectSettings.set_setting(key, _get_config(name))
		ProjectSettings.set_initial_value(key, config.default)
		ProjectSettings.set_as_basic(key, config.basic)
		ProjectSettings.add_property_info({
			"name": key,
			"type": config.type,
			"hint": config.hint,
			"hint_string": config.hint_string,
		})


static func _get_config(name: String) -> Variant:
	var key = _get_key(name)
	if ProjectSettings.has_setting(key):
		return ProjectSettings.get_setting_with_override(key)
	else:
		return CONFIG[name].default



static var transition_scene: String:
	get(): return _get_config('transition_scene')


static var empty_save_type: Resource:
	get():
		var klass_name = StringName(_get_config('custom_empty_save_data_type'))
		var klass_list = ProjectSettings.get_global_class_list()
		var index:= klass_list.find_custom(func(_klass: Dictionary):
			return _klass.class == klass_name)

		if index == -1:
			return SaveDataEmptyDefault

		var klass:= klass_list[index] as Dictionary
		return load(klass.path)
