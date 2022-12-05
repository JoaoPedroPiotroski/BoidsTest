extends ColorRect

func _process(delta):
	return
	material.set_shader_param('offset_x', material.get_shader_param('offset_x') + delta / 16)
	material.set_shader_param('offset_y', material.get_shader_param('offset_y') - delta / 8)
