var issueNr = document.querySelector(".coverData").getAttribute("issueNr");
var issueTitle = document.querySelector(".coverData").getAttribute("issueTitle");
var issueEds = document.querySelector(".coverData").getAttribute("issueEds");

var containerName = "Container" + issueNr;

let width = document.getElementById(containerName).clientWidth;
let height = width * Math.sqrt(2);
let sep = 5;
let rs;

let fivo;
let texgyro;
let playfair;
let logo;

// let colorpick = colors[Math.floor(Math.random() * colors.length)];
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
  
 rs = random(20);  

  noLoop();
  noStroke();
}

function draw() {

  randomSeed(rs);
  
  for (let y = -height/2; y < height; y += height / 8) {
  		
    drawingContext.fillStyle = 'rgb(' + random(colorpick) + ')';
    noStroke();
    beginShape();
    for (let x = -50; x <= width+50; x+=2) {
      let yy = y + map(noise(rs+y, x / 300, frameCount / 300), 0, 0.6, -height / sep, height / sep);
      vertex(x, yy);
    }
    vertex(width, height);
    vertex(0, height);
    endShape();
  }
   noLoop();
	
// weisser Hintergrund
 noFill();
stroke(255,255,255, 240);
strokeWeight(60);
line(0,height/3+30, width,height/3+30);
  
noStroke();
  
 // Schrift

  fill(255,255,255);

  textFont(fivo);
  textSize(10);
  text(issueEds, 30, 50, width-60); // der y-Wert muss die Höhe von 'issueTitle' plus Abstand sein
  

  textSize(17);
  textFont(fivo);
  text(issueTitle, 30, height-140, width-60);

  textSize(50);
  textFont(playfair);
  text(issueNr, width-50, height-30);

  // logo

  image(logo, width-200, height/3-60, 180, 180);
  
  noLoop();
  saveSVG("cover_waves" + issueNr + ".svg");
}
