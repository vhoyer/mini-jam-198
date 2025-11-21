class_name SaveData
extends MemoryData


func empty() -> bool:
	return file_time == 0


func unlock_achievement(_what) -> void:
	push_warning('overwrite this method to do achievements')
	pass


var file_time: float:
	get():
		return _short_term.get_item('file_time', 0)
	set(value):
		_short_term.set_item('file_time', value)
