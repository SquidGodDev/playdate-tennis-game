import "scripts/title/titleScene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('GameEndScene').extends(gfx.sprite)

function GameEndScene:init()
    local fireworksImageTable = gfx.imagetable.new("images/game/end/loopingFireworks-table-400-240")
    self.animationLoop = gfx.animation.loop.new(20, fireworksImageTable, true)
    self:moveTo(200, 120)
    self:add()

    if SELECTED_CHARACTER == "contender" then
        KNIGHT_UNLOCKED = true
    elseif SELECTED_CHARACTER == "knight" then
        CHEF_UNLOCKED = true
    end

    local congratsImage = gfx.image.new("images/game/end/congratulationsText")
    local congratsSprite = gfx.sprite.new(congratsImage)
    congratsSprite:moveTo(200, 120)
    congratsSprite:add()
    local congratsAnimateTimer = pd.timer.new(4000, 0, 2*math.pi)
    congratsAnimateTimer.repeats = true
    congratsAnimateTimer.updateCallback = function(timer)
        congratsSprite:moveTo(200, 120 + 5 * math.sin(timer.value))
    end
    self.fireworksSound = pd.sound.sampleplayer.new("sound/game/fireworks")
    self.fireworksSound:play(0)
    local cheeringSound = pd.sound.sampleplayer.new("sound/game/cheering")
    cheeringSound:play()
end

function GameEndScene:update()
    self:setImage(self.animationLoop:image())
    if pd.buttonJustPressed(pd.kButtonA) or pd.buttonJustPressed(pd.kButtonB) then
        self.fireworksSound:stop()
        SCENE_MANAGER:switchScene(TitleScene)
    end
end