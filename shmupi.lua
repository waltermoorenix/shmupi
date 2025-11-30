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
 bullet_active=false
 score=1000 
 lives=4
 starx={} 
 stary={}
 for i=1,100 do
  add(starx,flr(rnd(128)))
  add(stary,flr(rnd(128)))
 end
end

function _update()
 --controls
 shipsx=0 shipsy=0 shipz=3
 if btn(0) then shipsx=-2 shipz=2 end
 if btn(1) then shipsx=2 shipz=4 end
 if btn(2) then shipsy=-2 end
 if btn(3) then shipsy=2 end
 
 --shooting
 if btnp(5) then
  buly=shipy-3 bulx=shipx muzzle=5 bullet_active=true
  sfx(0)
 end
 
 --animate muzzle
 if muzzle>0 then muzzle-=1 end
 
 --flame animation
 flamespr+=1 if flamespr>9 then flamespr=5 end
 
 --move bullet
 if bullet_active then
  buly-=2
  if buly<-8 then bullet_active=false end
 end
 
 --move ship
 shipx+=shipsx 
 shipy+=shipsy
 
 --clamp ship
 if shipx>120 then shipx=0 end
 if shipx<0 then shipx=120 end
 if shipy>120 then shipy=120 end
 if shipy<0 then shipy=0 end
end

function _draw()
 cls(0)
 --draw lives
 for i=1,4 do
  if lives>i then spr(18,i*9-8,1) end
 end
 
 starfield()
 print("score:"..score,40,2,12)
 
 if muzzle>0 then circfill(shipx+4,shipy-2,muzzle,7) end
 spr(shipz,shipx,shipy)
 spr(flamespr,shipx,shipy+8)
 if bullet_active then spr(16,bulx,buly) end
end

function starfield()
 for i=1,#starx do
  pset(starx[i],stary[i],7)
  stary[i]+=1
  if stary[i]>127 then stary[i]=0 end
 end
end
