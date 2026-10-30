/*
Inny Ogundeji
 Final Processing Project
 TO DO : Add brief description of final project here
 */

int screen = 0;

PImage bg1;
PImage bg2;
PImage bg3;
PImage gameOverImg; // Stores the Game Over image.
PImage pipe;
PImage pipeTop; // Stores the upside-down pipe image.

PImage bird;
float birdY = 200;       // The bird's starting vertical position.
float birdVelocity = 0;  // The bird's starting falling speed.
float gravity = 0.5;     // How much gravity increases the bird's falling speed each frame.

float bgX = 0; // Stores the horizontal position (x value) of the background, which will then become a moving background as it moves to the left.

// Stores the pipe's horizontal position, width, and height.
float pipeX = 500;
float pipeWidth = 200;
float pipeHeight = 300;

float pipeGap = 70; // Sets the vertical space between the top and bottom pipes. Gives the bird 120 pixels of space to fly through.
float gapY = 250;    // Controls where the gap is positioned vertically.

boolean gameStarted = false; // Tracks whether the bird has started moving.
boolean gameOver = false; // Tracks whether the game has ended.


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
}

void draw () {
  if (screen == 0) {
    image(bg1, 0, 0, 800, 600); // bigegr than the size because i do not want all the image to show.
    image(bg2, 90, 30, 550, 175);
    // 90 is the x-coordinate, which places the image 90 pixels from the left; so that it is centered horizontally.  (730 - 550) / 2 = 90.  730 - 550 = width of main background - with of logo.
    // 30 is the y-coordinate, placing it 30 pixels from the top.
    // 550 is the image width in pixels.
    // 175 is the image height in pixels.



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
  } else if (screen == 1) {

    image(bg3, bgX, 0, 730, 550); // Draws the first background at its current x-position.
    image(bg3, bgX + 730, 0, 730, 550); // Draws another copy 730 pixels to the right so it fills the empty space.

    if (gameStarted && !gameOver) { // if the game has started (space bar clicked) and if the game is not over (not touching bottom of screen) do this:

      bgX = bgX - 2; // Decreases the x-position by 2 each frame to move the background left.

      if (bgX <= -730) { // Checks if the first background has moved completely off the left side of the screen.
        bgX = bgX + 730;
        // The second background is already being drawn beside the first one.
        // Shifting the position forward lets the scrolling continue smoothly instead of leaving an empty space.
      }

      // Moves the pipe to the left by decreasing its x-position by 2 pixels each frame.
      pipeX = pipeX - 2;

      // Checks if the entire pipe has moved past the left edge of the screen.
      // If it has, the pipe's x-position is reset to 730 so it appears again from the right side.
      if (pipeX + pipeWidth < 0) {
        pipeX = 730;
      }
    }

    if (key == ' ') { // Press space bar to start
      birdVelocity = birdVelocity + gravity; // Increases the bird's falling speed.
      birdY = birdY + birdVelocity; // Updates the bird's vertical position.
    }


    // Draws the top pipe upside down so its wider rim faces the gap.
    // pipeX controls its horizontal position.
    // gapY - pipeGap / 2 finds the top edge of the gap.
    // Subtracting pipeHeight places the pipe above the gap.
    image(pipeTop, pipeX, gapY - pipeGap / 2 - pipeHeight, pipeWidth, pipeHeight);



    // Draws the bottom pipe starting just below the gap.
    // gapY is the centre of the gap.
    // pipeGap / 2 moves the pipe down by half the gap size.
    // pipeWidth controls the width of the pipe.
    // pipeHeight controls the height of the pipe.
    image(pipe, pipeX, gapY + pipeGap / 2, pipeWidth, pipeHeight);


    image(bird, 100, birdY, 50, 40);
    /*
     Draws the bird at x = 100 and its changing y-position.
     50 = the bird is 50 pixels wide.
     40 = the bird is 40 pixels tall.
     */

    // Checks if the bird is overlapping the pipes horizontally.
    if (100 + 50 > pipeX && 100 < pipeX + pipeWidth) {

      // Checks if the bird is above the gap or below the gap.
      // birdY is the bird's top position, and birdY + 40 is its bottom position.
      // gapY - pipeGap / 2 is the top of the gap.
      // gapY + pipeGap / 2 is the bottom of the gap.
      if (birdY < gapY - pipeGap / 2 || birdY + 40 > gapY + pipeGap / 2) {

        // Ends the game if the bird touches either pipe.
        gameOver = true;
      }
    }

    if (birdY + 40 >= 550) {
      birdY = 523; // Keeps the bird on top of the bottom of the screen.
      birdVelocity = 0; // Stops the bird's falling speed.
      gameOver = true; // Ends the game when the bird reaches the bottom.
    }

    if (birdY <= 0) {
      gameOver = true; // Ends the game if the bird reaches the top.
    }

    if (gameOver) { // Checks if the game has ended.
      image(gameOverImg, 65, 150, 600, 250); // Displays a much larger Game Over image in the centre.
      // 65 = (730 - 600) / 2, so the image is horizontally centred.
      // screen width - image width / 2.

      // 150 = (550 - 250) / 2, so the image is vertically centred.
      // screen height - image height / 2.

      // 600 = image width.
      // 250 = image height.
    }
  }
}

void mousePressed() {
  if (screen == 0) {
    if (mouseX > 292.5 && mouseX < 437.5 && mouseY > 320 && mouseY < 390) {
      screen = 1;
    }
  }
}

void keyPressed() {
  if (key == ' ' && screen == 1 && !gameOver) { // Only allows the spacebar to work during gameplay and before the game is over.
    gameStarted = true; // Allows the game and background to start moving.
    birdVelocity = -9;  // Gives the bird an upward speed, making it jump.
  }
}
