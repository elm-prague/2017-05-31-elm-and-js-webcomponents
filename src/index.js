import 'document-register-element';
import './main.css'

import HelloElement from './HelloElement';

customElements.define('hello-element', HelloElement)

const Elm = require('./App.elm')
const root = document.getElementById('root')

Elm.App.embed(root, '')
