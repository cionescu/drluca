import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { Ng2Cable } from 'ng2-cable/js/index';
import { User } from '../models/user';

@Component({
  selector: 'quiz',
  template: `
    <p class="text-muted">{{user.name}}</p>
  `
})
export class QuizComponent {
  @Input() user: User;

  constructor(private ng2cable: Ng2Cable) {
    this.ng2cable.setCable(`ws://localhost:3000/cable`);
    console.log(this.user);
  }
}
