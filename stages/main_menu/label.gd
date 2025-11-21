@tool
extends Label


func _ready() -> void:
	self.text = ProjectSettings.get_setting_with_override('application/config/name')
