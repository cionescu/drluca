export interface UserInterface {
  name: string;
  quiz: number;
  submitted: boolean;
}

export class User {
  public name = null;
  public quiz = null;
  public submitted = false;
  private prefix: string;

  constructor(userInterface?: UserInterface) {
    this.prefix = "TRIVIA"
    if (userInterface) {
      this.name = userInterface.name;
      this.quiz = userInterface.quiz;
    } else {
      if((<any>window).localStorage[`${this.prefix}_name`]) {
        this.name = (<any>window).localStorage[`${this.prefix}_name`];
      }
      if((<any>window).localStorage[`${this.prefix}_quiz`]) {
        this.quiz = (<any>window).localStorage[`${this.prefix}_quiz`];
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
