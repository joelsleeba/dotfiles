//
// Example greyscale filter shader.
// 

precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {

    vec4 pixColor = texture2D(tex, v_texcoord);

    vec3 greyScale = vec3(0.4, 0.25, 0.3);
    gl_FragColor = vec4(vec3(dot(pixColor.rgb, greyScale)), pixColor.a);
}
