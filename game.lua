require("minigame")

function gameLoad(arg)

    player = {x = 260, y = 0, speed = 5, img = nil}
    balas = {}
    balasImg = nil 
    puedeDisparar = true
    tiempoDisparoMax = 0.3
    timerDisparo = tiempoDisparoMax

    player.img = love.graphics.newImage('assets/sprite/nugget.png')

    background = love.graphics.newImage('assets/ui/fondo1.png')

    balasImg = love.graphics.newImage('assets/sprite/maiz.png')

    -- Agregar serpientes
    serpientes = {}
    serpienteImg = love.graphics.newImage('assets/sprite/serpiente.png')
    serpienteSpeed = 150
    serpienteDirection = 1
    serpienteTimerMax = 0.8
    serpienteTimer = serpienteTimerMax

    -- Agregar pollito
    player.y = love.graphics.getHeight() - player.img:getHeight()
    minigameLoad()
end


function love.update(dt)

  if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        player.x = player.x + player.speed
    end
    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then 
        player.x = player.x - player.speed
    end
    
     -- Limitar el movimiento horizontal del personaje principal
     if player.x < 0 then
        player.x = 0
    elseif player.x > love.graphics.getWidth() - player.img:getWidth() then
        player.x = love.graphics.getWidth() - player.img:getWidth()
    end

    timerDisparo = timerDisparo - dt
    if timerDisparo < 0 then
        puedeDisparar = true
    end

    if love.keyboard.isDown('space') and puedeDisparar then 
    

        nuevaBala =
            {   x = player.x + (player.img:getWidth()/2),
                y = player.y, img = balasImg}

        table.insert(balas, nuevaBala)
        puedeDisparar = false
        timerDisparo = tiempoDisparoMax
    end

    for i, bala in ipairs(balas) do
        bala.y = bala.y - (250 * dt)

        if bala.y < 0 then
            table.remove(balas, i)
        end

        -- Verificar colisiones con serpientes
        for j, serpiente in ipairs(serpientes) do
            if CheckCollision(bala.x, bala.y, balasImg:getWidth(), balasImg:getHeight(), serpiente.x, serpiente.y, serpienteImg:getWidth(), serpienteImg:getHeight()) then
                table.remove(balas, i)
                table.remove(serpientes, j)
            end
        end
    end

    -- Agregar nuevas serpientes
    serpienteTimer = serpienteTimer - dt
    if serpienteTimer < 0 then
        nuevaSerpiente = {x = math.random(0, love.graphics.getWidth() - serpienteImg:getWidth()), y = -serpienteImg:getHeight(), direction = serpienteDirection, speed = serpienteSpeed}
        table.insert(serpientes, nuevaSerpiente)
        serpienteTimer = serpienteTimerMax
    end

    -- Mover serpientes
    for i, serpiente in ipairs(serpientes) do
        serpiente.y = serpiente.y + (serpiente.speed * dt)
        serpiente.x = serpiente.x + (serpiente.direction * serpiente.speed * dt)

        -- Cambiar dirección de la serpiente cuando llega a los bordes de la pantalla
        if serpiente.x < 0 or serpiente.x > love.graphics.getWidth() - serpienteImg:getWidth() then
            serpiente.direction = -serpiente.direction
        end

        -- Verificar colisiones con el pollito
        if CheckCollision(player.x, player.y, player.img:getWidth(), player.img:getHeight(), serpiente.x, serpiente.y, serpienteImg:getWidth(), serpienteImg:getHeight()) then
            resetGame(arg)
            love.filesystem.load("minigame.lua")()  -- Carga y ejecuta el archivo juego.lua
        end

        -- Verificar si la serpiente llegó al suelo
        if serpiente.y > love.graphics.getHeight() then
            resetGame(arg)
            love.filesystem.load("minigame.lua")()  -- Carga y ejecuta el archivo juego.lua
        end
    end
end

function love.draw(dt)
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(player.img, player.x, player.y)

    for i, bala in ipairs(balas) do
        love.graphics.draw(bala.img, bala.x, bala.y)
    end
    -- Dibujar serpientes
    for i, serpiente in ipairs(serpientes) do
        love.graphics.draw(serpienteImg, serpiente.x, serpiente.y)
    end
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

function resetGame()
    player = {x = 260, y = 0, speed = 5, img = nil}

    balas = {}
    balasImg = nil 
    puedeDisparar = true
    tiempoDisparoMax = 0.3
    timerDisparo = tiempoDisparoMax

    player.img = love.graphics.newImage('assets/sprite/nugget.png')

    background = love.graphics.newImage('assets/ui/fondo1.png')

    balasImg = love.graphics.newImage('assets/sprite/maiz.png')

    -- Agregar serpientes
    serpientes = {}
    serpienteImg = love.graphics.newImage('assets/sprite/serpiente.png')
    serpienteSpeed = 150
    serpienteDirection = 1
    serpienteTimerMax = 0.8
    serpienteTimer = serpienteTimerMax

    -- Agregar pollito
    player.y = love.graphics.getHeight() - player.img:getHeight()
    minigameLoad()
end