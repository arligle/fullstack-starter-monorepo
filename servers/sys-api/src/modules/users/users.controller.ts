import { UsersService } from './users.service';
import { Controller, Get, Param, Req } from '@nestjs/common';
import { Request } from 'express';

@Controller('users')
export class UsersController {
  constructor(private usersService: UsersService) { }
  /**
    * Retrieves all users from the database.
    * 
    * @returns {Promise<any[]>} - A promise that resolves to an array of user objects.
    */
  @Get()
  async findAll() {
    return await this.usersService.findAll();
  }

  /**
   * Retrieves a single user from the database by ID.
   * 
   * This route is protected by JWT authentication.
   * 
   * @param {string} id - The ID of the user to retrieve.
   * @param {Request} req - The Express request object.
   * @returns {Promise<any>} - A promise that resolves to the user object if found.
   */
  @Get(":id")
  async findOne(@Param('id') id: string, @Req() req: Request) {
    return this.usersService.findOne(id, req);
  }
}
