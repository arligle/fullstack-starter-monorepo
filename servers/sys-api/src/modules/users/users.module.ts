import { JwtStrategy } from '@/core/auth/auth.strategy';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { Module } from '@nestjs/common';

@Module({
    controllers: [UsersController],
    providers: [UsersService, JwtStrategy],
})
export class UsersModule { }
