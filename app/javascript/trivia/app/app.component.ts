import { Component, OnInit, OnDestroy } from '@angular/core';
import { Ng2Cable } from 'ng2-cable/js/index';
import { User } from './user';

@Component({
  selector: 'trivia',
  template: `
    <div class="row">
      <div class="col-sm-6 offset-sm-3">
        <div class="form-group">
          <label for="account-name">Name</label>
          <input [(ngModel)]="user.name" type="text" class="form-control" id="account-name" placeholder="Name">
        </div>
        <div class="form-group">
          <label for="account-email">Email address</label>
          <input [(ngModel)]="user.email" type="email" class="form-control" id="account-email" placeholder="Enter email">
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

  constructor(private ng2cable: Ng2Cable) {
    this.ng2cable.setCable(`ws://localhost:3000/cable`);
    this.user = new User();
  }

  ngOnInit() {
    this.ng2cable.subscription = this.ng2cable.cable.subscriptions.create({ channel: 'QuizChannel' }, {
      received: (data) => {
        console.log(data)
      }
    });
  }
}
