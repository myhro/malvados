import React from 'react';

export function cleanURL() {
  setURL(window.location.pathname);
}

function setURL(url) {
  window.history.pushState(null, '', url);
}

export function updateURL(value) {
  let url = window.location.pathname + '?q=' + value;
  setURL(url);
}

export class Search extends React.Component {
  render() {
    return (
      <div className="row">
        <div className="input-field col l6 offset-l3 s8 offset-s2">
          <input
            type="text"
            value={this.props.value}
            onChange={this.props.onChange}
            onFocus={this.props.onFocus}
            onKeyDown={this.props.onKeyDown}
          />
        </div>
      </div>
    );
  }
}
