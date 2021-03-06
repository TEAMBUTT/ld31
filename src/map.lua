knight
.module("Game")
.component("map",
{"event", "world", "Platform", "FloatyPlatform", "ScreenPiece", "BadGuy", "BirdGuy", "player", "LeftSlope", "RightSlope", "GhostWall"},
function(event, world, Platform, FloatyPlatform, ScreenPiece, BadGuy, BirdGuy, player, LeftSlope, RightSlope, GhostWall)
  local width, height = 512, love.graphics.getHeight()/2

  local floor = Platform:new(0, height - 16, width, 16)
  local left_wall = Platform:new(-100, 0, 100, height)
  local right_wall = Platform:new(width, 0, 100, height)
  local ceiling = Platform:new(0, -100, width, 100)

  local map = {
    "                               =================================",
    "                               ===                             =",
    "                               ===                             =",
    "                               %                               =",
    "*                              %                         *     =",
    "___          X                 %                         ==    =",
    "===                            %                         ==    =",
    "===                 %    B    /_                        /==    =",
    "===    %%    B    %%%/==========                 /////=====    =",
    "===____  =========                                             =",
    "==                                                             =",
    "==                                                             =",
    "                                        ===       *            =",
    "__  *         % B %   % B %             ===                    =",
    "==             ===  *  ===     ===               ///           =",
    "==_______     /===========_      =               ===           =",
    "=========                        =   *           ===           =",
    "======                           ======          ===           =",
    "           ___             ///                   ===          /=",
    "           ===     ===     ===                   ===          ==",
    "                                                 ===          ==",
    "     ///                               ==        ===          ==",
    " *   ===                               ==       /===_        ===",
    "     ===                   %    B      ==       =====        ===",
    "                            =============     //=====__      ===",
    "           ===      *      /=============     =========     ====",
    "    B   %          ====            ==             =         ====",
    "========_          ====            == *           =        /====",
    "    =====%          ==    % B %    ==             =        =====",
    "         %                 ===     ========      /=_       =====",
    "         %                 ===      =======                =====",
    "         %                 ===           ====             ======",
    "          /////           /===_          ====             ======",
    "    X      %        ==    =====%%%%%%%%%/====                   ",
    "           %        ==       %          ======                * ",
    "_        * %                 %           =====                  ",
    "=%%%%%%%%==                  %           ====                ///",
    "=      //==__               /_            ===     %    B     ===",
    "=      ======     ==        ==    X         %      =============",
    "=               //==        ==              %                   ",
    "=               ====__    //==_             %               *   ",
    "===   *      =========    =====             %                  /",
    "===        //========= @  =======__         ==                 =",
    "===   B    ===========_  /=========         ==        B     ====",
    "=====================================__    /==_          ///====",
    "                                                                ",
    "                                                                "
  }

  local function scanrow(s, pattern, callback)
    local pos = 0
    while true do
      local start, fin = string.find(s, pattern, pos)
      if start == nil then break end
      callback(start-1, fin)
      pos = fin+1
    end
  end

  for i, s in ipairs(map) do
    local y = i-1
    scanrow(s, "=+", function(x1, x2)
      FloatyPlatform:new(x1, y, x2 - x1)
    end)
    scanrow(s, "/+", function(x1, x2)
      LeftSlope:new(x1, y, x2 - x1)
    end)
    scanrow(s, "_+", function(x1, x2)
      RightSlope:new(x1, y, x2 - x1)
    end)
    scanrow(s, "%*", function(x, _)
      ScreenPiece:new(x*8, y*8)
    end)
    scanrow(s, "B", function(x, _)
      BadGuy:new(x*8, y*8)
    end)
    scanrow(s, "X", function(x, _)
      BirdGuy:new(x*8, y*8)
    end)
    scanrow(s, "@", function(x, _)
      player.body:setPosition(x*8, y*8)
    end)
    scanrow(s, "%%", function(x1, x2)
      GhostWall:new(x1, y, x2 - x1)
    end)
  end

  -- Ensure I am not bad at counting
  -- assert(height/16 == #map)
  -- assert(1024/16 == string.len(map[1]))

end)
