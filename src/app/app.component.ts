import { DOCUMENT } from '@angular/common';
import { Component, Inject } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'angular-bootswatch-theme-selector';
  linkElement: HTMLLinkElement | undefined; 

  constructor(@Inject(DOCUMENT) private document: Document) {}

  loadTheme(cssFile: string) {
		if (!this.linkElement) {
			const headElement = this.document.getElementsByTagName('head')[0];
			this.linkElement = this.document.createElement('link');
			this.linkElement.id = 'client-theme';
			this.linkElement.rel = 'stylesheet';
			this.linkElement.type = 'text/css';
			headElement.appendChild(this.linkElement);
		}
		this.linkElement.href = cssFile;
	}
}
