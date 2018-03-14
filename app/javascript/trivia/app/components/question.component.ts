import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { Question } from '../models/question';

@Component({
  selector: 'question',
  template: `
    <div class="question-container" *ngIf="question">
      <h3 class="text-center">{{question.title}}</h3>
      <div class="row">
        <button class="button link col-sm-6" *ngFor="let answer of question.answers">{{answer}}</button>
      </div>
    </div>
  `
})
export class QuestionComponent {
  @Input() question: Question;
}
