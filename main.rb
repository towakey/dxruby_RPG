require 'bundler/setup'
require 'dxruby'

class Game
    def initialize
        @@title="RPG"
    end
    def title
        return @@title
    end
end

class Player
    def initialize
        @@x=0
        @@y=0
        @@picture=Image.load_tiles("./img/heroine.png",3,4)
    end
    def x
        return @@x
    end
    def y
        return @@y
    end
    def img
        return @@picture[0]
    end
    def keyCheck
        @@x=@@x+Input.x
        @@y=@@y+Input.y
    end
end

class System
    @@ruby=""
    def initialize
        @@ruby=RUBY_VERSION
    end
end

system=System.new()
player=Player.new()
game=Game.new()

Window.caption=game.title
Window.loop do
    player.keyCheck()
    Window.draw(player.x,player.y,player.img)
end