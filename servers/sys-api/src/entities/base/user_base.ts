import { User } from '@/core/drizzle/schema/users.schema'
export class UserBase implements User {
  organization_id: string;
  status: 'invited' | 'verified' | 'active' | 'archived';
  source: 'signup' | 'invite' | 'google' | 'git' | 'workspace_signup';
  first_name: string;
  last_name: string;
  password_digest: string;
  invitation_token: string;
  forgot_password_token: string;
  created_at: string;
  updated_at: string;
  role: string;
  avatar_id: string;
  password_retry_count: number;
  company_size: string;
  company_name: string;
  phone_number: string;
  id: string;
  email: string;
  password: string;
  createdAt: Date;
  updatedAt: Date;
}
