var matrix = [];
var seed = 42;
var sum = 0;

for (var i = 0; i < 2; i++) {
  var m = [];
  for (var j = 0; j < 512; j++) {
    var r = [];
    for (var k = 0; k < 512; k++) {
      r.push(seed);
      seed *= 25189;
      seed %= 32749;
    }
    m.push(r);
  }
  matrix.push(m);
}
var m = [];
for (var j = 0; j < 512; j++) {
  var r = [];
  for (var k = 0; k < 512; k++) {
    r.push(0);
  }
  m.push(r);
}
matrix.push(m);

for(var i = 0; i < 512; i++)
{
    for(var j = 0; j < 512; j++)
    {
        for(var k = 0; k < 512; k++)
        {
            matrix[2][i][j] += matrix[0][i][k] * matrix[1][k][j];
            matrix[2][i][j] &= 0xFFFF;
        }
        sum += ((i * j) & 0xFF) * matrix[2][i][j];
        sum &= 0xFFFF;
    }
}

if(process.argv.length >= 3)
    console.log(sum);
