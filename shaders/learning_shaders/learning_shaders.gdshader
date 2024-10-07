shader_type canvas_item;

const float f[3] = float[] (0.25,0.1,0.3);
const vec3 v[] = {vec3(2)};


void fragment(){
	//COLOR.rgb *= mix(1.0,0.5, step(0.5,UV.x));
	switch(1){
		case -1:
			COLOR.r = 0.0;
			break;
		case 1:
			COLOR.r = 0.0;
			break;
	}
}
