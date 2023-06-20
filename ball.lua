Ball=Class{}

function Ball:init(x,y)
         self.x=x
         self.y=y
        
         self.width=10
         self.height=10


         self.dx=0
         self.dy=25


end

function Ball:reset()
	self.x = 100
	self.y = 50
	
	self.dx = 0
	self.dy = 25
end

function Ball:update(dt)
          ball.y = ball.y + ball.dy*dt
end

function Ball:render()
          love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
