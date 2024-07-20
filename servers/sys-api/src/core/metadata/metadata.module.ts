import { Module } from "@nestjs/common";
import { MetadataController } from "./metadata.controller";
import { MetadataService } from "./metadata.service";


@Module({
  controllers: [MetadataController],
  // TODO:
  imports: [],
  providers: [MetadataService],
})
export class MetadataModule { }
