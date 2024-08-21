let page = 1;
let max = 1000;

const start =  async () => {
        
        const main = document.getElementsByClassName("main")[0];
        const data = await fetch();
       if (data == undefined){
        const probleem = document.createElement("h1");
        probleem.innerHTML = "TEST Probleem met server, kan niet fetchen data! TEST"
        main.appendChild(probleem)
       } else{

        console.log(data);
        const scores = document.createElement("p");
        scores.innerHTML = "TEST scores TEST"
        const name = document.createElement("p");
        name.innerHTML = "TEST name TEST"
        main.appendChild(scores)
        main.appendChild(name)

        data.scores.forEach(score => {
          const x = document.createElement("p");
          x.innerHTML = score.score
          const y = document.createElement("p");
          y.innerHTML = score.name
          main.appendChild(x)
          main.appendChild(y)
        });
       }
    
}; 

const fetch =  async () =>{
        try {
                const config = {
                    params: {
                      'page': page,
                      'limit': max,
                    },
                  };
                const response = await axios.get('http://cloud.dawaladeny.eu/api/v1/scores', config); 
                const data = response.data; 
                return data
                
              } catch (error) {
               
                console.log(error);
              }
}

document.addEventListener('DOMContentLoaded', start);