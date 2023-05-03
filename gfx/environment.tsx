<?xml version="1.0" encoding="UTF-8"?>
<tileset version="1.8" tiledversion="1.8.6" name="environment" tilewidth="8" tileheight="8" tilecount="15" columns="5">
 <editorsettings>
  <export target="environment.lua" format="lua"/>
 </editorsettings>
 <image source="environment.png" trans="000001" width="40" height="24"/>
 <tile id="0">
  <objectgroup draworder="index" id="4">
   <object id="11" type="collider_wall" x="0" y="0" width="8" height="8"/>
  </objectgroup>
 </tile>
 <tile id="1">
  <objectgroup draworder="index" id="2">
   <object id="1" type="collider_wall" x="0" y="0" width="8" height="8"/>
  </objectgroup>
 </tile>
 <tile id="2">
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="0" width="8" height="8"/>
  </objectgroup>
 </tile>
 <tile id="3">
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="0" width="8" height="8"/>
  </objectgroup>
 </tile>
 <tile id="4">
  <objectgroup draworder="index" id="2">
   <object id="1" x="0" y="0" width="8" height="8"/>
  </objectgroup>
 </tile>
 <tile id="5">
  <objectgroup draworder="index" id="2">
   <object id="1" type="collider_wall" x="0" y="0" width="8" height="8"/>
  </objectgroup>
 </tile>
 <tile id="11">
  <objectgroup draworder="index" id="2">
   <object id="1" type="collider_water" x="0" y="0">
    <polygon points="0,0 0,8 8,8 8,0"/>
   </object>
  </objectgroup>
  <animation>
   <frame tileid="11" duration="800"/>
   <frame tileid="12" duration="800"/>
   <frame tileid="10" duration="800"/>
  </animation>
 </tile>
</tileset>
