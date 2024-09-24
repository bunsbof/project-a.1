shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture; // Ensure SCREEN_TEXTURE is defined
uniform float size = 10.0;

void fragment() {
    vec2 p = floor(FRAGCOORD.xy / size) * size;
    vec2 quat_x = vec2(size / 4.0, 0);
    vec2 quat_y = vec2(0, quat_x.x);

    // Sum the colors from the surrounding texels
    vec3 color_sum = vec3(0.0);
    
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            color_sum += texelFetch(SCREEN_TEXTURE, ivec2(p + quat_x * float(i) + quat_y * float(j)), 0).xyz;
        }
    }

    // Average the colors and set the output color
    COLOR = vec4(color_sum / 16.0, 1.0);
}