knight.module("Game")
.component("text", {"event", "palette"}, function(event, palette)
  font = love.graphics.newImageFont("gfx/imagefont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
  font:setFilter('nearest', 'nearest', 1)
  event:on("draw_overlay", function()
    love.graphics.setColor(palette.white)
    love.graphics.setFont(font)
    love.graphics.printf("ZOMG!\nCollect all the broken screen pieces,\nyou noob!", 0, 50, 512, "center")
  end)
end)

