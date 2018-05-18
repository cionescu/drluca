export interface UserInterface {
  name: string;
  quiz: number;
  total_score: number;
  correct: number;
  wrong: number;
  submitted: boolean;
}

export class User {
  public name = null;
  public quiz = null;
  public submitted = false;
  public totalScore: number;
  public correct: number;
  public wrong: number;
  private prefix: string;

  constructor(userInterface?: UserInterface) {
    this.prefix = "TRIVIA"
    if((<any>window).localStorage[`${this.prefix}_name`]) {
      this.name = (<any>window).localStorage[`${this.prefix}_name`];
    }
    if((<any>window).localStorage[`${this.prefix}_quiz`]) {
      this.quiz = (<any>window).localStorage[`${this.prefix}_quiz`];
    }
  }

  update(userInterface?: UserInterface) {
    if (userInterface) {
      this.totalScore = userInterface.total_score;
      this.correct = userInterface.correct;
      this.wrong = userInterface.wrong;
      if (this.name === null && this.quiz === null) {
        this.name = userInterface.name;
        this.quiz = userInterface.quiz;
      }
    }
  }

  isValid() {
    return this.name !== null && this.quiz !== null;
  }

  save() {
    (<any>window).localStorage[`${this.prefix}_name`] = this.name;
    (<any>window).localStorage[`${this.prefix}_quiz`] = this.quiz;
    this.submitted = true;
  }
}
