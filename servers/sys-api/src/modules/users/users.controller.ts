import { JwtAuthGuard } from '@/core/auth/auth.guard';
import { UsersService } from './users.service';
import { Controller, Get, Param, Req, UseGuards } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { Request } from 'express';
@ApiTags('用户')
@Controller('users')
export class UsersController {
  constructor(private usersService: UsersService) { }
  /**
    * 从数据库中检索所有用户。
    * 
    * @returns {Promise<any[]>} -解析为用户对象数组的Promise。
    */
  @Get()
  async findAll() {
    return await this.usersService.findAll();
  }

  /**
   * 通过 ID 从数据库中检索单个用户。
   * 
   * 该路由受 JWT 身份验证保护。
   * 
   * @param {string} id -要检索的用户的 ID。
   * @param {Request} req -Express 请求对象。
   * @returns {Promise<any>} -如果找到则解析为用户对象的Promise
   */
  @UseGuards(JwtAuthGuard) // 受保护的特定路由
  @Get(":id")
  async findOne(@Param('id') id: string, @Req() req: Request) {
    return this.usersService.findOne(id, req);
  }
}
