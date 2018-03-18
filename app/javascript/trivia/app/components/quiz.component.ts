import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { Ng2Cable } from 'ng2-cable/js/index';
import { User } from '../models/user';
import { Question } from '../models/question';

@Component({
  selector: 'quiz',
  template: `
    <user [user]="user" *ngIf="!finished"></user>
    <question [question]="question" [showAnswer]="showAnswer" [finished]="finished" (onSelected)="onSelected($event)"></question>
    <results [user]="user" *ngIf="finished"></results>
  `
})
export class QuizComponent implements OnInit {
  @Input() user: User;
  public question: Question;
  public selectedAnswer: string;
  public showAnswer = false;
  public finished = false;

  private timeout = 3000;

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
          // console.log("Received in QuizChannel", data, this.question, this.showAnswer, this.selectedAnswer);
          if (data.finished) {
            this.showAnswer = true;
            (<any>window).setTimeout(() => {
                this.finished = true;
              }, this.timeout)
            return;
          }
          let _new_question = new Question(data);
          if (this.question === null) {
            this.question = _new_question;
          } else {
            if (_new_question.id === this.question.id) {
              return;
            }
            if (this.selectedAnswer) {
              this.showAnswer = true;
            }
            (<any>window).setTimeout(() => {
                this.question = _new_question;
                this.showAnswer = false;
                this.selectedAnswer = null;
              }, this.timeout)
          }
        }
      });
  }

  onSelected(answer) {
    this.selectedAnswer = answer;
    // console.log("OnSelected", answer, this.question.answer === answer);
    if (this.question.answer === answer) {
      this.ng2cable.subscription.perform('correct');
    } else {
      this.ng2cable.subscription.perform('wrong');
    }
  }
}
