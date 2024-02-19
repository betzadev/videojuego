
function minigameLoad()
    -- Carga las imágenes de la serpiente y el pollito
    snakeImage = love.graphics.newImage("assets/sprite/serpiente.png")
    chickImage = love.graphics.newImage("assets/sprite/nugget.png")

    -- Inicializa las posiciones de la serpiente y el pollito
    snakeX, snakeY = 400, 300
    chickX, chickY = math.random(800 - chickImage:getWidth()), math.random(600 - chickImage:getHeight())

    -- Contador de veces que la serpiente se ha comido al pollito
    score = 0

    -- Carga la imagen de fondo
    fondo2 = love.graphics.newImage("assets/ui/fondo2.png")
end

function love.update(dt)
    -- Mueve la serpiente con las flechas
    if love.keyboard.isDown("left") and snakeX > 0 then
        snakeX = snakeX - 4
    elseif love.keyboard.isDown("right") and snakeX < 800 - snakeImage:getWidth() then
        snakeX = snakeX + 4
    elseif love.keyboard.isDown("up") and snakeY > 0 then
        snakeY = snakeY - 4
    elseif love.keyboard.isDown("down") and snakeY < 600 - snakeImage:getHeight() then
        snakeY = snakeY + 4
    end

    -- Verifica si la serpiente ha atrapado al pollito
    local snakeLeft = snakeX
    local snakeRight = snakeX + snakeImage:getWidth()
    local snakeTop = snakeY
    local snakeBottom = snakeY + snakeImage:getHeight()

    local chickLeft = chickX
    local chickRight = chickX + chickImage:getWidth()
    local chickTop = chickY
    local chickBottom = chickY + chickImage:getHeight()

    if snakeLeft < chickRight and snakeRight > chickLeft and
       snakeTop < chickBottom and snakeBottom > chickTop then
        score = score + 1
        chickX, chickY = math.random(800 - chickImage:getWidth()), math.random(600 - chickImage:getHeight())
    end
    -- Termina el juego cuando la serpiente se ha comido 10 pollitos
    if score >= 10 then
        resetMinigame()  -- Reinicia el minijuego
        love.filesystem.load("main.lua")()  -- Carga y ejecuta el archivo game.lua para volver al juego principal
    end
end

function love.draw()
    -- Dibuja el fondo
    love.graphics.draw(fondo2, 0, 0)

    -- Dibuja la serpiente y el pollito
    love.graphics.draw(snakeImage, snakeX, snakeY)
    love.graphics.draw(chickImage, chickX, chickY)

       -- Dibuja el contador en la parte superior de la pantalla
       love.graphics.setColor(1, 1, 1) -- Color blanco
       love.graphics.setFont(love.graphics.newFont(24)) -- Tamaño de fuente
       love.graphics.print("Pollitos comidos: " .. score, 10, 10)
end

function resetMinigame()
     -- Carga las imágenes de la serpiente y el pollito
     snakeImage = love.graphics.newImage("assets/sprite/serpiente.png")
     chickImage = love.graphics.newImage("assets/sprite/nugget.png")
 
     -- Inicializa las posiciones de la serpiente y el pollito
     snakeX, snakeY = 400, 300
     chickX, chickY = math.random(800 - chickImage:getWidth()), math.random(600 - chickImage:getHeight())
 
     -- Contador de veces que la serpiente se ha comido al pollito
     score = 0
end