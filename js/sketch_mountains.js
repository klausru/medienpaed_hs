var issueNr = document.querySelector(".coverData").getAttribute("issueNr");
var issueTitle = document.querySelector(".coverData").getAttribute("issueTitle");
var issueEds = document.querySelector(".coverData").getAttribute("issueEds");

var containerName = "Container" + issueNr;

let width = document.getElementById(containerName).clientWidth;
let height = width * Math.sqrt(2);

var bug1, bug2, bug3, bug4, bug5, bug6;
var mountainSeed = Math.random() * (0.0075 - 0.0005) + 0.0008;
var heightSeed = Math.random() * (height * .005 - 1.75) + 2;
var heightSub = .25;
var pixelWidth = 1;

var fivo;
var texgyro;
var playfair;

// let colorpick = colors_castlevania[Math.floor(Math.random() * colors_castlevania.length)];

var colorpick = colors_default1[issueNr];

function preload() {
  fivo = loadFont("http://localhost/plugins/themes/medienpaed_hs/assets/FivoSans-Bold.otf");
  texgyro = loadFont("http://localhost/plugins/themes/medienpaed_hs/assets/texgyreheros-regular.otf");
  playfair = loadFont("http://localhost/plugins/themes/medienpaed_hs/assets/PlayfairDisplay-Regular.otf");
  logo = loadSVG('http://localhost/plugins/themes/medienpaed_hs/assets/logo_medienpaedagogik_neu.svg');
}

function setup() {
  var cover = createCanvas(width, height, SVG);
    cover.parent("Container"+issueNr);

//  bug1 = new Mountain(0, heightSeed, 0, 4, mountainSeed, pixelWidth);
  bug2 = new Mountain(0, heightSeed - (heightSub * 0.3), 0, 4, mountainSeed / 1, pixelWidth);
  bug3 = new Mountain(0, heightSeed - (heightSub * 1.5), 0, 4, mountainSeed / 1, pixelWidth);
  bug4 = new Mountain(0, heightSeed - (heightSub * 2), 0, 4, mountainSeed / 1, pixelWidth);
  bug5 = new Mountain(0, heightSeed - (heightSub * 2.5), 0, 4, mountainSeed / 1, pixelWidth);
  bug6 = new Mountain(0, heightSeed - (heightSub * 4), 0, 4, mountainSeed / 8, pixelWidth);

  noLoop();
    rectMode(CORNER);
  noStroke();
}

function draw() {
  clear();
  
// Mountain set 5
  fill(colorpick[4]);
  beginShape();
  vertex(0, height);
  for (j = 0; j < width; j++) {
    bug5.make();
  }
  vertex(width, height);
  endShape();

      // Mountain set 4
  fill(colorpick[3]);
  beginShape();
  vertex(0, height);
  for (j = 0; j < width; j++) {
    bug4.make();
  }
  vertex(width, height);
  endShape();

    // Mountain set 3
  fill(colorpick[2]);
  beginShape();
  vertex(0, height);
  for (j = 0; j < width; j++) {
    bug3.make();
  }
  vertex(width, height);
  endShape();
  
  // Mountain set 2
    fill(colorpick[1]);
  beginShape();
  vertex(0, height);
  for (j = 0; j < width; j++) {
      bug2.make();
  }
  vertex(width, height);
  endShape();
 
    

 // Schrift

      rectMode(CORNER);
  
  textSize(40);
  fill(colorpick[0]);
  textFont(playfair);
  text(issueNr, 30, 50);

  textFont(texgyro);
  textSize(8);
  text(issueEds, 30, 90, width-60); // der y-Wert muss die Höhe von "issueTitle" plus Abstand sein

  textFont(fivo);
  textSize(15);
  text(issueTitle, 30, 130, width-60);

  // logo

  image(logo, width-170, -30, 150, 150);

  
  // testing
 // print(containerName);
 // print(width);
  
saveSVG("cover_mountains" + issueNr + ".svg");
  
 }

class Mountain {
  constructor(cMin, cMax, nMin, nMax, tI, lI) {
    this.time = Math.random() * 70;
    this.currentMin = cMin;
    this.currentMax = cMax;
    this.newMin = nMin;
    this.newMax = nMax;
    this.timeInterval = tI;
    this.lengthInterval = lI;
    this.mLength = 0;
  }

  make() {
    rectMode(CENTER);
    this.time += this.timeInterval;
    this.mLength += this.lengthInterval;
    var noiseValue = noise(this.time);
    var x = map(noiseValue, this.currentMin, this.currentMax, this.newMin, -height + this.newMax);
    vertex(this.mLength + pixelWidth, height - (-x));
  }
}

delete issueNr, issueTitle, issueEds, containerName, width, height, bug1, bug2, bug3, bug4, bug5, bug6, mountainSeed, heightSeed, heightSub, pixelWidth, fivo, texgyro, playfair, colorpick;
