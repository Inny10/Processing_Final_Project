/*
 Inny Ogundeji
 Final Processing Project
 
 Description:
 
 A Flappy Bird-style game where the player controls a bird
 by pressing the spacebar to avoid pipes and earn points.
 */


import processing.sound.*;



int screen = 0;

PImage bg1;
PImage bg2;
PImage bg3;
PImage gameOverImg; // Stores the Game Over image.
PImage pipe;
PImage pipeTop; // Stores the upside-down pipe image.
PImage pauseBigLogo;
PImage pauseButton;
PImage homeButton;
PImage restartButton;
PImage menuBackground;
PImage leaderboardButton;

PImage bird;

SoundFile backgroundMusic; // Stores the background music.
float musicVolume = 100; // Stores the music volume from 0 to 100.

boolean draggingVolume = false; // Checks if the volume slider is being dragged.

SoundFile jumpSound; // Stores the sound effect that plays when the bird jumps.
boolean jumpSoundOn = true; // Stores whether the jumping sound effect is ON or OFF.



float birdY = 250;       // The bird's starting vertical position.
float birdVelocity = 0;  // The bird's starting falling speed.
float gravity = 0.5;     // How much gravity increases the bird's falling speed each frame.

float bgX = 0; // Stores the horizontal position (x value) of the background, which will then become a moving background as it moves to the left.

// Stores the horizontal positions of multiple pipe pairs.
float[] pipeX = {125, 350, 575, 800};

// Tracks whether each pipe pair has already given a point.
boolean[] pipeScored = {false, false, false, false};


// Controls the size of every pipe.
float pipeWidth = 70;
float pipeHeight = 300;

float pipeGap = 150; // Sets the vertical space between the top and bottom pipes. Gives the bird 150 pixels of space to fly through.




// make the gapY (gap of pipes for bird to pass through) random for each pipe as it is in an array.
float[] gapY = {
  random(200, 300),
  random(200, 300),
  random(200, 300),
  random(200, 300)
};

// gapY[i]: uses the gap position belonging to the current pipe pair.



boolean gameStarted = false; // Tracks whether the bird has started moving.
boolean gameOver = false; // Tracks whether the game has ended.
boolean paused = false; // Stores whether the game is currently paused.

int score = 0; // Stores the player's score.
int rectScoreBox;

int highScore = 0; // Stores the highest score achieved.

void setup () {
  size(730, 550); // width and height

  bg1 = loadImage("flappy_bird_background_by_drunkvikings_d76jsuh-fullview.jpg");
  // https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/55a3f0ce-4e68-482d-855d-46a712baa765/d76jsuh-989399fd-de99-
  // 4762-b584-3947f88bc92b.jpg/v1/fill/w_1024,h_576,q_75,strp/flappy_bird_background_by_drunkvikings_d76jsuh-fullview.jpg?
  // token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjo
  // idXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NTc2IiwicGF0aCI6IlwvZlwvNTVhM2YwY
  // 2UtNGU2OC00ODJkLTg1NWQtNDZhNzEyYmFhNzY1XC9kNzZqc3VoLTk4OTM5OWZkLWRlOTktNDc2Mi1iNTg0LTM5NDdmODhiYzkyYi5qcGciLCJ3aWR0aCI
  // 6Ijw9MTAyNCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.z_YZmpBa864FVAZP0GT1dpod5glDWC3R8YuYQH2BvyA

  bg2 = loadImage("210-2109009_3676-x-976-16-0-flappy-bird-logo-removebg-preview.png");
  // https://www.pngfind.com/pngs/m/210-2109009_3676-x-976-16-0-flappy-bird-logo.png then used https://www.remove.bg/upload to remove the background

  bg3 = loadImage("flappy bird background no pipes.jpg");
  // https://wallpaperaccess.com/full/4622732.png

  gameOverImg = loadImage("flappy-bird-game-over-pac-man-super-mario-transparent-png-2080922-removebg-preview.png");
  // https://pngset.com/images/flappy-bird-game-over-pac-man-super-mario-transparent-png-2080922.png then used the background remover tool to remove the background.

  bird = loadImage("bird.png");
  // https://www.piskelapp.com/ to make the bird sprite

  pipe = loadImage("Flappy-Bird-Pipe.png");
  // https://www.bing.com/images/search?view=detailV2&ccid=iFUT5ZM2&id=AF4E762F4412E9690B3399D050C4661258B38892&thid=OIP.
  // iFUT5ZM2KF9jYrX2txwOwAHaHa&mediaurl=https%3A%2F%2Fpngfy.com%2Fwp-content%2Fuploads%2F2025%2F10%2FFlappy-Bird-Pipe-PN
  // G-1.png&cdnurl=https%3A%2F%2Fth.bing.com%2Fth%2Fid%2FR.885513e59336285f6362b5f6b71c0ec0%3Frik%3DkoizWBJmxFDQmQ%26pid
  // %3DImgRaw%26r%3D0&exph=512&expw=512&q=Flappy+Bird+Pipe+for+Files&form=IRPRST&ck=EC9375D843C5F576C9D779ADA32D24CC&sel
  // ectedindex=3&itb=0&cw=1375&ch=659&ajaxhist=0&ajaxserp=0&pivotparams=insightsToken%3Dccid_zsqlap20*cp_3B67C5913E5474C
  // A7B8573107AFB977F*mid_57E4A8C988071099E8AA5F3B637BB2EF5E131649*thid_OIP.zsqlap20sIYcWkrnmp8QswHaHa&vt=0&sim=11&iss=V
  // SI&ajaxhist=0&ajaxserp=0    then used the background remover tool.

  pipeTop = loadImage("Flappy-Bird-Pipe-upside-down.png");
  // https://www.bing.com/images/search?view=detailV2&ccid=iFUT5ZM2&id=AF4E762F4412E9690B3399D050C4661258B38892&thid=OIP.
  // iFUT5ZM2KF9jYrX2txwOwAHaHa&mediaurl=https%3A%2F%2Fpngfy.com%2Fwp-content%2Fuploads%2F2025%2F10%2FFlappy-Bird-Pipe-PN
  // G-1.png&cdnurl=https%3A%2F%2Fth.bing.com%2Fth%2Fid%2FR.885513e59336285f6362b5f6b71c0ec0%3Frik%3DkoizWBJmxFDQmQ%26pid
  // %3DImgRaw%26r%3D0&exph=512&expw=512&q=Flappy+Bird+Pipe+for+Files&form=IRPRST&ck=EC9375D843C5F576C9D779ADA32D24CC&sel
  // ectedindex=3&itb=0&cw=1375&ch=659&ajaxhist=0&ajaxserp=0&pivotparams=insightsToken%3Dccid_zsqlap20*cp_3B67C5913E5474C
  // A7B8573107AFB977F*mid_57E4A8C988071099E8AA5F3B637BB2EF5E131649*thid_OIP.zsqlap20sIYcWkrnmp8QswHaHa&vt=0&sim=11&iss=V
  // SI&ajaxhist=0&ajaxserp=0    then used the background remover tool and then flipped it upside down.

  pauseBigLogo = loadImage("output-onlinepngtools.png");
  // https://cdn.creazilla.com/icons/3263299/pause-icon-md.png

  pauseButton = loadImage("pause-icon-md.png");
  // https://cdn.creazilla.com/icons/3263299/pause-icon-md.png

  homeButton = loadImage("desktop-icon-house-building-icon-design-orange-yellow-text-line-png-clipart-removebg-preview.png");
  // https://p1.hiclipart.com/preview/685/138/489/desktop-icon-house-building-icon-design-orange-yellow-text-line-png-clipart.jpg

  restartButton = loadImage("5698069-removebg-preview.png");
  // https://cdn-icons-png.flaticon.com/256/5698/5698069.png

  menuBackground = loadImage("menu_background.jpg");
  //https://wallpaperaccess.com/full/5677424.jpg


  backgroundMusic = new SoundFile(this, "flappybird-kinguderzo.mp3");
  // https://www.youtube.com/watch?v=wqULOC8X9Qo&list=RDwqULOC8X9Qo&start_radio=1

  // Sets the starting music volume.
  backgroundMusic.amp(musicVolume / 100.0);
  // .amp() controls the music's amplitude (volume).
  // .amp() uses values from 0.0 to 1.0, instead of 0 to 100.
  // I divided musicVolume by 100.00


  // Loads the sound effect that plays when the bird jumps.
  jumpSound = new SoundFile(this, "Flappy bird beep sound effect.mp3");
  // https://www.youtube.com/watch?v=VIoEq-lU02s

  leaderboardButton = loadImage("podium.png");
  // https://www.flaticon.com/free-icon/podium_109774?

  // Loads the saved high score.
  JSONObject highScoreData = loadJSONObject("highscore.json");

  // Checks if a saved high score exists.
  if (highScoreData != null) {
    highScore = highScoreData.getInt("score");
  }
  /*
  loadJSONObject() opens the saved JSON file.
   
   if (highScoreData != null) checks whether the file exists and loaded successfully.
   
   getInt("score") gets the saved score and puts it into highScore.
   */
}

void draw () {

  // Plays background music on the Home and How to Play screens.
  if (screen == 0 || screen == 2) {

    // Starts the music if it is not already playing.
    if (!backgroundMusic.isPlaying()) {
      backgroundMusic.loop();
    }

    // Always applies the saved slider volume to the music, even when the music is already playing.
    // Updates the music volume based on the slider.
    backgroundMusic.amp(musicVolume / 100.0);
  }


  // Stops background music when entering the game.
  if (screen == 1 && backgroundMusic.isPlaying()) {
    backgroundMusic.stop();
  }


  if (screen == 0) {
    image(bg1, 0, 0, 800, 600); // bigegr than the size because i do not want all the image to show.
    image(bg2, 90, 30, 550, 175);
    // 90 is the x-coordinate, which places the image 90 pixels from the left; so that it is centered horizontally.  (730 - 550) / 2 = 90.  730 - 550 = width of main background - with of logo.
    // 30 is the y-coordinate, placing it 30 pixels from the top.
    // 550 is the image width in pixels.
    // 175 is the image height in pixels.

    // LEADERBOARD BUTTON
    fill(255); // White background
    rect(670, 10, 50, 40);

    // Displays the leaderboard icon.
    image(leaderboardButton, 676, 14, 40, 33);



    // Black rectangle behind the white one
    fill(0);
    rect(290.5, 318, 149, 74, 12);

    // Start button (white)
    fill(255, 255, 255);
    rect(292.5, 320, 145, 70, 9);

    // green play triangle
    fill(50, 200, 50);
    triangle(350, 337, 350, 373, 385, 355);
    //       x1   y1   x2   y2   x3   y3

    // x1, y1: top-left point
    // x2, y2: bottom-left point
    // x3, y3: right-pointing tip
    // Increase or decrease x values to move left or right
    // Increase or decrease y values to move down or up

    // MENU BUTTON

    fill(#15370D);
    rect(303, 440, 115, 55, 9);

    fill(255);
    textSize(22);
    textAlign(CENTER, CENTER);
    text("Menu", 360.5, 467.5);
  } else if (screen == 1) {

    image(bg3, bgX, 0, 730, 550); // Draws the first background at its current x-position.
    image(bg3, bgX + 730, 0, 730, 550); // Draws another copy 730 pixels to the right so it fills the empty space.



    if (gameStarted && !gameOver  && !paused) { // if the game has started (space bar clicked) and if the game is not over (not touching bottom of screen) do this:

      bgX = bgX - 2; // Decreases the x-position by 2 each frame to move the background left.

      if (bgX <= -730) { // Checks if the first background has moved completely off the left side of the screen.
        bgX = bgX + 730;
        // The second background is already being drawn beside the first one.
        // Shifting the position forward lets the scrolling continue smoothly instead of leaving an empty space.
      }


      for (int i = 0; i < pipeX.length; i++) {
        // pipeX is an array containing the x-positions of all four pipe pairs.
        // .length tells us how many positions are stored in that array.
        // i represents which pipe pair the loop is currently working with.
        // For example, pipeX[0] is the first pipe, pipeX[1] is the second,
        // and pipeX[2] is the third.




        // Decreases the current pipe's x-position by 2 pixels.
        // This makes the pipe move left across the screen.
        pipeX[i] = pipeX[i] - 2;


        // Gives one point when the bird completely passes a pipe.
        if (pipeX[i] + pipeWidth < 20 && pipeScored[i] == false) {
          score = score + 1;
          pipeScored[i] = true;




          /*
            pipeX[i] + pipeWidth finds the pipe's right edge.
           
           < 20 checks whether that edge has moved past the bird's left edge (the bird starts at x = 20).
           
           pipeScored[i] == false checks that this pipe hasn't already awarded a point.
           
           score = score + 1 adds one point.
           
           pipeScored[i] = true | marks that the pipe as it as been scored on.
           */
        }




        // Checks if the current pipe has completely moved
        // past the left edge of the screen.
        if (pipeX[i] + pipeWidth < 0) {


          // Moves the pipe back to the right side of the screen
          // so it can appear again.
          pipeX[i] = 730;

          // Allows this pipe to give another point next time.
          pipeScored[i] = false;
        }
      }
    }

    if (gameStarted == true && !gameOver && !paused) {
      birdVelocity = birdVelocity + gravity; // Increases the bird's falling speed.
      birdY = birdY + birdVelocity; // Updates the bird's vertical position.
    }



    // for loop
    // .length counts the arrays (4) and tells the code

    for (int i = 0; i < pipeX.length; i++) {

      // Draws the top pipe using its own gap position.
      image(pipeTop, pipeX[i], gapY[i] - pipeGap / 2 - pipeHeight, pipeWidth, pipeHeight);

      // Draws the bottom pipe using the same gap position.
      image(pipe, pipeX[i], gapY[i] + pipeGap / 2, pipeWidth, pipeHeight);
    }




    // PAUSE

    fill(255);
    rect(670, 10, 50, 40);

    // Displays the pause text image inside the white rectangle.
    image(pauseButton, 676, 14, 38, 33);



    image(bird, 20, birdY, 35, 25);
    /*
     Draws the bird at x = 20 and its changing y-position.
     35 = the bird's width.
     25 = the bird's height.
     */

    // PAUSE BIG LOGO

    if (paused == true) {
      // Adds a dark transparent layer over the game.
      // 150 = transparency level (0 is invisible, 255 is fully solid).
      fill(0, 100);
      rect(0, 0, 730, 550);

      /*
     X: (730 - 250) / 2 = 240
       Y: (550 - 250) / 2 = 150
       */

      image(pauseBigLogo, 240, 150, 250, 250);

      // HOME BUTTON

      // Displays the home button image at the bottom right of the screen.
      // 637.5 = x-position (left side of the image).
      // 460.5 = y-position (top of the image).
      // 90 = width of the image.
      // 90 = height of the image.
      image(homeButton, 637.5, 460.5, 90, 90);
    }


    // Only checks for collisions while the game is actively playing/running.
    if (gameStarted && !gameOver && !paused) {

      // Checks every pipe pair for a collision.
      for (int i = 0; i < pipeX.length; i++) {

        // Checks if the bird's left and right edges overlap the pipe.
        if (20 + 35 > pipeX[i] && 20 < pipeX[i] + pipeWidth) {

          // Checks if the top of the bird goes above the current pipe's gap.
          if (birdY < gapY[i] - pipeGap / 2) {
            gameOver = true;
          }

          // Checks if the bottom of the bird goes below the current pipe's gap.
          if (birdY + 25 > gapY[i] + pipeGap / 2) {
            gameOver = true;
          }
        }
      }



      if (birdY + 25 >= 550) {
        birdY = 525; // Keeps the bird on top of the bottom of the screen.
        birdVelocity = 0; // Stops the bird's falling speed.
        gameOver = true; // Ends the game when the bird reaches the bottom.
      }

      if (birdY <= 0) {
        gameOver = true; // Ends the game if the bird reaches the top.
      }
    }

    if (gameOver) { // Checks if the game has ended.


      // Checks if the current score is higher than the high score.
      if (score > highScore) {
        highScore = score;

        // Saves the new high score.
        JSONObject obj = new JSONObject();
        obj.setInt("score", highScore); // Stores the high score.
        saveJSONObject(obj, "highscore.json");  // Saves it in highscore.json
      }



      // Adds a transparent dark layer over the background.
      fill(0, 150); // 0 = black, 150 = transparency level.
      rect(0, 0, 730, 550); // Covers the entire screen.





      image(gameOverImg, 65, 150, 600, 250); // Displays a much larger Game Over image in the centre.
      // 65 = (730 - 600) / 2, so the image is horizontally centred.
      // screen width - image width / 2.

      // 150 = (550 - 250) / 2, so the image is vertically centred.
      // screen height - image height / 2.

      // 600 = image width.
      // 250 = image height.



      // HOME BUTTON

      // Displays the home button image at the bottom right of the screen.
      // 637.5 = x-position (left side of the image).
      // 460.5 = y-position (top of the image).
      // 90 = width of the image.
      // 90 = height of the image.
      image(homeButton, 637.5, 460.5, 90, 90);


      // RESTART BUTTON

      // Draws a white circle the same size as the Home button.
      // The ellipse is centred in the image.
      // X: 642 + 38 = 680 (half of 76 added to the image X).
      // Y: 370 + 38 = 408 (half of 76 added to the image Y).
      // The ellipse is smaller in width and height than the image so the white circle stays behind it.
      fill(255);
      noStroke(); // Removes any outline from the white circle.
      ellipse(680, 408, 70, 70);

      // Displays the restart image over the white circle.
      image(restartButton, 642, 370, 76, 76);
    }




    // SCORE

    textSize(20);
    textAlign(LEFT);

    // Calculates the box width based on the score text.
    rectScoreBox = int(textWidth("Score: " + score)) + 15;

    // Draws the white score box.
    fill(255);
    rect(10, 10, rectScoreBox, 30);

    // Displays the score in black.
    fill(0);
    text("Score: " + score, 15, 30);
  } else if (screen == 2) {

    image(menuBackground, 0, 0, 730, 550);


    // TITLE SECTION

    // Draws a dark green rounded rectangle behind the title.
    fill(#15370D);
    rect(0, 0, 730, 100 );

    // Displays the title in the centre of the rectangle.
    textSize(60);
    textAlign(CENTER, CENTER);
    fill(255);
    text("HOW TO PLAY", 365, 50);


    // GAME RULES SECTION

    // Draws a light grey rounded rectangle behind the game rules.
    fill(230);
    rect(15, 115, 700, 140, 15);

    // Displays the Game Rules heading.
    fill(#15370D);
    rect(15, 115, 700, 35, 15);
    textSize(25);
    fill(255);
    textAlign(CENTER, CENTER);
    text("GAME RULES", 365, 132.5);

    // Displays the game instructions.
    fill(0);
    textSize(18);
    textAlign(LEFT, CENTER);
    text("• Don't hit the top or bottom of the screen.", 30, 170);
    text("• Earn 1 point every time you pass a pipe.", 390, 170);
    text("• Fly through the gaps between the pipes.", 30, 200);
    text("• Avoid touching the pipes.", 390, 200);
    text("• Try to get the highest score you can!", 30, 230);



    // CONTROLS SECTION

    // Draws a light grey rounded rectangle behind the controls.
    fill(230);
    rect(15, 270, 350, 270, 15);

    // Displays the Controls heading.
    fill(#15370D);
    rect(15, 270, 350, 35, 15);
    textSize(25);
    fill(255);
    textAlign(CENTER, CENTER);
    text("CONTROLS", 190, 287.5);

    // Displays the keyboard controls and their functions.
    fill(0);
    textSize(20);
    textAlign(LEFT, CENTER);

    text("• SPACEBAR - Jump", 30, 335);
    text("• P - Pause / Resume", 30, 390);
    text("• HOME ICON - Return to Home Screen", 30, 445);

    // MUSIC BOX

    // Draws a light grey rounded rectangle behind the music controls.
    fill(230);
    rect(380, 270, 335, 270, 15);

    // Draws the dark green heading rectangle.
    fill(#15370D);
    rect(380, 270, 335, 35, 15);

    // Displays the MUSIC heading.
    textSize(25);
    fill(255);
    textAlign(CENTER, CENTER);
    text("MUSIC", 547.5, 287.5);



    // MUSIC VOLUME SLIDER

    // Sets the slider line to a lighter shade of green.
    stroke(#A8C99D);

    // Makes the lighter green slider line 1.5 times thicker.
    strokeWeight(24);

    // Draws the actual slider track.
    // 430, 331 = starting point at the top.
    // 430, 511 = ending point at the bottom.
    // Both X-coordinates are 430, so the line is vertical.
    line(430, 331, 430, 511);


    // Converts the music volume (0-100) into a Y-coordinate.
    // 0% places the handle at the bottom.
    // 100% places the handle at the top.


    // map(value, original minimum, original maximum, new minimum, new maximum)
    float sliderY = map(musicVolume, 0, 100, 511, 331);

    // Removes the circle's outline.
    noStroke();

    // Sets the slider handle to the same dark green as the heading.
    fill(#15370D);

    // Draws the circular slider handle.
    ellipse(430, sliderY, 30, 30);

    // Sets the volume number's text size to 14.
    textSize(14);

    // Sets the volume number's colour to dark green.
    fill(#15370D);

    // Displays the current volume beside the handle.
    // int(musicVolume) converts the volume into a whole number for display.
    // 460 is the X-coordinate of the text.
    // sliderY + 5 positions the text slightly below the circle's centre.
    text(int(musicVolume), 460, sliderY + 5);





    // JUMP EFFECT BUTTON

    // Displays the Jump Effect heading.
    textSize(20);
    textAlign(CENTER, CENTER);
    fill(#15370D);
    text("JUMP EFFECT", 583, 350);

    // Draws the dark grey rounded rectangle behind the butto.
    fill(100);
    rect(540, 375, 90, 50, 25);

    // If the jump sound is ON, show ON and a green circle on the right.
    if (jumpSoundOn == true) {

      fill(#4CAF50);

      /*
       605 = centre X (horizontal position)
       
       400 = centre Y (vertical position)
       
       50 = width
       
       50 = height
       */

      ellipse(605, 400, 50, 50);
      textSize(18);
      fill(0); // black
      text("ON", 605, 400); // middle of on circle
    }

    // If the jump sound is OFF, show OFF and a red circle on the left.
    else {
      fill(#F44336);
      ellipse(565, 400, 50, 50);

      textSize(18);
      fill(0);
      text("OFF", 565, 400); // middle of off circle
    }










    image(homeButton, 637.5, 460.5, 90, 90);
  } else if (screen == 3) {

    // Displays the leaderboard background.
    image(menuBackground, 0, 0, 730, 550);

    // Draws the title background.
    fill(#15370D);
    rect(0, 0, 730, 100);

    // Displays the leaderboard title.
    fill(255);
    textSize(55);
    textAlign(CENTER, CENTER);
    text("LEADERBOARD", 365, 50);

    // Displays the high score.
    fill(230);
    rect(165, 180, 400, 200, 15);

    fill(#15370D);
    textSize(30);
    text("HIGH SCORE", 365, 230);

    fill(0);
    textSize(55);
    text(highScore, 365, 300);

    // Displays the home button.
    image(homeButton, 637.5, 460.5, 90, 90);
  }
}


void mousePressed() {
  if (screen == 0) {
    if (mouseX > 292.5 && mouseX < 437.5 && mouseY > 320 && mouseY < 390) {
      screen = 1;
    }
    // LEADERBOARD BUTTON
    if (mouseX >= 670 && mouseX <= 720 && mouseY >= 10 && mouseY <= 50) {
      screen = 3;
    }

    // MENU BUTTON
    if (mouseX > 303 && mouseX < 418 && mouseY > 440 && mouseY < 495) {
      screen = 2;
    }
  }



  /// PAUSE BUTTON

  // Checks if the mouse clicks inside the white rectangle.
  // 670 = left edge of the rectangle.
  // 720 = right edge (670 + 50).
  // 10 = top edge of the rectangle.
  // 50 = bottom edge (10 + 40).
  // >= and <= make all four edges and corners clickable.
  // The button only works after the game starts and before Game Over.

  if (screen == 1 && gameStarted == true && mouseX >= 670 && mouseX <= 720 && mouseY >= 10 && mouseY <= 50 && !gameOver) {

    // Switches between paused and unpaused.
    if (paused == false) {
      paused = true;
    } else {
      paused = false;
    }
  }



  // HOME BUTTON (PAUSED SCREEN)

  // 682.5 is the centre X: 637.5 + 90 / 2.
  // 505.5 is the centre Y: 460.5 + 90 / 2.
  // 36 is the clickable radius, reduced from 45 to make the hitbox tighter.
  // dist() checks the distance between the centre and the mouse.
  if (screen == 1 && paused == true && dist(682.5, 505.5, mouseX, mouseY) < 36) {
    screen = 0;
    paused = false;
    gameOver = false;
    gameStarted = false;
    score = 0;
    birdY = 250;
    birdVelocity = 0;
    bgX = 0;

    // Resets all four pipes to their starting positions.
    pipeX[0] = 125;
    pipeX[1] = 350;
    pipeX[2] = 575;
    pipeX[3] = 800;

    // Allows the pipes to give points again.
    pipeScored[0] = false;
    pipeScored[1] = false;
    pipeScored[2] = false;
    pipeScored[3] = false;

    // Gives each pipe a new random gap height.
    gapY[0] = random(200, 300);
    gapY[1] = random(200, 300);
    gapY[2] = random(200, 300);
    gapY[3] = random(200, 300);
  }







  // HOME BUTTON (GAME OVER SCREEN)

  // 682.5 is the centre X: 637.5 + 90 / 2.
  // 505.5 is the centre Y: 460.5 + 90 / 2.
  // 36 is the clickable radius, slightly smaller than the
  // 38-pixel radius used for the paused Home button.
  // This makes the clickable area tighter and more accurate.
  // dist() checks the distance between the mouse and the centre.
  if (screen == 1 && gameOver == true && dist(682.5, 505.5, mouseX, mouseY) < 36) {

    /*
    
     637.5 = left edge of the button.
     727.5 = right edge (637.5 + 90).
     460.5 = top edge of the button.
     550 = bottom edge (460.5 + 90).
     
     */
    screen = 0; // Returns to the main menu screen.

    gameOver = false;       // Removes the Game Over state.
    gameStarted = false;    // Makes the game wait for the first spacebar press.
    paused = false;         // Makes sure the game is not paused.
    score = 0;              // Resets the score to zero.
    birdY = 250;            // Returns the bird to its starting vertical position.
    birdVelocity = 0;       // Stops the bird's previous movement.
    bgX = 0;                // Resets the scrolling background.

    // Returns all four pipes to their original horizontal positions.
    pipeX[0] = 125;
    pipeX[1] = 350;
    pipeX[2] = 575;
    pipeX[3] = 800;

    // Allows all four pipes to award points again.
    pipeScored[0] = false;
    pipeScored[1] = false;
    pipeScored[2] = false;
    pipeScored[3] = false;

    // Randomizes the pipe gaps again

    // Gives each pipe a new vertical gap position.
    gapY[0] = random(200, 300);
    gapY[1] = random(200, 300);
    gapY[2] = random(200, 300);
    gapY[3] = random(200, 300);
  }


  // RESTART BUTTON

  // Checks if the mouse is inside the circular restart button.
  // 680 is the centre X: 642 + 76 / 2.
  // 408 is the centre Y: 370 + 76 / 2.
  // 38 is the radius: half of the button's 76-pixel width.
  // dist() checks the distance between the mouse and the button's centre.
  if (screen == 1 && gameOver == true && dist(680, 408, mouseX, mouseY) < 38) {

    gameOver = false;       // Removes the Game Over screen.
    gameStarted = false;    // Makes the game wait for Spacebar.
    paused = false;         // Makes sure the game is not paused.
    score = 0;              // Resets the score.
    birdY = 250;            // Returns the bird to its starting position.
    birdVelocity = 0;       // Stops the bird's previous movement.
    bgX = 0;                // Resets the scrolling background.

    // Returns all four pipes to their original positions.
    pipeX[0] = 125;
    pipeX[1] = 350;
    pipeX[2] = 575;
    pipeX[3] = 800;

    // Allows all four pipes to award points again.
    pipeScored[0] = false;
    pipeScored[1] = false;
    pipeScored[2] = false;
    pipeScored[3] = false;

    // Gives each pipe a new random gap position.
    gapY[0] = random(200, 300);
    gapY[1] = random(200, 300);
    gapY[2] = random(200, 300);
    gapY[3] = random(200, 300);
  }


  // HOME BUTTON (HOW TO PLAY SCREEN)

  // 682.5 is the centre X: 637.5 + 90 / 2.
  // 505.5 is the centre Y: 460.5 + 90 / 2.
  // 36 is the clickable radius, making the hitbox smaller
  // than the full 45-pixel radius of the 90-pixel button.
  // dist() checks the distance between the centre and the mouse.
  if (screen == 2 && dist(682.5, 505.5, mouseX, mouseY) < 36) {
    screen = 0; // Returns to the main menu screen.
  }


  /*
  dist() calculates the distance between two points.
   
   430 is the centre X-coordinate of the slider.
   
   map(...) finds the current Y-coordinate of the circle.
   
   mouseX and mouseY are the mouse's current coordinates.
   
   < 25 checks whether the mouse is within 25 pixels of the circle's centre.
   */
  if (screen == 2 && dist(430, map(musicVolume, 0, 100, 511, 331), mouseX, mouseY) < 25) {

    // Starts dragging the volume slider.
    draggingVolume = true;
  }


  // Checks if the player is on the How to Play screen and clicks the button.

  /*
   Left: 540
   
   Right: 540 + 90 = 630
   75 + 50 = 425
   */


  if (screen == 2 && mouseX >= 540 && mouseX <= 630 && mouseY >= 375 && mouseY <= 425) {

    // Changes the jump sound setting to its opposite value.
    // If it was true (ON), it becomes false (OFF).
    // If it was false (OFF), it becomes true (ON).
    jumpSoundOn = !jumpSoundOn;
  }

  // HOME BUTTON (LEADERBOARD SCREEN)
  if (screen == 3 && dist(682.5, 505.5, mouseX, mouseY) < 36) {
    screen = 0;
  }
}

void keyPressed() {

  // Checks if P is pressed during the game.
  if ((key == 'p' || key == 'P') && screen == 1 && gameStarted == true && !gameOver) {

    // Switches between paused and unpaused.
    if (paused == false) {
      paused = true;
    } else {
      paused = false;
    }
  }

  if (key == ' ' && screen == 1 && !gameOver && !paused) { // Only allows the spacebar to work during gameplay and before the game is over and when the game is not paused.
    gameStarted = true; // Allows the game and background to start moving.
    birdVelocity = -8;  // Gives the bird an upward speed, making it jump.

    // Only plays the jumping sound if the sound setting is ON.
    if (jumpSoundOn == true) {
      jumpSound.play();
    }
  }
}


// Runs continuously while the mouse is being dragged.
void mouseDragged() {

  // Only moves the slider if it has been clicked.
  if (draggingVolume == true && screen == 2) {

    // Stops the slider from going above its top limit.
    if (mouseY < 331) {
      musicVolume = 100;
      // If the mouse goes above the slider's top, the volume stays at 100%.
    }

    // Stops the slider from going below its bottom limit.
    else if (mouseY > 511) {
      musicVolume = 0;
      // If the mouse goes below the slider's bottom, the volume stays at 0%.
    }

    // The two conditions above prevent the slider from going outside its limits.



    // Updates the volume based on the mouse's position.
    else {
      musicVolume = map(mouseY, 511, 331, 0, 100);
    }

    // This applies the new volume to the actual music.
    backgroundMusic.amp(musicVolume / 100.0);
  }
}

// Runs when the mouse button is released.
void mouseReleased() {

  // Stops dragging the slider.
  draggingVolume = false;
}
/*

 1000 lines, YAY!
 
 */
