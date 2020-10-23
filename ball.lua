Ball = Class{}

function Ball:init(x, y, height, width)
    self.x = x
    self.y = y

    self.height = height
    self.width = width

    self.dx = 0
    self.dy = 0

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
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end

    self.y = self.y + self.dy * dt
end