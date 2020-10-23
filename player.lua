Player = Class{}

function Player:init (x, y, height, width)
    self.x = x
    self.y = y

    self.height = height
    self.width = width

    self.dx = 0
    self.dy = 0
end

function Player:update(dt)
    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
end


