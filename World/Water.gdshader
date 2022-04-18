shader_type canvas_item;

uniform sampler2D noise;

void fragment(){
	vec4 prev_color = texture(TEXTURE, UV);
	vec4 new_color = prev_color;
	if (prev_color.b >= 0.6){
		if (prev_color.g <= 0.5){
		new_color.rgb += texture(noise, SCREEN_UV+vec2(TIME, TIME)/4.0).rgb/75.0;
			}
		}
	COLOR = new_color;
}