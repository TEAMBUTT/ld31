package.path = package.path .. ';./src/?.lua;./src/?/init.lua'
knight = require 'vendor.knight'
class = require 'vendor.middleclass'
_ = require 'vendor.underscore'
require 'vendor.AnAL'

-- Some global helper methods
inspect = require 'vendor.inspect'
function p(val)
  print(inspect(val))
end

require 'event'
require 'world'
require 'palette'
require 'player'
require 'entity'
require 'map'
require 'ball'
require 'misc_objects'
require 'platform'
require 'floaty_platform'

knight.module("Game").require({"event", "palette"}, function(event, palette)
  function love.load()
    love.graphics.setBackgroundColor(unpack(palette.cyan))
    love.window.setMode(1024, 768)
    event.trigger("load")
  end

  function love.draw()
    event.trigger("draw")
  end

  function love.update(dt)
    event.trigger("update", dt)
  end

  function love.keypressed(key)
    event.trigger("keypressed", key)
  end

  function love.keyreleased(key)
    event.trigger("keyreleased", key)
    if key == 'escape' then love.event.quit() end
  end

  function love.mousepressed(x, y, button)
    event.trigger("mousepressed", x, y, button)
  end

  function love.mousereleased(x, y, button)
    event.trigger("mousereleased", x, y, button)
  end

  function love.focus(focus)
    event.trigger("focus", focus)
  end

  function love.quit()
    event.trigger("quit")
  end
end)

