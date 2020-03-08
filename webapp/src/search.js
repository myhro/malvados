import React from 'react';

class Search extends React.Component {
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

export default Search;
