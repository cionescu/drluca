export interface UserInterface {
  name: string;
  quiz: number;
  submitted: boolean;
}

export class User {
  public name = null;
  public quiz = null;
  public submitted = false;

  constructor(userInterface?: UserInterface) {
    if (userInterface) {
      this.name = userInterface.name;
      this.quiz = userInterface.quiz;
    }
  }

  isValid() {
    return this.name !== null && this.quiz !== null;
  }
}
