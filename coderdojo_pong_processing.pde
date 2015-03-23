int paddle_links_y;
int paddle_rechts_y;
int beweeg_paddle_links =  0;
int beweeg_paddle_rechts = 0;

int score_links = 0;
int score_rechts = 0;

int balletje_x;
int balletje_y;

int snelheid_balletje = 5;
int richting_balletje_x = 1;
int richting_balletje_y = 1;

void setup(){
  size(800, 600);
  
  paddle_links_y  = height/2;
  paddle_rechts_y = height/2;
  
  balletje_x = width/2;
  balletje_y = height/2;
}

void draw(){
  // Teken de achtergrond wit
  background(255);
  
  // Gebruik als vulkleur een grijstint voor alle vormen die we gaan tekenen
  fill(123, 123, 123);
  
  // teken de linker paddle
  rect(20, paddle_links_y, 15, 80);
  
  // teken de rechter paddle
  rect(width - (20+15), paddle_rechts_y, 15, 80);
  
  // Beweeg de linker paddle met de snelheid
  paddle_links_y  += beweeg_paddle_links;
  
  // Beweer de rechter paddle met de snelheid
  paddle_rechts_y += beweeg_paddle_rechts;
  
  // teken het balletje op het scherm
  ellipse(balletje_x, balletje_y, 10, 10);
  
  // Beweeg het balletje
  balletje_y += snelheid_balletje * richting_balletje_y;
  balletje_x += snelheid_balletje * richting_balletje_x;
  
  textSize(40);
  text(score_links, 50, 50);
  text(score_rechts, width-60, 50);
  
  // Stuitert het balletje ergens tegen aan?
  if(balletje_x > width - (20+15)){
    if(balletje_y > paddle_rechts_y && balletje_y < paddle_rechts_y + 80){
      richting_balletje_x = -1;
    }
    else{
      score_links++;
      // Eigenlijk heeft rechts dan verloren, komen we zo op terug..
      balletje_x = width/2;
      balletje_y = height/2;
      
    }
  }
  
  if(balletje_x < 35){  
    if(balletje_y > paddle_links_y && balletje_y < paddle_links_y + 80){
      richting_balletje_x = 1;
    }
    else{ 
      // Eigenlijk heeft links dan verloren, komen we zo op terug..
      score_links++;
      balletje_x = width/2;
      balletje_y = height/2;
    }
  }
  
  
  
  if(balletje_y > height){
    richting_balletje_y = -1;
  }
  
  if(balletje_y < 0){
    richting_balletje_y = 1;
  }
  
}

void keyReleased(){
  // paddle links
  if(key == 'w' || key == 's'){
    beweeg_paddle_links = 0;
  }
  
  // paddle rechts
  if(keyCode == UP || keyCode == DOWN){
    beweeg_paddle_rechts = 0;
  }
}

void keyPressed(){
  // paddle links
  if(key == 'w'){
    beweeg_paddle_links = -10;
  }
  if(key == 's'){
    beweeg_paddle_links = 10;
  }
  
  // paddle rechts
  if(keyCode == UP){
    beweeg_paddle_rechts = -10;
  }
  
  if(keyCode == DOWN){
    beweeg_paddle_rechts = 10;
  }
  
}
