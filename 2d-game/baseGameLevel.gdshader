shader_type canvas_item;
render_mode unshaded;

// Uniforms allow you to adjust the effect in the Inspector
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float strength : hint_range(0.0, 1.0) = 0.2;
uniform float black_radius : hint_range(0.0, 1.0) = 0.3;
uniform float distortion_radius : hint_range(0.0, 1.0) = 0.6;

void fragment() {
    // Get direction and distance from the center of the node (0.5, 0.5)
    vec2 center = vec2(0.5, 0.5);
    vec2 diff = center - UV;
    float dist = length(diff) * 2.0; // Distance normalized to 0.0-1.0
    vec2 dir = normalize(diff);

    // Create the black center (the "Void")
    if (dist < black_radius) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        // Gravitational Lensing: offset the screen pixels
        // The closer to the black hole, the more distortion happens
        float f = clamp(1.0 - dist, 0.0, distortion_radius);
        float offset = f * f * strength;
        
        // Sample the background using distorted UVs
        vec2 distorted_uv = SCREEN_UV + (dir * offset);
        COLOR = texture(screen_texture, distorted_uv);
    }
}