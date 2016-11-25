import React from "react";

class Weather extends React.Component {
  constructor() {

    super();
    this.state = {
      weather: undefined
    };
  }


  componentDidMount() {
    navigator.geolocation.getCurrentPosition(this.pollWeather.bind(this));
  }

  pollWeather(location) {
    let lat = location.coords.latitude;
    let long = location.coords.longitude;
    const apikey ="488c9179f2e875737d42014405c354f3";

    const params = {
      lat: lat,
      lon: long,
      appid: apikey
    };

    let url = `http://api.openweathermap.org/data/2.5/weather?appid=${params.appid}&lat=${params.lat}&lon=${params.lon}`;

    const xhr = new XMLHttpRequest();
    xhr.open("GET", url);
    xhr.onload = this.handleData.bind(this);
    xhr.send();
  }


  handleData(data, status) {
    this.setState({weather: JSON.parse(data.target.response)});
  }

  render() {
    // const weather = [];
    // console.log(this.state.weather);
    // for(let prop in this.state.weather) {
    //   weather.push(<span key={prop}>{this.state.weather[prop].toString()}</span>);
    // }

    let temp;
    let name;

    if(this.state.weather !== undefined){
      temp = ((this.state.weather.main.temp - 273) * (9/5) + 32).toFixed(2);
      name = this.state.weather.name;
    }

    return (
      <section className={"weather"}>
        <article>
          <h3 className={"city"}>{name}</h3>
          <h3 className={"temp"}>{temp}°</h3>
        </article>
      </section>
    );
  }

}

export default Weather;


// 488c9179f2e875737d42014405c354f3
