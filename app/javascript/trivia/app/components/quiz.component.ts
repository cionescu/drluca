import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { Ng2Cable } from 'ng2-cable/js/index';
import { User } from '../models/user';
import { Question } from '../models/question';

@Component({
  selector: 'quiz',
  template: `
    <p class="text-muted">{{user.name}}</p>
    <question [question]="question"></question>
  `
})
export class QuizComponent implements OnInit {
  @Input() user: User;
  public question: Question;

  constructor(private ng2cable: Ng2Cable) {
    this.ng2cable.setCable(`ws://localhost:3000/cable`);
  }

  ngOnInit() {
    this.ng2cable.subscription = this.ng2cable
      .cable
      .subscriptions
      .create({ channel: 'QuizChannel', user: this.user.name, quiz: this.user.quiz }, {
        received: (data) => {
          console.log(data);
          this.question = new Question(data);
        }
      });
  }
}
