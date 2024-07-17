import { defineConfig } from "drizzle-kit";
import env from '@/env';


export default defineConfig({
  schema: "./src/db/tooljet/schema/index.ts",
  out: "./src/db/tooljet/migrations",
  dialect: "postgresql",
  dbCredentials: {
    url: env.DATABASE_URL,
  },
  verbose: true,
  strict: true,
});
