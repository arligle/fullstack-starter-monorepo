import { Body, Controller, Get, Post, Req, Res } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { Request, Response } from 'express';
import { ResponseMessage } from '@/core/app/app.response';
import { AuthBaseDto } from './auth.dto';
import { AuthService } from './auth.service';

@ApiTags('认证')
@Controller('auth')
export class AuthController {

    constructor(private readonly authService: AuthService) { }

    /**
    * 注册新用户。
    * 
    * 参数：
    * -`body {AuthBaseDto}`：包含电子邮件和密码的数据传输对象。
    * 
    * 返回：
    * -`201 {Promise<Response>}`：带有创建的用户数据的 HTTP 响应。
    * 
    * @param {AuthBaseDto} body -包含电子邮件和密码的数据传输对象。
    * @param {Request} req -Express 请求对象。
    * @param {Response} res -Express 响应对象。
    * @returns {Promise<Response>} -带有创建的用户数据的 HTTP 响应。
    */
    @Post("signup")
    // @ResponseMessage('User created') // custom response message for interceptor
    signup(@Body() body: AuthBaseDto, @Req() req: Request, @Res() res: Response) {
        return this.authService.signup(body, req, res);
    }

    /**
    * 登录现有用户。
    * 
    * 参数：
    * -`body {AuthBaseDto}`：包含电子邮件和密码的数据传输对象。
    * 
    * 返回：
    * -`200 {Promise<Response>}`：带有 JWT 令牌的 HTTP 响应。
    * 
    * @param {AuthBaseDto} body -包含电子邮件和密码的数据传输对象。
    * @param {Request} req -Express 请求对象。
    * @param {Response} res -Express 响应对象。
    * @returns {Promise<Response>} -带有 JWT 令牌的 HTTP 响应。
    */
    @Post("signin")
    @ResponseMessage('User logged in')
    signin(@Body() body: AuthBaseDto, @Req() req: Request, @Res() res: Response) {
        return this.authService.signin(body, req, res);
    }

    /**
     * 注销当前用户。
     * 
     * 返回：
     * -`200 {Promise<Response>}`：确认用户已注销的 HTTP 响应。
     * 
     * @param {Request} req -Express 请求对象。
     * @param {Response} res -Express 响应对象。
     * @returns {Promise<Response>} -确认用户已注销的 HTTP 响应。
 */
    @Get("signout")
    signout(@Req() req: Request, @Res() res: Response) {
        return this.authService.signout(req, res);
    }
}
