import 'document-register-element';
import './main.css'

import HelloElement from './HelloElement';
customElements.define('hello-element', HelloElement)


class HelloTheSecond extends HTMLElement {
  constructor() {
    super();

    this._data = "World";
  }

  static get observedAttributes() {
    return ["salutation"];
  }

  connectedCallback() {
    this._render();

    this.addEventListener("click", () => {
      this._eventData = "World";
      this.dispatchEvent(new Event("set-salutation"))
    });
  }

  attributeChangedCallback(name, oldValue, newValue) {
    console.log('attributeChangedCallback', { name, oldValue, newValue });

    this._data = newValue;
    this._render();
  }

  _render() {
    this.innerHTML = `<em>Hello, ${this._data}!</em>`;
  }
}

customElements.define('hello-the-second', HelloTheSecond)

const Elm = require('./App.elm')
const root = document.getElementById('root')

Elm.App.embed(root, '')
