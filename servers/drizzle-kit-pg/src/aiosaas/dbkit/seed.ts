import { Table, getTableName, sql } from "drizzle-orm";
import env from '@/env';
import { db, connection } from '@/aiosaas/dbkit';
import * as schema from "@/aiosaas/schema";
import * as seeds from '../seeds';

if (!env.DB_SEEDING) {
  throw new Error('You must set DB_SEEDING to "true" when running seeds');
}

async function resetTable(db: db, table: Table) {
  return db.execute(
    sql.raw(`TRUNCATE TABLE ${getTableName(table)} RESTART IDENTITY CASCADE`)
  );
}

for (const table of [
  schema.users,
]) {
  // await db.delete(table); // clear tables without truncating / resetting ids
  await resetTable(db, table);
}

await seeds.category(db);
await seeds.statusCatalog(db);
await seeds.state(db);
await seeds.city(db);
await seeds.restaurant(db);
await seeds.user(db);
await seeds.order(db);

await connection.end();
