import { defineConfig } from "drizzle-kit";
import env from '@/env';


export default defineConfig({
  schema: "./src/aiosaas/schema/index.ts",
  out: "./src/aiosaas/migrations",
  dialect: "postgresql",
  dbCredentials: {
    url: env.DATABASE_URL,
  },
  verbose: true,
  strict: true,
});
