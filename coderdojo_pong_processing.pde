// Positie van de paddles
int paddle_links_y;
int paddle_rechts_y;

// Beweging van de paddles
int beweeg_paddle_links =  0;
int beweeg_paddle_rechts = 0;

// Scores van de spelers
int score_links = 0;
int score_rechts = 0;

// Positie van het balletje
int balletje_x;
int balletje_y;

// Snelheid van het balletje
int snelheid_balletje = 5;

// Richting van het balletje
int richting_balletje_x = 1;
int richting_balletje_y = 1;


void setup(){
  // Maak het scherm 800 bij 600 pixels
  size(800, 600);
  
  // Zet de paddles verticaal in het middel van het scherm (op de Y-as)
  paddle_links_y  = height/2;
  paddle_rechts_y = height/2;
  
  // Zet het balletje netjes in het midden van het scherm
  resetBalletje();
}

void draw(){
  // Teken de achtergrond zwart
  background(0, 0, 0);
  
  // Gebruik als vulkleur een grijstint voor alle vormen die we gaan tekenen
  fill(255, 255, 255);
  
  // teken de linker paddle
  rect(20, paddle_links_y, 15, 80);
  
  // teken de rechter paddle
  rect(width - (20+15), paddle_rechts_y, 15, 80);
  
  // Beweeg de linker paddle met de snelheid
  paddle_links_y  = paddle_links_y + beweeg_paddle_links;
  
  // Beweer de rechter paddle met de snelheid
  paddle_rechts_y = paddle_rechts_y + beweeg_paddle_rechts;
  
  // Ons balletje krijgt een witte vulkleur
  fill(255, 255, 255);
  
  // Teken het balletje op het scherm
  ellipse(balletje_x, balletje_y, 10, 10);
  
  // Beweeg het balletje
  balletje_y = balletje_y + snelheid_balletje * richting_balletje_y;
  balletje_x = balletje_x + snelheid_balletje * richting_balletje_x;
  
  // Raken we de rechter paddle?
  if(balletjeAanRechterKant()){
    if(balletjeRaaktRechterPaddle()){
      richting_balletje_x = -1;
    }
    else{
      score_links++;
      resetBalletje();
    }
  }
  
  // Raken we de linker paddle?
  if(balletjeAanLinkerKant()){
    if(balletjeRaaktLinkerPaddle()){
      richting_balletje_x = 1;
    }
    else{ 
      score_rechts++;
      resetBalletje();
    }
  }
  
  // Stuitert het balletje tegen de onderkant? Verander van richting!
  if(balletje_y > height){
    richting_balletje_y = -1;
  }
  
  // Stuitert het balletje tegen de bovenkant? Verander van richting!
  if(balletje_y < 0){
    richting_balletje_y = 1;
  }
  
  // Teken de scores op het speelveld met een letter grootte van 40 en een witte kleur
  textSize(40);
  fill(255, 255, 255);
  
  // Teken de score voor de linker speler op 50 pixels van links en 50 pixels van boven
  text(score_links, 50, 50);
  
  // Teken de score voor de rechter speler op 50 pixels van rechts en 50 pixels van boven
  text(score_rechts, width-50, 50);
  
}

void resetBalletje(){
  /*
   Deze functie zet het balletje weer netjes in het midden als het uit het scherm verdwenen is.
  */
  
  balletje_x = width/2;
  balletje_y = height/2;
}

boolean balletjeAanLinkerKant(){
  /*
    Controleren of het balletje aan de linkerkant van het scherm is ter hoogte van de paddle.
    We gebruiken hier 35 omdat de paddle 20 pixels van de rand staat en 15 pixels breed is. 20 + 15 = 35 is dus de rechter kant van de paddle. 
  */
  
  if(balletje_x < 35){
    return true;
  }
  else{
    return false;
  }
}

boolean balletjeAanRechterKant(){
  /*
    Controleren of het balletje aan de rechterkant van het scherm is ter hoogte van de paddle.
    We gebruiken hier width - 35 om de linkerkant van de rechter paddle te berekenen. De paddle staat immers
    20 pixels van de rand af en is 15 pixels breed. De paddle staat rechts dus moeten we dit van de breedte van het scherm (600) af trekken.
  */
  
  if(balletje_x > width - 35){
    return true;
  }
  else{
    return false;
  } 
}

boolean balletjeRaaktLinkerPaddle(){
  /*
    Controleren of het balletje op de Y-as ergens tussen het begin en het einde van de paddle is.
    Dit doen we door te kijken of de Y positie van het balletje meer is dan de Y positie van de rechter paddle,
    maar minder is dan de Y positie van de rechter paddle plus de hoogte van de paddle (namelijk: 80 pixels).
    
    WEETJE 1: < en > betekenen meer dan en minder dan. Bijvoorbeeld 1 < 2 en 10 > 5 (1 is minder dan 2, en 10 is meer dan 5)
    WEETJE 2: && betekend EN. Dus: Als balletje_y meer is dan paddle_links_y EN balletje_y minder is dan paddle_links_y + 80 (hoogte van paddle).
  */
  
  if(balletje_y > paddle_links_y && balletje_y < paddle_links_y + 80){
    return true;
  }
  else{
    return false;
  }
}

boolean balletjeRaaktRechterPaddle(){
  /*
    Deze functie doet eigenlijk hetzelfde als de functie 'balletjeRaaktLinkerPaddle()' maar kijkt dan naar de rechter paddle.
  */
  
  if(balletje_y > paddle_rechts_y && balletje_y < paddle_rechts_y + 80){
    return true;
  }
  else{
    return false;
  }
}


void keyPressed(){
  /*
    de keyPressed functie wordt automatisch uitgevoerd als een toets op het toetsenbord wordt ingedrukt.
    de variabele 'key' bevat de ingedrukte toets. Dit kunnen letters zijn maar ook speciale toetsen zoals UP en DOWN (pijltjes toetsen).
  */

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

void keyReleased(){
  /*
  de keyReleased functie wordt automatisch uitgevoerd als een toets op het toetsenbord wordt losgelaten.
  de variabele 'key' bevat de losgelaten toets. Dit kunnen letters zijn maar ook speciale toetsen zoals UP en DOWN (pijltjes toetsen).
  
  WEETJE: De twee streepjes betekend OF. Dus als de losgelaten toets de W-toets is OF de S-toets.
  */

  // paddle links
  if(key == 'w' || key == 's'){
    beweeg_paddle_links = 0;
  }
  
  // paddle rechts
  if(keyCode == UP || keyCode == DOWN){
    beweeg_paddle_rechts = 0;
  }
}
