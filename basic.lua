-- Base file for a CCTweaks turtle

-- Movement functions
function forward()
    if checkFuel() then
      turtle.forward()
    else
      refuel()
      turtle.forward()
    end
  end
  
  function back()
    if checkFuel() then
      turtle.back()
    else
      refuel()
      turtle.back()
    end
  end
  
  function turnLeft()
    turtle.turnLeft()
  end
  
  function turnRight()
    turtle.turnRight()
  end
  
  -- Inventory management functions
  function checkInventory()
    local inventory = {}
    for i = 1, 16 do
      inventory[i] = turtle.getItemDetail(i)
    end
    return inventory
  end
  
  function dropItem(slot, quantity)
    turtle.select(slot)
    turtle.drop(quantity)
  end
  
  function suckItem(slot)
    turtle.select(slot)
    turtle.suck()
  end
  
  -- Fuel management functions
  function checkFuel()
    return turtle.getFuelLevel() > 0
  end
  
  function refuel(slot)
    if not slot then
      for i = 1, 16 do
        if turtle.getItemCount(i) > 0 then
          turtle.select(i)
          if turtle.refuel(1) then
            return true
          end
        end
      end
      return false
    else
      turtle.select(slot)
      return turtle.refuel(1)
    end
  end
  
  -- Mining functions
  function dig()
    if checkFuel() then
      turtle.dig()
    else
      refuel()
      turtle.dig()
    end
  end
  
  function digUp()
    if checkFuel() then
      turtle.digUp()
    else
      refuel()
      turtle.digUp()
    end
  end
  
  function digDown()
    if checkFuel() then
      turtle.digDown()
    else
      refuel()
      turtle.digDown()
    end
  end
  
  -- Building functions
  function place()
    if checkFuel() then
      turtle.place()
    else
      refuel()
      turtle.place()
    end
  end
  
  function placeUp()
    if checkFuel() then
      turtle.placeUp()
    else
      refuel()
      turtle.placeUp()
    end
  end
  
  function placeDown()
    if checkFuel() then
      turtle.placeDown()
    else
      refuel()
      turtle.placeDown()
    end
  end