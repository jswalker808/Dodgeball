Ball = Class{}

function Ball:init(radius)
    self.radius = radius
    self:reset()
end

function Ball:reset()
    self.x = math.random(50, VIRTUAL_WIDTH - 50)
    self.y = 1
    self.dx = math.random(-100, 100)
    self.dy = math.random(50, 200)
end

function Ball:update(dt)

    if self.dx < 0 then
        self.x = math.max(0 + self.radius, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.radius, self.x + self.dx * dt)
    end

    self.y = self.y + self.dy * dt
end

function Ball:collides(player)
    local distX = math.abs(self.x - player.x - player.width / 2);
    local distY = math.abs(self.y - player.y - player.height / 2);

    if distX > (player.width / 2 + self.radius) then return false end
    if distY > (player.height / 2 + self.radius) then return false end

    if distX <= player.width / 2 then return true end 
    if distY <= player.height / 2 then return true end

    local dx = distX - player.width / 2;
    local dy = distY - player.height / 2;

    return (dx*dx + dy*dy <= (self.radius*self.radius));
end