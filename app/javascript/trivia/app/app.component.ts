import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { Ng2Cable } from 'ng2-cable/js/index';
import { User } from './models/user';

@Component({
  selector: 'trivia',
  template: `
    <div class="row" *ngIf="!user.submitted">
      <div class="col-sm-6 offset-sm-3 styled-container">
        <div class="form-group">
          <input [(ngModel)]="user.name" type="text" class="form-control" id="account-name" placeholder="Numele tau">
        </div>
        <div class="form-group">
          <label for="account-name">Alege un Quiz</label>
          <select [(ngModel)]="user.quiz" class="form-control">
            <option *ngFor="let opt of options" [ngValue]="opt" [selected]="opt == user.quiz">{{opt}}</option>
          </select>
        </div>
        <button class="button primary" (click)="submit()" [disabled]="!user.isValid()">
          Login
        </button>
      </div>
    </div>
    <quiz [user]="user" *ngIf="user.submitted"></quiz>
  `
})
export class AppComponent {
  public user: User;
  public options: Array<string>;

  constructor(private ng2cable: Ng2Cable) {
    this.ng2cable.setCable(`ws://${(<any>window).host}/cable`);
    this.user = new User();
    this.options = (<any>window).quizzes;
  }

  submit() {
    this.ng2cable.subscription = this.ng2cable
      .cable
      .subscriptions
      .create({ channel: 'UserChannel', user: this.user.name, quiz: this.user.quiz }, {
        received: (data) => {
          for (let elem of data) {
            if (this.user.name === elem.name) {
              this.user.update(elem);
              this.user.save();
              return;
            }
          }
        }
      });
  }
}
