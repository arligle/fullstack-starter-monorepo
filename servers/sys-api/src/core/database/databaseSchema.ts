import { sql } from 'drizzle-orm';
import { serial, text, pgTable, timestamp, uuid } from 'drizzle-orm/pg-core';

const articles = pgTable('articles', {
  id: serial('id').primaryKey(),
  title: text('title'),
  content: text('content'),
});

export const users = pgTable('users', {
  id: uuid('id').primaryKey().defaultRandom().unique(),
  email: text('email').notNull().unique(),
  password: text('password').notNull(),
  createdAt: timestamp('created_at').notNull().defaultNow(),
  updatedAt: timestamp('updated_at', { mode: 'string' })
    .notNull()
    .default(sql`now()`)
    .$onUpdate(() => sql`now()`),
});

export const databaseSchema = {
  articles,
  users,
};
