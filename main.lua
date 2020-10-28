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

    sounds = {
        ['bounce'] = love.audio.newSource('sounds/bounce.wav', 'static'),
        ['game_over'] = love.audio.newSource('sounds/Explosion.wav', 'static')
    }

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    player = Player(VIRTUAL_WIDTH / 2 - 10, VIRTUAL_HEIGHT - 40, 20, 20)
    balls = {}

    score = 0

    dtotal = 0
    num_balls_generated = 1

    game_state = 'start'

    start_time = os.time()
end


--[[
    Runs every frame, with "dt" passed in, our delta in seconds 
    since the last frame, which LÖVE2D supplies us.
]]
function love.update(dt)

    if game_state == 'play' then


        if love.keyboard.isDown('a') then
            player.dx = -PLAYER_SPEED
        elseif love.keyboard.isDown('left') then
            player.dx = -PLAYER_SPEED
        elseif love.keyboard.isDown('d') then
            player.dx = PLAYER_SPEED
        elseif love.keyboard.isDown('right') then
            player.dx = -PLAYER_SPEED
        else
            player.dx = 0
        end

        player:update(dt)
   
        -- Generate new ball every second
        dtotal = dtotal + dt
        if dtotal >= 0.5 then
            dtotal = dtotal - 1

            if score ~= 0 and score % 5 == 0 then
                num_balls_generated = num_balls_generated + 1 
            end

            for index=1, num_balls_generated do
                random_ball_radius = math.random(5, 20)
                balls[#balls+1] = Ball(random_ball_radius)
            end
            -- print(#balls)
        end

        local bounding_box_left = player.x - 20
        local bounding_box_top = player.y - 20
        local bounding_box_right = player.x + player.width + 20 

        for index=#balls, 1, -1 do
            if balls[index].x >= bounding_box_left and balls[index].x <= bounding_box_right and balls[index].y >= bounding_box_top  then
                if balls[index]:collides(player) then
                    sounds['game_over']:play()
                    game_state = 'stopped'
                    -- print(game_state)
                    break
                end
            end

            if balls[index].x <= 0 then
                balls[index].x = 1
                balls[index].dx = -balls[index].dx
                sounds['bounce']:play()
            end

            if balls[index].x >= VIRTUAL_WIDTH - balls[index].radius then
                balls[index].x = VIRTUAL_WIDTH - balls[index].radius
                balls[index].dx = -balls[index].dx
                sounds['bounce']:play()
            end
            
            if balls[index].y - balls[index].radius > VIRTUAL_HEIGHT then
                table.remove(balls, index)
            else    
                balls[index]:update(dt)
            end
        end

        score = os.time() - start_time

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
        resetGame()
        if game_state == 'play' then
            game_state = 'start'
        else
            game_state = 'play'
        end
    end
end

--[[
    Called after update by LÖVE2D, used to draw anything to the screen, 
    updated or otherwise.
]]
function love.draw()
    push:start()

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    if game_state == 'play' then
        utils.drawScore(score_font, score, VIRTUAL_HEIGHT, VIRTUAL_WIDTH)

        utils.drawPlayer(player)

        for _, ball in pairs(balls) do
            utils.drawBall(ball)
        end
    elseif game_state == 'start' then
        utils.drawStartScreen(title_font, sub_font, VIRTUAL_HEIGHT, VIRTUAL_WIDTH)
    else
        utils.drawStoppedScreen(title_font, sub_font, VIRTUAL_HEIGHT, VIRTUAL_WIDTH)
    end

    displayFPS()

    push:finish()
end

function resetGame() 
    score = 0
    start_time = os.time()
    num_balls_generated = 1
    for index = 1, #balls do balls[index] = nil end
    player:reset(VIRTUAL_WIDTH / 2 - 10, VIRTUAL_HEIGHT - 40)
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(sub_font)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
    love.graphics.setColor(255, 255, 255, 255)
end
