import { Controller, Get, Render } from '@nestjs/common';
import { AppService } from './home.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  @Render('index')
  home() {
    return { message: '这是一个内部使用的模版项目' };
  }
}
