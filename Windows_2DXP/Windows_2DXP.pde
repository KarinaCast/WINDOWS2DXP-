import ddf.minim.*;
Minim minim;
AudioPlayer inicioS, clic;

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

int contador, texto = 0;
Boolean entrada = true, entrada2 = true;
ArrayList <iconoXP> icono;
PImage inicio, pantallaAzul, sesion, papelera;

Limite barraH, papIzq, papDer, papAbajo;
Timer time;
Box2DProcessing box2d;
  
float gr_y;
float gr_x;
float timeF = random(7,10);


void setup(){
  size(800,518);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0,-20);
  
  minim = new Minim(this);
  inicioS = minim.loadFile("data/sonidosXP/XPStart.mp3");
  clic = minim.loadFile("data/sonidosXP/clic.mp3");
  
  //iconos
  icono = new ArrayList<iconoXP>();
  //Paneles
  barraH = new Limite(365,510,730,20); 
  papIzq = new Limite(660,185,2,55);
  papDer = new Limite(730,180,2,70);
  papAbajo = new Limite(685,210,60,2);
  
  //Tiempo inicial
  int timeR = (int) timeF * 1000;
  time = new Timer(timeR);
  
  //imágenes
  inicio = loadImage("data/fondosXP/inicio.png");
  pantallaAzul = loadImage("data/fondosXP/bluescreen.png");
  sesion = loadImage("data/fondosXP/invitado.png");
  
  //contador de iconos
  contador = 1;
}

void draw(){

  if(entrada == true){
    background(sesion);
  }
  
  if(entrada == false){
    //Entra a la pantalla y se muestran los limites y el escritorio
    background(inicio);

    box2d.step();
    barraH.display();
    papIzq.display();
    papDer.display();
    papAbajo.display();
    
    
    //Cambio de papelera
    if(contador <= 0){
      papelera = loadImage("data/iconosXP/papeleraE.png");
    }
    else{
      papelera = loadImage("data/iconosXP/papeleraF.png");
    }
    
    //Caundo cae item
    for(int i = icono.size()-1; i>=0; i--){
      iconoXP ic = icono.get(i);
      if(ic.dentroPantalla()){
        ic.display();
      }
      else{
        icono.remove(i);
        contador--;    
      }   
    }
    
    //Cuando cae item dentro del bote
    for(int i = icono.size()-1; i>=0; i--){
      iconoXP ic = icono.get(i);
      if(ic.dentroPapelera()){
        ic.display();
      }
      else{
        icono.remove(i);
        contador++;  
      }   
    }
    //Se muestra la papelera y el texto
    image(papelera,690,180);
    textSize(10);
    
    text("Contador: ",615,465);
    text(contador,665,465);  
    if(texto == 0){
      text("Gravedad: -20",615,485);
    }
    
    int grInt = (int) gr_y;
    
    if(texto == 1){
      text("Gravedad: ",615,485);
      text(grInt,665,485);
    }


    //Si llegan a perder x items consecuivos, pierde 
    if(contador <= -10){
      background(pantallaAzul);
    }
    
    //Tecla de reinicio
    if(key == 'r'){
      for(int i = icono.size()-1; i>=0; i--){
        icono.remove(i);
      }
      contador = 0;
      entrada = true;
      entrada2 = true;
    }
    

    
    println("Contador: "+contador);
    println(icono.size());
    fill(0);
    
  }
}

void mousePressed(){ 
    if(entrada){
      
    if((mouseX > 420 && mouseX < 550) && (mouseY > 200 && mouseY < 250)){
        inicioS.rewind();
        inicioS.play();
        entrada = false;
        key = 0;
     }
     else if((mouseX > 14 && mouseX < 122) && (mouseY > 470 && mouseY < 495)){
       exit();
     }
    }
       
    if((mouseX > 640 && mouseX < 730) && (mouseY > 180 && mouseY < 210)){
      contador--;
    }

    clic.play();
    clic.rewind();
    //Cuando acaba el tiempo, se cambia la gravedad, densidad y rebote del icono
    if(time.isFinished()){    
        gr_y = random(-50,-20);
        gr_x = random(0,1);
        float d = random(1,25);
  
        fill(0);
        box2d.setGravity(gr_x,gr_y);
        iconoXP c = new iconoXP(mouseX,mouseY,32,32,d,0.7);
        icono.add(c);
        time.start();
        texto = 1; 
    }
    //Valores por defecto (gravedad e ícono)
    else{
        iconoXP c = new iconoXP(mouseX,mouseY,32,32,1,0.7);
        icono.add(c);
    } 
    
}
