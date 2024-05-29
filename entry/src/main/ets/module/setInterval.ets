export function secondsSub(seconds:number):Promise<number>{
  return new Promise((resolve,reject)=>{
    var intervalID = setInterval(function() {
      console.log('do very 1s.');
      seconds-=1
    }, 1000);
    resolve(seconds)
  })


}