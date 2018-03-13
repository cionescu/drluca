import { Component, OnInit, OnDestroy } from '@angular/core';
import { Ng2Cable } from 'ng2-cable/js/index';
import { User } from './user';

@Component({
  selector: 'trivia',
  template: `
    <div class="row">
      <div class="col-sm-6 offset-sm-3">
        <div class="form-group">
          <input [(ngModel)]="user.name" type="text" class="form-control" id="account-name" placeholder="Numele tau">
        </div>
        <div class="form-group">
          <label for="account-name">Alege un Quiz</label>
          <select [(ngModel)]="user.quiz" class="form-control">
            <option *ngFor="let opt of options" [ngValue]="opt[0]">{{opt[1]}}</option>
          </select>
        </div>
        <button class="button primary" (click)="submit()" [disabled]="!user.isValid() || submitted">
          Login
          <i class="fa fa-spinner fa-pulse fa-fw" aria-hidden="true" *ngIf="submitted"></i>
        </button>
      </div>
    </div>
  `
})
export class AppComponent {
  public user: User;
  public options: Array<[number, string]>;

  constructor(private ng2cable: Ng2Cable) {
    this.ng2cable.setCable(`ws://localhost:3000/cable`);
    this.user = new User();
    this.options = (<any>window).quizzes;
  }

  submit() {
    this.ng2cable.subscription = this.ng2cable
      .cable
      .subscriptions
      .create({ channel: 'QuizChannel', user: this.user.name, quiz: this.user.quiz }, {
        received: (data) => {
          console.log(data)
        }
      });
  }
}
