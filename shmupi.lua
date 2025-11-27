--shmup to learn lua D
function _init()
 cls(0)
 shipx=64
 shipy=64
 shipsx=0
 shipsy=0
 bulx=64
 buly=40
end

function _update()
  --controls
  shipsx = 0
  shipsy = 0
  if btn(0) then
    shipsx = -2
  end
  if btn(1) then
    shipsx = 2
  end
  if btn(2) then
    shipsy = -2
  end
  if btn(3) then
    shipsy = 2
  end
  --shooting stuff
  if btnp(5) then
     buly = shipy-3
     bulx = shipx
     sfx(0)
  end
  -- moving bullet
  buly = buly-2
  --moving ship
  shipx = shipx + shipsx
  shipy = shipy + shipsy
  -- clamp ship within screen bounds
  if shipx > 120 then
     shipx = 0
  end
  if shipx < 0 then
     shipx = 120
  end
end


function _draw()
 cls(0)
 spr(1,shipx,shipy)
 spr(2,bulx,buly)
 
 end