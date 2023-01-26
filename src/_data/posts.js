const {Directus} = require('@directus/sdk');

let client = new Directus('http://localhost:8055');

let items = client.items('posts').readByQuery({ sort: ['-date_created'] });
module.exports = async () => (await items)?.data;
