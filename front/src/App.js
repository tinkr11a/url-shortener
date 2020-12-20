import './App.css';
import axios from 'axios';
import { useState } from 'react'


function App() {
  const [
    url, setUrl
  ] = useState("")

  const [
    shortUrl, setShortUrl
  ] = useState("")

  const [
    infoMessage, setInfoMessage
  ] = useState("")

  const getShortUrl = async () => {
    const result = await axios(
      '/short_url?url=' + url,
    ).catch(error =>
      error.response)

    if (result.status === 200) {
      setInfoMessage("")
      setShortUrl(result.data.short_url)
    }
    else if (result.status === 422) {
      setShortUrl("")
      setInfoMessage(result.data.message)
    }
    else {
      setShortUrl("")
      setInfoMessage("Ups... something went wrong.")
    }
  }

  return (

    <div className="App">
      <div>
        <label>Enter your url:</label>
        <br />
        <input type="text" placeholder="very long url" value={url} onChange={e => setUrl(e.target.value)}></input>
        <button type="button" onClick={getShortUrl}>Shorten</button>
      </div>
      <div><a href={shortUrl} target="_blank" rel="noreferrer">{shortUrl}</a>
        <label>{infoMessage}</label></div>

    </div>

  );
}

export default App;
