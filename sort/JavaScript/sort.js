var v = new Array();
var seed = 3;
for(var i = 0; i < (1 << 22); i++)
{
    v[i] = seed;
    seed *= 27487;
    seed %= 30491;
}
v.sort(function(a, b){return a - b;});
if(process.argv.length >= 3)
    console.log(v[279121]);
