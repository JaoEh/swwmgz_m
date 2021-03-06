float rnd( in vec2 sd )
{
	//return cos(sd.y*3874.8674+sd.x*6783.5325)*2737.8474;
	// use noise tex instead of trig-based PRNG, much better and doesn't break on intel
	return texelFetch(noisetex,ivec2(mod(sd.x,256.),mod(sd.y,256.)),0).x;
}

// haha are you telling me I can't declare arrays like in C?
// what the fuck even is this insane syntax?
const vec3 layers[3] =
vec3[](
	vec3(0.91,0.87,1.95),
	vec3(0.66,1.84,0.73),
	vec3(1.35,0.73,1.21)
);
const float speed[3] =
float[](
	.5526,
	.7843,
	.3725
);
const float zoom[3] =
float[](
	1.,
	2.,
	3.
);

vec4 ProcessTexel()
{
	vec2 coord;
	vec3 col = vec3(1.);
	for ( int i=0; i<3; i++ )
	{
		coord = floor(vTexCoord.st*textureSize(tex,0)/zoom[i]);
		col *= layers[i]*2.0*abs(fract(rnd(coord)+timer*speed[i])-0.5);
	}
	return vec4(col,1.);
}
