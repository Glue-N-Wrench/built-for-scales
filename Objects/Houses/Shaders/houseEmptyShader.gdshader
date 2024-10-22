shader_type canvas_item;

uniform float time = 0.0; //time of day in game
uniform float scale = 1.0; //invese size of the window pixels

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 texColor = texture(TEXTURE, UV);
	COLOR = texColor;
	float offsetTime = time + (0.1*UV.y) - 0.1;
	float fudgeValue = (offsetTime-0.5); //for use at night to fudge transitions; between 0 and 0.25
	fudgeValue = -16.0*fudgeValue*fudgeValue+1.0;
	if (offsetTime > 0.25 && offsetTime < 0.75) {//night
		COLOR = texColor - (vec4(0.2,0.2,0.2,0)*fudgeValue); //dark house
	}
	if (texColor == vec4(1, 0, 0, 1)){ // RED = window
		vec2 screenCord = (SCREEN_UV/vec2(4))/SCREEN_PIXEL_SIZE;
		//screenCord = mod(screenCord, vec2(5));
		if ( int(screenCord.x)%7 == -int(screenCord.y)%7 || int(screenCord.x)%8 == -int(screenCord.y)%8)
			COLOR = vec4(0.8,0.8,0.8,1); // window white
		else
			COLOR = vec4(0.5,0.5,0.6,1); // window orange
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
