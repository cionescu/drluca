import { Component, OnInit, OnDestroy, Input, Output, EventEmitter, SimpleChange, OnChanges } from '@angular/core';
import { Ng2Cable } from 'ng2-cable/js/index';
import { User } from '../models/user';

@Component({
  selector: 'results',
  template: `
    <div *ngFor="let u of users">
      <user [user]="u"></user>
    </div>
  `
})

export class ResultsComponent {
  @Input() user: User;
  public users: Array<User>;

  constructor(private ng2cable: Ng2Cable) {
    this.ng2cable.setCable(`ws://${(<any>window).host}/cable`);
    this.ng2cable.subscription = this.ng2cable
      .cable
      .subscriptions
      .create({ channel: 'UserChannel', user: this.user.name, quiz: this.user.quiz }, {
        received: (data) => {
          this.users = data.map(() => {
            let _user = new User();
            _user.update(data);
            return _user;
          })
        }
      });
  }
}
