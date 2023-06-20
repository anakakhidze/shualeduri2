push = require 'push'
Class = require 'class'

require 'Player'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

gameState = 'start'

PLAYER_SPEED = 8

function love.load()
	io.stdout:setvbuf("no")
	
        love.graphics.setDefaultFilter('nearest', 'nearest')
       
        love.window.setTitle('catch the ball')

        medium_font = love.graphics.newFont('8bit_font.ttf', 8)
        largeFont = love.graphics.newFont('font.ttf', 20)

	love.graphics.setFont(medium_font)	

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true
	})
	
	

	player = Player(VIRTUAL_WIDTH/2-30, VIRTUAL_HEIGHT-20)
	
	ball = Ball(100,50)
        
        playerScore = 0
end


function love.keypressed(key)
	if key == 'escape' then
		love.event.quit()
	end
	
	if key == 'enter' or key == 'return' then
		if gameState == 'start' then
			gameState = 'serve'
		elseif gameState == 'serve' then
			gameState = 'play'
		elseif gameState == 'win'or gameState == 'fail' then
			gameState = 'start'
			playerScore = 0		
		end
	end
end

function love.update(dt)
       
       if gameState == 'play' then
                   ball:update(dt)

                   if player:collides(ball) then 
                        playerScore = playerScore + 1                       
                        gameState = 'win'
                        ball:reset()
                   elseif ball.y > VIRTUAL_HEIGHT  then
                        gameState = 'fail'
                        ball:reset()
                   end                                        
          
       end
  

      if love.keyboard.isDown('right') then
	        player.x = math.min(player.x + PLAYER_SPEED, VIRTUAL_WIDTH - player.width)
      elseif  love.keyboard.isDown('left') then
	        player.x = math.max(player.x - PLAYER_SPEED, 0)
      end 
        
     
end

function love.draw()
	push:start()
		
	love.graphics.clear(80/255, 0/255, 0/255, 255/255)

        displayScore()
	
	if gameState == 'start' then	
              love.graphics.setFont(medium_font)      
	      love.graphics.printf('Welcome to the Game!', 0, 10, VIRTUAL_WIDTH, 'center')
	      love.graphics.printf('Press Enter!', 0, 22, VIRTUAL_WIDTH, 'center')
	elseif gameState == 'serve' then
                love.graphics.setFont(medium_font)		
		love.graphics.printf('Press Enter to serve!', 0, 10, VIRTUAL_WIDTH, 'center')
	elseif gameState == 'win' then	
                love.graphics.setFont(medium_font)	
		love.graphics.printf('Player' .. ' has won', 0, 10, VIRTUAL_WIDTH, 'center')
        elseif gameState == 'fail' then	
                love.graphics.setFont(medium_font)	
		love.graphics.printf('Game Over', 0, 10, VIRTUAL_WIDTH, 'center')
	end
	
        player:render()
	ball:render()
	
	push:finish()
end


function displayScore()
	love.graphics.setFont(medium_font)
	love.graphics.print(playerScore, VIRTUAL_WIDTH / 2 , VIRTUAL_HEIGHT / 2)
	
end



