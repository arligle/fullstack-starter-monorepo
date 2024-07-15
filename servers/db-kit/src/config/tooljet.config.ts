import type { Config } from 'drizzle-kit';
import * as dotenv from 'dotenv';
dotenv.config();

export default {
  schema: './src/sysdb.schema.ts',
  out: './tooljet_migrate_sql',
  dialect: 'postgresql',
  dbCredentials: {
    url: process.env.DATABASE_URL,
  },
  // strict: true,
  verbose: true,
} as Config;
