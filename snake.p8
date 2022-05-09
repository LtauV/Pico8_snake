pico-8 cartridge // http://www.pico-8.com
version 35
__lua__
grid_size=4
update_rate=5

function make_apple()
	apple={}
	apple.x=flr(rnd(128/grid_size))
	apple.y=flr(rnd(128/grid_size))
	
	apple.draw=function(self)
		rectfill(self.x*grid_size,
		self.y*grid_size,
		(self.x+1)*grid_size-1,
		(self.y+1)*grid_size-1,
		8)
	end
	return apple
end

function _init()
	ticks=0
	apples={}
		for i=1,2 do 
		add(apples,make_apple())
	end
	snake={}
	snake.x=2
	snake.y=3
	snake.prev_x=0
	snake.prev_y=0
	snake.dx=1
	snake.dy=0
	snake.body={}
	snake.draw=function(self)
		rectfill(self.x*grid_size,
		self.y*grid_size,
		(self.x+1)*grid_size-1,
		(self.y+1)*grid_size-1,
		3)
		
		for part in all(self.body) do
		rectfill(part.x*grid_size,
		part.y*grid_size,
		(part.x+1)*grid_size-1,
		(part.y+1)*grid_size-1,
		3)
		end
		
	end
	snake.update=function(self)
		snake.prev_x=snake.x
		snake.prev_y=snake.y
	
		snake.x+=snake.dx
		snake.y+=snake.dy
	
	for part in all(self.body) do
		orig_x=part.x
		orig_y=part.y
		
		part.x=snake.prev_x
		part.y=snake.prev_y
		
		snake.prev_x=orig_x
		snake.prev_y=orig_y
	end
	
	
	
	ate_apple=false
	for apple in all(apples) do
		if apple.x==snake.x
		and apple.y==snake.y then
			del(apples,apple)
			add(apples,make_apple())
			ate_apple=true
			end
		end
		
		if ate_apple then
			add(snake.body, {
				x=self.prev_x,
				y=self.prev_y
				})
	 end
		
	end	
end

function _update()
	if(btn(➡️)) then
		snake.dx=1
		snake.dy=0
	elseif(btn(⬆️)) then
		snake.dx=0
		snake.dy=-1
	elseif(btn(⬅️)) then
		snake.dx=-1
		snake.dy=0
	elseif(btn(⬇️)) then
		snake.dx=0
		snake.dy=1
	end
	
	ticks+=1
	if ticks>=update_rate then
		snake:update()
		ticks=0
	end
end

function _draw()
	cls(1)
	
	for apple in all(apples) do
		apple:draw()
	end
	
	snake:draw()
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
