const {Directus} = require('@directus/sdk');


let client = new Directus(process.env.DIRECTUS_URL);

let items = client.items('posts').readByQuery({ sort: ['-date_created'] });
module.exports = async () => {
    let data = (await items)?.data;
    return data
}
