export interface QuestionInterface {
  id: number;
  title: string;
  answers: Array<string>;
  answer: string;
  url: string;
}

export class Question {
  public id: number;
  public title: string;
  public answers: Array<string>;
  public answer: string;
  public url: string;

  constructor(questionInterface?: QuestionInterface) {
    if (questionInterface) {
      this.id = questionInterface.id;
      this.title = questionInterface.title;
      this.answers = questionInterface.answers;
      this.answer = questionInterface.answer;
      this.url = questionInterface.url;
    }
  }
}
