require("game")
require("minigame")

function love.load(arg)

    -- Fondos
    fondo = love.graphics.newImage("assets/ui/inicio.png")

    -- Define las coordenadas y las imágenes de tus botones
    myButtonJugar = {
        x = love.graphics.getWidth() / 2 - 100,
        y = love.graphics.getHeight() / 2 - 50,
        image = love.graphics.newImage("assets/ui/botonjugar.png")
    }

    myButtonSalir = {
        x = love.graphics.getWidth() / 2 - 100,
        y = love.graphics.getHeight() / 2 + 50,
        image = love.graphics.newImage("assets/ui/botonsalir.png")
    }
   gameLoad(arg)
   minigameLoad()
end

function love.draw()
    -- Dibuja la imagen de fondo
    love.graphics.draw(fondo, 0, 0)

    -- Dibuja los botones
    love.graphics.draw(myButtonJugar.image, myButtonJugar.x, myButtonJugar.y)
    love.graphics.draw(myButtonSalir.image, myButtonSalir.x, myButtonSalir.y)
end

function love.mousepressed(x, y, button)
    if button == 1 then
        -- Botón "Jugar"
        if x >= myButtonJugar.x and x <= myButtonJugar.x + myButtonJugar.image:getWidth()
            and y >= myButtonJugar.y and y <= myButtonJugar.y + myButtonJugar.image:getHeight() then
            -- Cambia a la escena "juego"
            love.filesystem.load("game.lua")()  -- Carga y ejecuta el archivo juego.lua
        end

        -- Botón "Salir"
        if x >= myButtonSalir.x and x <= myButtonSalir.x + myButtonSalir.image:getWidth()
            and y >= myButtonSalir.y and y <= myButtonSalir.y + myButtonSalir.image:getHeight() then
            love.event.quit()  -- Salir de la aplicación
        end
    end
end
