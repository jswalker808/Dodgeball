local function drawPlayer(player)
  -- Render the body
  love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
  love.graphics.setColor(40/255, 45/255, 52/255, 255/255)

  -- Render the eyes
  love.graphics.rectangle('fill', player.x + 3, player.y + 5, 2, 2)
  love.graphics.rectangle('fill', player.x + player.width - 5, player.y + 5, 2, 2)

  -- Render the mouth
  love.graphics.rectangle('fill', player.x + 3, player.y + 10, 1, 2)
  love.graphics.rectangle('fill', player.x + 3, player.y + 12, player.width - 6, 1)
  love.graphics.rectangle('fill', player.x + player.width - 4, player.y + 10, 1, 2)
end

local function drawBall(ball)
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.circle('fill', ball.x, ball.y, ball.radius)
end

local function drawScore(sub_font, score, virtual_height, virtual_width)
  love.graphics.setFont(sub_font)
  love.graphics.printf(score, 20, 20, virtual_width, 'left')
end

local function drawStartScreen(title_font, sub_font, virtual_height, virtual_width)
  love.graphics.setFont(title_font)
  love.graphics.printf('DODGEBALL!', 0, virtual_height / 2 - 10, virtual_width, 'center')
  love.graphics.setFont(sub_font)
  love.graphics.printf('Press Enter', 0, virtual_height / 2 + 30, virtual_width, 'center')
end

local function drawStoppedScreen(title_font, sub_font, virtual_height, virtual_width)
  love.graphics.setFont(title_font)
  love.graphics.printf('Game Over!', 0, virtual_height / 2 - 10, virtual_width, 'center')
  love.graphics.setFont(sub_font)
  love.graphics.printf('Final Score: ' .. score, 0, virtual_height / 2 + 20, virtual_width, 'center')
  love.graphics.printf('Press enter to play again', 0, virtual_height / 2 + 30, virtual_width, 'center')
end

return {
  drawPlayer = drawPlayer,
  drawBall = drawBall,
  drawStartScreen = drawStartScreen,
  drawScore = drawScore,
  drawStoppedScreen = drawStoppedScreen
}