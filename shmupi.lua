--shmup to learn lua D
function _init()
 cls(0)
 shipx=64 
 shipy=64 
 shipsx=0 
 shipsy=0 
 shipz=3
bullets={}
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
 bullet_active=true
 add(bullets,{
  x=shipx, y=shipy-3,
  spr=16, -- starting sprite
  timer=0, step=4, -- (cycles every 4 frames)
  sp={17,33,32,16} -- bullet sprite frames
 })
end 
  
 
 --animate muzzle
 if muzzle>0 then muzzle-=1 end
 
 --flame animation
 flamespr+=1 if flamespr>9 then flamespr=5 end
 
 --move bullet
for bullet in all(bullets) do
 bullet.y-=2 -- move up
 bullet.timer=(bullet.timer+1)%bullet.step
 if bullet.timer==0 then
  bullet.spr+=1
  if bullet.spr>#bullet.sp then bullet.spr=1 end
 end
 if bullet.y<-8 then del(bullets,bullet) end
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
 --map
  map(0, 0, 0, 0, 16, 16)
 --draw lives
 for i=1,4 do
  if lives>i then spr(18,i*9-8,1) end
 end
 
 starfield()
 print("score:"..score,40,2,12)
 
 if muzzle>0 then circfill(shipx+4,shipy-2,muzzle,7) end
 spr(shipz,shipx,shipy)
for bullet in all(bullets) do
 spr(bullet.sp[bullet.spr],bullet.x,bullet.y)
end

end

function starfield()
 for i=1,#starx do
  pset(starx[i],stary[i],7)
  stary[i]+=1
  if stary[i]>127 then stary[i]=0 end
 end
end
