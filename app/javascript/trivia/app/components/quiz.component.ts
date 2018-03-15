import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { Ng2Cable } from 'ng2-cable/js/index';
import { User } from '../models/user';
import { Question } from '../models/question';

@Component({
  selector: 'quiz',
  template: `
    <p class="text-muted">{{user.name}}</p>
    <question [question]="question" [showAnswer]="showAnswer" [finished]="finished" (onSelected)="onSelected($event)"></question>
  `
})
export class QuizComponent implements OnInit {
  @Input() user: User;
  public question: Question;
  public selectedAnswer: string;
  public showAnswer = false;
  public finished = false;

  constructor(private ng2cable: Ng2Cable) {
    this.ng2cable.setCable(`ws://${(<any>window).host}/cable`);
    this.selectedAnswer = null;
    this.question = null;
  }

  ngOnInit() {
    this.ng2cable.subscription = this.ng2cable
      .cable
      .subscriptions
      .create({ channel: 'QuizChannel', user: this.user.name, quiz: this.user.quiz }, {
        received: (data) => {
          console.log(data);
          if (data.finished) {
            this.showAnswer = true;
            (<any>window).setTimeout(() => {
                this.finished = true;
              }, 2000)
            return;
          }
          let _new_question = new Question(data);
          if (this.question === null) {
            this.question = _new_question;
          } else {
            if (_new_question.title === this.question.title) {
              return;
            }
            if (this.selectedAnswer) {
              this.showAnswer = true;
            }
            (<any>window).setTimeout(() => {
                this.question = _new_question;
                this.showAnswer = false;
                this.selectedAnswer = null;
              }, 2000)
          }
        }
      });
  }

  onSelected(answer) {
    this.selectedAnswer = answer;
    this.ng2cable.subscription.perform('selected', { 'answer': answer, user: this.user.name, quiz: this.user.quiz });
  }
}
