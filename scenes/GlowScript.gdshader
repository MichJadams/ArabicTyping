shader_type canvas_item;

uniform float outline_width : hint_range(0.0, 1) = 0.05;
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 0.5);

void vertex() {
    // No changes to the vertex function
}
void fragment() {
    vec4 col = COLOR;

    // Calculate the outline based on the distance from the text
    float outline = smoothstep(1.0 - outline_width, 1.0, col.a);

    // Mix the outline color with the text color, considering the original color
    col.rgb = mix(outline_color.rgb, col.rgb, outline);
    
    // Set the alpha based on the outline strength
    col.a = max(col.a, outline);

    COLOR = col;
}

