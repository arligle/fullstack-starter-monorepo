import { InferSelectModel } from 'drizzle-orm';
import { serial, text, pgTable } from 'drizzle-orm/pg-core';

export const articles = pgTable('articles', {
  id: serial('id').primaryKey(),
  title: text('title'),
  content: text('content'),
});

export type Article = InferSelectModel<typeof articles>;
export default articles;