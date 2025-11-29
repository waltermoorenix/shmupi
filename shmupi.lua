--shmup to learn lua D
function _init()
 cls(0)
 shipx=64
 shipy=64
 shipsx=0
 shipsy=0
 shipz=3
 bulx=0
 buly=0
 flamespr=5
 muzzle=0
 bullet_active = false
end

function _update()
  --controls
  shipsx = 0
  shipsy = 0
  shipz = 3
  if btn(0) then
    shipsx = -2 
    shipz = 2
  end
  if btn(1) then
    shipsx = 2
    shipz = 4
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
     muzzle = 5
     bullet_active = true
     sfx(0)
     
  end
  -- animate muzzle
  if muzzle > 0
  then muzzle =muzzle-1
  end
  -- flame animation
  flamespr=flamespr+1
  if flamespr > 9
  then flamespr = 5 
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
 if muzzle > 0 then
 circfill(shipx+4,shipy-2,muzzle,7)
 end
 spr(shipz,shipx,shipy)
 spr(flamespr,shipx,shipy + 8)
   if bullet_active then
    spr(16, bulx, buly)
   end
   
 end
