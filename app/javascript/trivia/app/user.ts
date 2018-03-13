export interface UserInterface {
  name: string;
  quiz: number;
}

export class User {
  public name: string;
  public quiz: number;

  constructor(userInterface?: UserInterface) {
    if (userInterface) {
      this.name = userInterface.name;
      this.quiz = userInterface.quiz;
    } else {
      this.name = null;
      this.quiz = null;
    }
  }

  isValid() {
    return this.name !== null && this.quiz !== null;
  }
}
