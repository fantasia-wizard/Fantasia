shader_type canvas_item;

uniform sampler2D noise;

void fragment(){
	vec4 prev_color = texture(TEXTURE, UV);
	vec4 new_color = prev_color;
	vec4 noise_color = vec4(0, 0, 0, 1.0);
	float noise_combined = 1.0;
	noise_color.r = texture(noise, TIME/10.0+vec2(SCREEN_UV.y, -SCREEN_UV.x)/2.0).r;
	noise_color.g = texture(noise, TIME/11.0+vec2(-SCREEN_UV.y, -SCREEN_UV.x)/2.0).g;
	noise_color.b = texture(noise, TIME/12.0+SCREEN_UV/2.0).b;
	noise_combined = 2.0-clamp(noise_color.r + noise_color.g + noise_color.b, 0.0, 1.0);
	new_color *= vec4(noise_combined, noise_combined, noise_combined, 1.0);
	if ( prev_color.b > 0.5 ){
		if ( prev_color.g < 0.5 ){
		COLOR = new_color;
		}
		else{
			COLOR = prev_color;
		}
	}
	else{
		COLOR = prev_color;
	}
	
}