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

    title_font = love.graphics.newFont('font.ttf', 24)
    sub_font = love.graphics.newFont('font.ttf', 8)
    score_font = love.graphics.newFont('font.ttf', 16)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    player = Player(VIRTUAL_WIDTH / 2 - 10, VIRTUAL_HEIGHT - 40, 20, 20)
    balls = {}

    score = 0

    dtotal = 0

    game_state = 'nil'
end


--[[
    Runs every frame, with "dt" passed in, our delta in seconds 
    since the last frame, which LÖVE2D supplies us.
]]
function love.update(dt)

    if game_state == 'play' then


        if love.keyboard.isDown('a') then
            player.dx = -PLAYER_SPEED
        elseif love.keyboard.isDown('d') then
            player.dx = PLAYER_SPEED
        else
            player.dx = 0
        end

        player:update(dt)
    
        -- Generate new ball every second
        dtotal = dtotal + dt
        if dtotal >= 1 then
            dtotal = dtotal - 1
            random_ball_radius = math.random(5, 20)
            balls[#balls+1] = Ball(random_ball_radius)
        end

        for index=#balls, 1, -1 do
            if balls[index].y - balls[index].radius > VIRTUAL_HEIGHT then
                table.remove(balls, index)
                score = score + 1
            else    
                balls[index]:update(dt)
            end
        end

    end

end

--[[
    Keyboard handling, called by LÖVE2D each frame; 
    passes in the key we pressed so we can access.
]]
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if game_state == 'start' then
            game_state = 'play'
            start_time = os.time()
        else
            game_state = 'start'
            score = 0
            for index = 1, #balls do balls[index] = nil end
            player:reset(VIRTUAL_WIDTH / 2 - 10, VIRTUAL_HEIGHT - 40)
        end
    end
end

--[[
    Called after update by LÖVE2D, used to draw anything to the screen, 
    updated or otherwise.
]]
function love.draw()
    push:apply('start')

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    if game_state == 'play' then
        utils.drawScore(score_font, score, VIRTUAL_HEIGHT, VIRTUAL_WIDTH)

        utils.drawPlayer(player)

        for _, ball in pairs(balls) do
            utils.drawBall(ball)
        end
    else
        utils.drawStartScreen(title_font, sub_font, VIRTUAL_HEIGHT, VIRTUAL_WIDTH)
    end

    push:apply('end')
end
