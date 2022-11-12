import "libraries/AnimatedSprite"
import "scripts/game/player/hitbox"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Racquet').extends(AnimatedSprite)

function Racquet:init(x, y, entity, isEnemy, hitVelocity, hitVariance)
    self.entity = entity
    local racquetSpriteSheet = gfx.imagetable.new("images/player/racquetSwingLarge-table-125-95")
    Racquet.super.init(self, racquetSpriteSheet)

    if isEnemy then
        self.flipped = 2
    else
        self.flipped = 0
    end

    self.bonusPower = 0

    self:addState("idle", 1, 120, {tickStep = 1, flip = self.flipped})
    self:addState("swing", 121, 144, {tickStep = 1, nextAnimation = "idle", flip = self.flipped})

    local swingFrame = 122
    self.states["swing"].onFrameChangedEvent = function()
        if self:getCurrentFrameIndex() == swingFrame then
            local xOffset, yOffset = -64, -47
            local hitboxWidth, hitboxHeight = 127, 60
            if isEnemy then
                xOffset, yOffset = -64, -14
            end
            Hitbox(self.x + xOffset, self.y + yOffset, hitboxWidth, hitboxHeight, self.entity, isEnemy, hitVelocity + self.bonusPower, hitVariance)
            self.bonusPower = 0
        end
    end

    self:moveTo(x, y)
    self:playAnimation()

    self.flipped = flipped
end

function Racquet:update()
    self:updateAnimation()
end

function Racquet:swing()
    self:changeState("swing")
end

function Racquet:isSwinging()
    return self.currentState == "swing"
end

function Racquet:flip(direction)
    self.globalFlip = direction
end

function Racquet:resetState()
    self:changeState("idle")
end

function Racquet:setBonusPower(bonusPower)
    self.bonusPower = bonusPower
end
