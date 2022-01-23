require 'bundler/setup'
require 'dxruby'

require 'csv'

class Game
    def initialize
        @@title="RPG"
        @@width=640
        @@height=480
        @@center_x=@@width/2-16
        @@center_y=@@height/2-16

        @@player=Player.new()
        Window.caption=@@title
        @@tuti=Image.load_tiles("./img/tuti.png",1,5)
        @@map=CSV.read("./map.csv")

        # @@debug=Window.create
    end
    def map
        # for y in 0..14 do
        #     for x in 0..19 do
        #         case @@map[y][x]
        #         when "0" then
        #             picture=@@tuti[0]
        #         end
        #         Window.draw(x*32,y*32,picture)
        #     end
        # end

        # 0始まりだから偶数にする事
        disp_x=2
        disp_y=2
        pixel_x=@@center_x-(disp_x/2)*32
        pixel_y=@@center_y-(disp_y/2)*32
        for y in 0..disp_y do
            for x in 0..disp_x do
                if (@@player.x-(disp_x/2)+x)>=0 && (@@player.y-(disp_y/2)+y)>=0 then
                    case @@map[(@@player.y-(disp_y/2)+y)][(@@player.x-(disp_x/2)+x)]
                    when "0" then
                        Window.draw(pixel_x+(x*32),pixel_y+(y*32),@@tuti[0])
                    when "1" then
                        Window.draw(pixel_x+(x*32),pixel_y+(y*32),@@tuti[1])
                    when "2" then
                        Window.draw(pixel_x+(x*32),pixel_y+(y*32),@@tuti[2])
                    end
                end
            end
        end
    end
    def run
        Window.loop do
            @@player.keyCheck()
            self.map()
            Window.draw(@@width/2-16,@@height/2-16,@@player.img)
            Window.caption="x:#{@@player.x} y:#{@@player.y} ix:#{Input.x} iy:#{Input.y} flag:#{@@player.flag}"
        end
    end
end

class Player
    def initialize
        @@x=1
        @@y=1
        @@picture=Image.load_tiles("./img/heroine.png",3,4)
        @@flag=false
    end
    def x
        return @@x
    end
    def y
        return @@y
    end
    def flag
        return @@flag
    end
    def img
        return @@picture[0]
    end
    def keyCheck
        if @@flag==false && (Input.x!=0 || Input.y!=0) then
            @@x=@@x+Input.x
            @@y=@@y+Input.y
            @@flag=true
        elsif @@flag==true && (Input.x==0 && Input.y==0) then
            @@flag=false
        end
    end
end

class System
    @@ruby=""
    def initialize
        @@ruby=RUBY_VERSION
    end
end

system=System.new()
game=Game.new()

game.run()

