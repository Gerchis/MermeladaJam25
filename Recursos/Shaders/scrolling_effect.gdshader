shader_type canvas_item;

uniform sampler2D scrolling_texture: repeat_enable;
uniform float scroll_speed = 1.;

void fragment() {
	float uv_offset = TIME * scroll_speed;
	vec4 scrolled_texture = texture(scrolling_texture, vec2(UV.x + uv_offset, UV.y));
	COLOR = scrolled_texture;
}

