import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { Ng2Cable, Broadcaster } from 'ng2-cable/js/index';
import { FormsModule } from '@angular/forms';

import { AppComponent } from './app.component';
import { QuizComponent } from './components/quiz.component';

@NgModule({
  declarations: [
    AppComponent,
    QuizComponent
  ],
  imports: [
    BrowserModule,
    FormsModule
  ],
  providers: [
    Ng2Cable,
    Broadcaster
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
