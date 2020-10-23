push = require 'push'
Class = require 'class'
utils = require 'utilities'
require 'Player'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PLAYER_SPEED = 200

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    player = Player(VIRTUAL_WIDTH / 2 - 10, VIRTUAL_HEIGHT - 40, 20, 20)
    ball = Ball(VIRTUAL_WIDTH / 2 - 10, 0, 5, 5)

end

--[[
    Runs every frame, with "dt" passed in, our delta in seconds 
    since the last frame, which LÖVE2D supplies us.
]]
function love.update(dt)
    if love.keyboard.isDown('a') then
        player.dx = -PLAYER_SPEED
    elseif love.keyboard.isDown('d') then
        player.dx = PLAYER_SPEED
    else
        player.dx = 0
    end

    player:update(dt)
    ball:update(dt)

end

--[[
    Keyboard handling, called by LÖVE2D each frame; 
    passes in the key we pressed so we can access.
]]
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        ball:reset()
    end
end

--[[
    Called after update by LÖVE2D, used to draw anything to the screen, 
    updated or otherwise.
]]
function love.draw()
    push:apply('start')

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    utils.drawPlayer(player)
    utils.drawBall(ball)

    push:apply('end')
end
