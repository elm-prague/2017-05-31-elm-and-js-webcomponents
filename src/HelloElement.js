
export default class HelloElement extends HTMLElement {
  constructor() {
    super();
    this._data = {
      salutation: 'World',
    };

    this.addEventListener('click', () => {
      console.log('--- click!')
      this._eventData = `${Date.now()}`;
      this.dispatchEvent(new Event('update-salutation'));
    });
    this.addEventListener('update-salutation', (...args) => {
      console.log('args', args)
    });

  }

  static get observedAttributes() {
    return ['salutation'];
  }

  connectedCallback() {
    console.log('connectedCallback');
    this._updateRendering();
  }

  attributeChangedCallback(name, oldValue, newValue) {
    console.log('attributeChangedCallback', { name, oldValue, newValue });

    const update = this._getDataUpdate(name, oldValue, newValue);
    if (update) {
      this._data = Object.assign(
        {},
        this._data,
        update,
      );

      this._updateRendering();
    }
  }

  disconnectedCallback() {
    console.log('disconnectedCallback');
  }

  _getDataUpdate(name, oldValue, newValue) {
    switch (name) {
      case 'salutation':
        return { salutation: newValue };

      default:
        return null;
    }
  }

  _updateRendering(force = false) {
    const { salutation } = this._data;
    this.innerHTML = `
      <div class="hello">
        <div><em>This is rendered using JavaScript</em></div>
        Hello, <b>${salutation}</b>!
      </div>
    `;
  }
}
