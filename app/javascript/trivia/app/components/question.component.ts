import { Component, OnInit, OnDestroy, Input, Output, EventEmitter } from '@angular/core';
import { Question } from '../models/question';

@Component({
  selector: 'question',
  template: `
    <div class="styled-container question-container" *ngIf="question && !finished">
      <h3 class="text-center">{{question.title}}</h3>
      <div *ngIf="!showAnswer">
        <button
          class="button link"
          *ngFor="let answer of question.answers"
          (click)="selected($event)"
          [disabled]="selectedAnswer && answer != selectedAnswer"
          [ngClass]="{'selected' : (selectedAnswer && answer == selectedAnswer)}">{{answer}}</button>
      </div>
      <div *ngIf="showAnswer">
        <button
          class="button"
          *ngFor="let answer of question.answers"
          [disabled]="answer != oldSelected"
          [ngClass]="{'correct': (answer == question.answer && answer == oldSelected), 'wrong': (answer == oldSelected && answer != question.answer), 'missed': (answer != oldSelected && answer == question.answer)}"
           >{{answer}}</button>
      </div>
    </div>
    <div *ngIf="question && finished">
      Ai terminat!
    </div>
  `
})
export class QuestionComponent {
  @Input() question: Question;
  @Input() showAnswer: boolean;
  @Input() finished: boolean;
  @Output() onSelected = new EventEmitter();
  public selectedAnswer: string;
  public oldSelected: string;

  constructor() {
    this.selectedAnswer = null;
  }

  selected(event: any) {
    if (!this.selectedAnswer) {
      this.selectedAnswer = event.srcElement.textContent;
      this.onSelected.emit(this.selectedAnswer);
      this.oldSelected = this.selectedAnswer;
      this.selectedAnswer = null;
    }
  }
}
