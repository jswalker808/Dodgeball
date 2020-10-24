Ball = Class{}

function Ball:init(radius)
    self.radius = radius
    self:reset()
end

function Ball:reset()
    self.x = math.random(50, VIRTUAL_WIDTH - 50)
    self.y = 1
    self.dx = math.random(-100, 100)
    self.dy = 100
end

function Ball:update(dt)

    if self.dx < 0 then
        self.x = math.max(0 + self.radius, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.radius, self.x + self.dx * dt)
    end

    self.y = self.y + self.dy * dt
end