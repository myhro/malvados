import React from 'react';

class Result extends React.Component {
  renderList() {
    let list = this.props.items.map((item, i) => {
      return (
        <React.Fragment key={i}>
          <h5>Tirinha {item.id}</h5>
          <p>
            <a href={item.url}>{item.url}</a>
          </p>
          <div dangerouslySetInnerHTML={{ __html: item.text }}></div>
        </React.Fragment>
      );
    });

    return list;
  }

  render() {
    if (this.props.items.length > 0) {
      return (
        <div className="row left-align">
          <div className="col l8 offset-l2 s10 offset-s1">
            {this.renderList()}
          </div>
        </div>
      );
    }
    return <React.Fragment />;
  }
}

export default Result;
