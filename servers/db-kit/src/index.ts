// import { pgTable, serial, text, varchar } from "drizzle-orm/pg-core";
import { drizzle } from 'drizzle-orm/node-postgres';
import { Client } from 'pg';
import { users } from './schemas/users';

const client = new Client({
  connectionString: 'postgres://user:password@host:port/db',
});

// or
// const client = new Client({
//   host: "127.0.0.1",
//   port: 5432,
//   user: "postgres",
//   password: "password",
//   database: "db_name",
// });

const db = drizzle(client);
await client.connect();
const allUsers = await db.select().from(users);
console.log(allUsers);
