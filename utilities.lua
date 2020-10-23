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
  love.graphics.rectangle('fill', ball.x, ball.y, ball.width, ball.height)
end

return {
  drawPlayer = drawPlayer,
  drawBall = drawBall
}