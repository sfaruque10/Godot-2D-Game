shader_type canvas_item;
render_mode unshaded;

// uniforms allows adjusting the effect in the Inspector
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float strength : hint_range(0.0, 1.0) = 0.2;
uniform float black_radius : hint_range(0.0, 1.0) = 0.3;
uniform float distortion_radius : hint_range(0.0, 1.0) = 0.6;

void fragment() {
    // get direction and distance from the center of the node 
    vec2 center = vec2(0.5, 0.5);
    vec2 diff = center - UV;
    float dist = length(diff) * 2.0; // distance normalized 
    vec2 dir = normalize(diff);

    // create the black center (the "Void")
    if (dist < black_radius) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        // offset the screen pixels
        // the closer to the black hole, the more distortion happens
        float f = clamp(1.0 - dist, 0.0, distortion_radius);
        float offset = f * f * strength;
        
        // sample the background using distorted UVs
        vec2 distorted_uv = SCREEN_UV + (dir * offset);
        COLOR = texture(screen_texture, distorted_uv);
    }
}