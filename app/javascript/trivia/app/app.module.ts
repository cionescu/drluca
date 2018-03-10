import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { Ng2Cable, Broadcaster } from 'ng2-cable/js/index';

import { AppComponent } from './app.component';

@NgModule({
  declarations: [
    AppComponent
  ],
  imports: [
    BrowserModule,
  ],
  providers: [
    Ng2Cable,
    Broadcaster
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
