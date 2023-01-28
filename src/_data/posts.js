const {Directus} = require('@directus/sdk');
const dotenv = require('dotenv');
dotenv.config();

console.log(process.env.DIRECTUS_URL || "http://localhost:8055")

let client = new Directus(process.env.DIRECTUS_URL);

let items = client.items('posts').readByQuery({ sort: ['-date_created'] });
module.exports = async () => {
    let data = (await items)?.data;
    return data
}
