export interface QuestionInterface {
  title: string;
  answers: Array<string>;
  answer: string;
}

export class Question {
  public title: string;
  public answers: Array<string>;
  public answer: string;

  constructor(questionInterface?: QuestionInterface) {
    if (questionInterface) {
      this.title = questionInterface.title;
      this.answers = questionInterface.answers;
      this.answer = questionInterface.answer;
    }
  }
}
