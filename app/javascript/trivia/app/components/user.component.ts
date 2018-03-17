import { Component, OnInit, OnDestroy, Input, Output, EventEmitter, SimpleChange, OnChanges } from '@angular/core';
import { User } from '../models/user';

@Component({
  selector: 'user',
  template: `
    <ul class="list-group">
      <li class="list-group-item user-details">
        <h5 class="name">{{user.name}}</h5>
        <p class="score correct">
          <i class="fa fa-check" aria-hidden="true"></i>
          {{user.correct}}
        </p>
        <p class="score wrong">
          <i class="fa fa-times" aria-hidden="true"></i>
          {{user.wrong}}
        </p>
        <p class="score total">
          <i class="fa fa-trophy" aria-hidden="true"></i>
          {{user.totalScore}}
        </p>
      </li>
    </ul>
  `
})

export class UserComponent {
  @Input() user: User;
}
