export interface UserInterface {
  name: string;
  email: string;
}

export class User {
  public name: string;
  public email: string;

  constructor(userInterface?: UserInterface) {
    if (userInterface) {
      this.name = userInterface.name;
      this.email = userInterface.email;
    }
  }

  isValid() {
    return this.name && this.email;
  }
}
