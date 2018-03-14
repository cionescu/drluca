import { Component, OnInit, OnDestroy, Input } from '@angular/core';
import { Question } from '../models/question';

@Component({
  selector: 'question',
  template: `
    <div class="styled-container question-container" *ngIf="question">
      <h3 class="text-center">{{question.title}}</h3>
      <button
        class="button link"
        *ngFor="let answer of question.answers"
        (click)="selected($event)"
        [disabled]="selectedAnswer && answer != selectedAnswer"
        [ngClass]="{'selected' : (selectedAnswer && answer == selectedAnswer)}">{{answer}}</button>
    </div>
  `
})
export class QuestionComponent {
  @Input() question: Question;
  public selectedAnswer: string;

  selected(event: any) {
    if (!this.selectedAnswer) {
      console.log(event.srcElement.textContent);
      this.selectedAnswer = event.srcElement.textContent;
      console.log(`*${this.selectedAnswer}*`, this.question.answers)
    }
  }
}
