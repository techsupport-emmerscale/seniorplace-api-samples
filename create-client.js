require("dotenv").config();
const axios = require("axios");
const readline = require("node:readline");

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
});

const API_KEY = process.env.API_KEY;


function ask(prompt) {
    return new Promise((resolve) => rl.question(prompt, resolve));
}

(async () => {
    const CLIENT_NAME = await ask("Client name: ");
    if(!CLIENT_NAME){
        console.error("Please provide a name for the client: ");
    
        process.exit(1);
    }

    const BEST_CONTACT = await ask("Best contact name (optional): ");
    const EMAIL = await ask("Email address: ");

    const API_ENDPOINT = 'https://staging.seniorplace.com/api/v1/clients'
    const headers = {
        'Authorization': `ApiKey ${API_KEY}`,
        "Content-Type": "application/json"
    }
    const body = {
        "statusId": "1573a291-dc9c-4177-be6a-a9843cf1eab0",
        "name": `${CLIENT_NAME}`,
        "email": `${EMAIL}`,
        "assignedUserId": 'bba8b43f-7d80-446d-81d4-54578d4f27bf'
    }

    try {
        const res = await axios.post(API_ENDPOINT, body, {headers});
        console.log(res);
    } catch (error) {
        console.error(error);
    }

    rl.close();
    

})();





