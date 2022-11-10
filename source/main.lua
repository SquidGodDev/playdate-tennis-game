
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/animation"

import "libraries/Signal"

local pd <const> = playdate
local gfx <const> = playdate.graphics

math.randomseed(pd.getSecondsSinceEpoch())

BALL_TAG = 20
LEFT_WALL = 62
RIGHT_WALL = 337

SIGNAL_MANAGER = Signal()

import "scripts/game/gameScene"

GameScene()

function pd.update()
    gfx.sprite.update()
    pd.timer.updateTimers()
    pd.drawFPS(5, 5)
end
