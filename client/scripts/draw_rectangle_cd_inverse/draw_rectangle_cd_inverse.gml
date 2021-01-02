// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function draw_rectangle_cd_inverse(x1, y1, x2, y2, v){
	/// draw_rectangle_cd(x1, y1, x2, y2, value)
	//modification of the YAL script with x coords reversed to flip the shape and values reversed
	var xm, ym, vd, vx, vy, vl;
	
	//Inversion
	var temp_x = x2
	x2 = x1
	x1 = temp_x
	v = 1 - v
	
	
	if (v <= 0) return draw_rectangle(x1, y1, x2, y2, false) // entirely filled
	if (v >= 1) return 0 // nothing to be drawn
	xm = (x1 + x2) / 2; ym = (y1 + y2) / 2; // middle point
	draw_primitive_begin(pr_trianglefan)
	draw_vertex(xm, ym); draw_vertex(xm, y1)
	// draw corners:
	if (v >= 0.125) draw_vertex(x2, y1)
	if (v >= 0.375) draw_vertex(x2, y2)
	if (v >= 0.625) draw_vertex(x1, y2)
	if (v >= 0.875) draw_vertex(x1, y1)
	// calculate angle & vector from value:
	vd = pi * (v * 2 - 0.5)
	vx = cos(vd)
	vy = sin(vd)
	// normalize the vector, so it hits -1+1 at either side:
	vl = max(abs(vx), abs(vy))
	if (vl < 1) {
	    vx /= vl
	    vy /= vl
	}
	draw_vertex(xm + vx * (x2 - x1) / 2, ym + vy * (y2 - y1) / 2)
	draw_primitive_end()
}
