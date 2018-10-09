class Limite{
  float x,y,w,h;
  //color c;
  Body b;
  
  Limite(float x_, float y_, float w_, float h_){
    this.x = x_;
    this.y = y_;
    this.w = w_;
    this.h = h_;   
    //this.c = color(random(255),random(255),random(255));
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x_,y_));    
    b = box2d.createBody(bd);
    
    PolygonShape ps = new PolygonShape();
    
    float anchoAjustado = box2d.scalarPixelsToWorld(w_/2);
    float altoAjustado = box2d.scalarPixelsToWorld(h_/2);
    ps.setAsBox(anchoAjustado,altoAjustado);
    b.createFixture(ps,1);
  }
  
  void display(){
    //fill(this.c);
    noStroke();
    noFill();
    rectMode(CENTER);
    rect(this.x,this.y,this.w,this.h);
  }
}
