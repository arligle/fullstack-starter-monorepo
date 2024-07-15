import type { Config } from 'drizzle-kit';
import * as dotenv from 'dotenv';
dotenv.config();

export default {
  schema: './tooljet_migrate_sql/index.ts',
  out: './migrate_sql',
  dialect: 'postgresql',
  dbCredentials: {
    url: process.env.DATABASE_URL,
  },
  // strict: true,
  verbose: true,
} as Config;
