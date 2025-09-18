//
// Example greyscale filter shader.
// 

#version 300 es
precision mediump float;

in vec2 v_texcoord;
out vec4 fragColor;

uniform sampler2D tex;

void main() {

    vec4 pixColor = texture2D(tex, v_texcoord);

    //vec3 greyScale = vec3(0.4, 0.25, 0.3);
    vec3 greyScale = vec3(0.2126, 0.7152, 0.0722); // REC.709
    fragColor = vec4(vec3(dot(pixColor.rgb, greyScale)), pixColor.a);
}
