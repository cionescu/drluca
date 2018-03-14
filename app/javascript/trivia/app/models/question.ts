export interface QuestionInterface {
  title: string;
  answers: Array<string>;
}

export class Question {
  public title: string;
  public answers: Array<string>;

  constructor(questionInterface?: QuestionInterface) {
    if (questionInterface) {
      this.title = questionInterface.title;
      this.answers = questionInterface.answers;
    }
  }
}
