import { Component, OnInit, OnDestroy } from '@angular/core';
import { Ng2Cable } from 'ng2-cable/js/index';

@Component({
  selector: 'trivia',
  template: `
    <h1>Hello</h1>
  `
})
export class AppComponent {
  constructor(private ng2cable: Ng2Cable) {
    this.ng2cable.setCable(`ws://localhost:3000/cable`);
  }

  ngOnInit() {
    this.ng2cable.subscription = this.ng2cable.cable.subscriptions.create({ channel: 'QuizChannel' }, {
      received: (data) => {
        console.log(data)
      }
    });
  }
}
