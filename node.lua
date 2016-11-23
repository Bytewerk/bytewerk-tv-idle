gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)
sys.set_flag("slow_gc")
--util.noglobals()



util.resource_loader{
	"bytewerk_logo.png",
	"lugin_logo.png",
	"bingo_logo.png"
}



local distort_shader = resource.create_shader([[
	uniform sampler2D Texture;
	uniform float effect;
	varying vec2 TexCoord;
	uniform vec4 Color;
	void main() {
		vec2 uv = TexCoord.st;
		vec4 col;
		col.r = texture2D(Texture, vec2(uv.x+sin(uv.y*20.0*effect)*0.2,uv.y)).r;
		col.g = texture2D(Texture, vec2(uv.x+sin(uv.y*25.0*effect)*0.2,uv.y)).g;
		col.b = texture2D(Texture, vec2(uv.x+sin(uv.y*30.0*effect)*0.2,uv.y)).b;
		col.a = texture2D(Texture, vec2(uv.x,uv.y)).a;
		vec4 foo = vec4(1.0,1.0,1.0,effect);
		col.a = 1.0;
		gl_FragColor = Color * col * foo;
}
]])



local bw_logo_w=343 --343 original
local bw_logo_h=382 --382 original
local bi_logo_w=666 --910 original
local bi_logo_h=300 --410 original
local lug_logo_w=734 --1003 original
local lug_logo_h=300 --410 original


--local font = resource.load_font("data-unifon.ttf")


function node.render()
	gl.clear(0,0,0,0)
	local now = sys.now()
	local phase = now%9
	moveInSpeed = 0.5


	local bw_logo_pos_y = (HEIGHT/2)
	local lug_logo_pos_y = (HEIGHT/2)
	local bi_logo_pos_y = (HEIGHT/2)

	if(phase < 1) then
		-- move bw logo from the right offscreen into center
		bw_logo_pos_x  = (WIDTH/2) +1500 -math.sin(phase*(math.pi*0.5))*1500
		lug_logo_pos_x = (WIDTH/2) +1500
		bi_logo_pos_x  = (WIDTH/2) +1500

	elseif(phase < 2)	then
		-- stay in center
		bw_logo_pos_x  = (WIDTH/2)
		lug_logo_pos_x = (WIDTH/2) +1500
		bi_logo_pos_x  = (WIDTH/2) +1500

	elseif(phase < 3) then
		-- slowly move out
		bw_logo_pos_x  = (WIDTH/2) -math.sin((phase-2)*(math.pi*0.5))*1500
		lug_logo_pos_x = (WIDTH/2) +1500
		bi_logo_pos_x  = (WIDTH/2) +1500


	elseif(phase < 4)	then
		-- move lug logo from the right offscreen into center
		bw_logo_pos_x  = (WIDTH/2) +1500
		lug_logo_pos_x = (WIDTH/2) +1500 -math.sin((phase-3)*(math.pi*0.5))*1500
		bi_logo_pos_x  = (WIDTH/2) +1500

	elseif(phase < 5)	then
		-- stay in center
		bw_logo_pos_x  = (WIDTH/2) +1500
		lug_logo_pos_x = (WIDTH/2)
		bi_logo_pos_x = (WIDTH/2) +1500


	elseif(phase < 6)	then
		-- slowly move out
		bw_logo_pos_x  = (WIDTH/2) +1500
		lug_logo_pos_x = (WIDTH/2) -math.sin((phase-5)*(math.pi*0.5))*1500
		bi_logo_pos_x  = (WIDTH/2) +1500

	elseif(phase < 7)	then
		-- move bingo logo from the right offscreen into center
		bw_logo_pos_x  = (WIDTH/2) +1500
		lug_logo_pos_x = (WIDTH/2) +1500
		bi_logo_pos_x  = (WIDTH/2) +1500 -math.sin((phase-6)*(math.pi*0.5))*1500

	elseif(phase < 8)	then
		-- stay in center
		bw_logo_pos_x  = (WIDTH/2) +1500
		lug_logo_pos_x = (WIDTH/2) +1500
		bi_logo_pos_x  = (WIDTH/2)

	elseif(phase < 9)	then
		-- slowly move out
		bw_logo_pos_x  = (WIDTH/2) +1500
		lug_logo_pos_x = (WIDTH/2) +1500
		bi_logo_pos_x  = (WIDTH/2) -math.sin((phase-8)*(math.pi*0.5))*1500

	else
		bw_logo_pos_x  = (WIDTH/2) +1500
		lug_logo_pos_x = (WIDTH/2) +1500
		bi_logo_pos_x  = (WIDTH/2) +1500

	end


	util.draw_correct( bytewerk_logo, 
		bw_logo_pos_x -bw_logo_w/2,
		bw_logo_pos_y -bw_logo_h/2,
		bw_logo_pos_x +bw_logo_w/2,
		bw_logo_pos_y +bw_logo_h/2
	)

	util.draw_correct( lugin_logo, 
		lug_logo_pos_x -lug_logo_w/2,
		lug_logo_pos_y -lug_logo_h/2,
		lug_logo_pos_x +lug_logo_w/2,
		lug_logo_pos_y +lug_logo_h/2
	)

	util.draw_correct( bingo_logo,
		bi_logo_pos_x -bi_logo_w/2,
		bi_logo_pos_y -bi_logo_h/2,
		bi_logo_pos_x +bi_logo_w/2,
		bi_logo_pos_y +bi_logo_h/2
	)
	--font:write(0, 0, phase, 100, 1,1,1,1)
	--util.post_effect(distort_shader, { effect = 2* math.sin(sys.now()*2);}) -- + remaining * math.sin(sys.now() * 50);})
end
