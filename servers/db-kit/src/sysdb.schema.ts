import { articles } from './schemas/articles';
import { users } from './schemas/users';

export const sysdbSchema = {
  users,
  articles,
};

export * from './schemas/articles';
export * from './schemas/users';
