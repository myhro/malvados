/* global process */

import React from 'react';
import ReactDOM from 'react-dom';

import Result from './result';
import Search from './search';

import logo from './img/logo.jpg';

import '../node_modules/materialize-css/dist/css/materialize.min.css';

import './css/style.css';

class App extends React.Component {
  constructor(props) {
    super(props);

    this.handleChange = this.handleChange.bind(this);
    this.handleFocus = this.handleFocus.bind(this);
    this.handleKeyDown = this.handleKeyDown.bind(this);
    this.search = this.search.bind(this);

    this.state = {
      results: [],
      value: '',
    };
  }

  handleChange(event) {
    let value = event.target.value;
    this.setState({ value });
  }

  handleFocus() {
    let results = [];
    let value = '';
    this.setState({ results, value });
  }

  handleKeyDown(event) {
    if (event.key == 'Enter' && this.state.value != '') {
      this.search();
    }
  }

  async search() {
    let url = new URL(`${location.protocol}//${process.env.API_URL}`);
    url.searchParams.append('q', this.state.value);

    let res = await fetch(url);
    let results = await res.json();

    this.setState({ results });
  }

  render() {
    return (
      <div className="container center">
        <div className="row">
          <img src={logo} className="logo" />
        </div>
        <h1 className="grey-text text-darken-1">Buscador Malvados</h1>
        <Search
          value={this.state.value}
          onChange={this.handleChange}
          onFocus={this.handleFocus}
          onKeyDown={this.handleKeyDown}
        />
        <Result items={this.state.results} />
      </div>
    );
  }
}

ReactDOM.render(<App />, document.getElementById('root'));
