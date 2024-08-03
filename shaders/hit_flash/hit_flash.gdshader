shader_type canvas_item;

uniform bool active;
uniform float amount = 1.0;

void fragment() {
	
	if (active == true)
	{
		COLOR = texture(TEXTURE,UV);
		
		COLOR.r = texture(TEXTURE,UV).r + amount;
		COLOR.g = texture(TEXTURE,UV).g + amount;
		COLOR.b = texture(TEXTURE,UV).b + amount;
	}
}


