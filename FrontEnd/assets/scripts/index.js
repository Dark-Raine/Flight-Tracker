const loginPageEl = document.body.querySelector('#login-page')
const usrNameEl = document.body.querySelector('#usr-input')
const loginBtnEl = document.body.querySelector('#login-btn')
const createUserPath = 'http://localhost:3000/api/v1/users/'
const createFlightPath = 'http://localhost:3000/getflights'
const persistedFlightPath = 'http://localhost:3000/flights'
const searchForm = document.body.querySelector('.search-form')
const searchPage = document.body.querySelector('#search-page')
const resStack = document.body.querySelector('#results-stack')
const loginForm = document.body.querySelector('#login-form')

let flightData = document.body.querySelector('.flight-data')


state = {
    user: null,
    retrievedUser: null,
    searchParams: {
      "inboundDate" : null ,
      "cabinClass" : "economy",
      "children" : 0,
      "infants" : 0,
      "groupPricing" : "false",
      "country" : "UK",
      "currency" : "GBP",
      "locale" : "en-UK",
      "originPlace" : null,
      "destinationPlace" : null,
      "outboundDate" : null,
      "adults" : 1
    },
    flights: null,
    parsedFlights:[]


}

const createFlight = () => {
  return fetch(createFlightPath, {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type':'application/json'
    },
    body: JSON.stringify({flightinfo: state.searchParams})
  }).then(resp => resp.json())
}
const persistFlight = () => {

}

const saveFlight = (id) => {
  let flight = state.parsedFlights[id]
  fetch(persistedFlightPath, {
    method: 'POST',
    headers: {
      'Accept': 'application/json',
      'Content-Type':'application/json'
    },
    body: JSON.stringify({info:{flight, user_id: state.retrievedUser.id}})
  })
  .then(resp => resp.json())
  .then(obj => state.retrievedUser = obj)
}

const getFlightInfo = (inboundDate, outboundDate, originPlace, destinationPlace) => {
  state.searchParams.inboundDate = outboundDate
  state.searchParams.outboundDate = inboundDate
  state.searchParams.originPlace = originPlace
  state.searchParams.destinationPlace = destinationPlace
  // console.log(state.searchParams);
  // console.log(state.defaultParams);
  return createFlight()
}


const createUser = () => {
    return fetch(createUserPath, {
        method: 'POST',
        headers: {
            'Accept': 'application/json',
            'Content-Type':'application/json'
        },
        body: JSON.stringify({username: state.user})
    })
    .then(resp => resp.json())
}

const getUserName = (name) => {
    state.user = name
    createUser()
    .then(object => state.retrievedUser = object)
}



const appHandler = () => {
    document.body.addEventListener('click', eve => {
        if (eve.target.id === 'login-btn') {
            eve.preventDefault()
            getUserName(usrNameEl.value)
            loginPageEl.style.display = "none"
            searchPage.style.display = ""
            loginForm.reset()
        }
        if (eve.target.id === 'search-btn') {
            eve.preventDefault()
            getFlightInfo(searchForm.outboundDate.value, searchForm.inboundDate.value, searchForm.outboundLocation.value, searchForm.inboundLocation.value)
            .then(obj => state.flights = obj)
            .then(getOutLeg)
            .then(displayResults)
        }
        if (eve.target.classList.contains('save-btn')) {
          eve.preventDefault()
          saveFlight(parseInt(eve.target.id))
        }
        if (eve.target.id === "logout-nav-btn") {
          eve.preventDefault()
          loginPageEl.style.display = ""
          searchPage.style.display = "none"
          state.parsedFlights = []
          resStack.innerHTML= ''
          searchForm.reset()
        }

    })
}

const findPlace = (toFind) => {

  const destinationPlace = toFind.split("-")[0]
  const flightData = state.flights.Places
  let foundPlace

  for (key of flightData) {
    if (key.Code === destinationPlace) {
      foundPlace = key.Name
    }
  }
  return foundPlace
}

const minutesToHours = (durationMins) => {
  let hours = Math.floor(durationMins / 60);
  let minutes = durationMins % 60;
  return hours + "H" + ":" + minutes + "M";
}

const getOutLeg = () => {
  state.parsedFlights = []
  let toState = {}
  const legOut = state.flights
  for (const key of legOut.Itineraries) {
    findDetails = key.OutboundLegId
    toState = {}
    toState.flightPrice = key.PricingOptions[0].Price
    for (const id of legOut.Legs) {
      if (id.Id === findDetails) {
        toState.arrivalTime = id.Arrival.split('T')[1]
        toState.departTime = id.Departure.split('T')[1]
        toState.flightDuration = minutesToHours(id.Duration)
        toState.fromPlace = findPlace(state.searchParams.originPlace)
        toState.toPlace = findPlace(state.searchParams.destinationPlace)
        state.parsedFlights.push(toState)

      }
    }
  }
}

const displayResults = () => {
  resStack.innerHTML = ""
  todisplay = state.parsedFlights
  let id = 0
  todisplay.forEach((result) => {
    const cardEl = document.createElement('div')
    cardEl.className = 'results'
    cardEl.innerHTML =
    `
    <div class="card-result">
    <p class="in-out">From: ${result.fromPlace}</p><p class="in-out">To: ${result.toPlace}</p>
    <p class="in-out">Depart Time: ${result.departTime}</p><p class="in-out">Arrive Time: ${result.arrivalTime}</p>
    <p class="in-dur">Flight Duration: ${result.flightDuration}</p><p class="in-dur">Price: ${result.flightPrice}</p>
    </div>
    <a href="#" class="nav-buttons save-btn" id="${id}">Save</a>
    `
    id++
    resStack.appendChild(cardEl)
  })
}

const initialise = () => {
  searchPage.style.display = "none"
    appHandler()
}

initialise()
