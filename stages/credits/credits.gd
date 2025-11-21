extends Control


@export_file('*.tscn', '*.scn')
var next_scene: String


func _ready() -> void:
	%CreditsRoll.finished.connect(StageManager.push_stage.bind(next_scene))
