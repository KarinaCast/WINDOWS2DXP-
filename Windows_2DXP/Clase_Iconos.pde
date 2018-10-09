class iconoXP{
  //atributos
  float ancho;
  float alto;
  Body b;
  PImage texturaBox;  
  
  iconoXP(float x_, float y_,float ancho_, float alto_, float densidad_, float rebote_){
    this.ancho = ancho_;
    this.alto = alto_;
    
    texturaBox = loadImage(nombrePNG());
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x_,y_));
    
    b = box2d.createBody(bd);
    
    PolygonShape ps = new PolygonShape();
    float anchoAjustado = box2d.scalarPixelsToWorld(ancho_/2);
    float altoAjustado = box2d.scalarPixelsToWorld(alto_/2);
    ps.setAsBox(anchoAjustado,altoAjustado);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = densidad_; //1
    fd.friction = 0.5;
    fd.restitution = rebote_; //0.7
    
    b.createFixture(fd);
    b.setLinearVelocity(new Vec2(20,30));
    b.setAngularVelocity(10);
  }
  
  boolean dentroPantalla(){
   Vec2 posicion = box2d.getBodyPixelCoord(b);
   if(posicion.y>height+max(this.ancho,this.alto)){
      eliminarBody();
     return false;
   }
   else{
     return true;
   }
  }
  
  boolean dentroPapelera(){
    Vec2 posicion = box2d.getBodyPixelCoord(b);
    if(posicion.y > 180 && posicion.y < 210 
       && posicion.x > 640 && posicion.x < 750){
         eliminarBody();
         return false;
    }
    else{
      return true;
    }
  }
  
  void eliminarBody(){
    box2d.destroyBody(b);  
  }
  
  void display(){
    Vec2 posicion = box2d.getBodyPixelCoord(b);
    float angulo = b.getAngle(); 
    rectMode(CENTER);
    pushMatrix();
    translate(posicion.x,posicion.y);
    rotate(angulo);    
    imageMode(CENTER);
    image(texturaBox,0,0);
    popMatrix();    
  }

  
}
