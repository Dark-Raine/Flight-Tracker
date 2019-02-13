const loginPageEl = document.body.querySelector('#login-page')
const usrNameEl = document.body.querySelector('#usr-input')
const loginBtnEl = document.body.querySelector('#login-btn')
const createUserPath = 'http://localhost:3000/api/v1/users/'


state = {
    user: null,
    retrievedUser: null,
    searchParams: {
      "inboundDate" : "2019-03-10",
      "cabinClass" : "economy",
      "children" : 0,
      "infants" : 0,
      "groupPricing" : "false",
      "country" : "UK",
      "currency" : "GBP",
      "locale" : "en-UK",
      "originPlace" : "SFO-sky",
      "destinationPlace" : "LHR-sky",
      "outboundDate" : "2019-02-15",
      "adults" : 1
    }
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
            
        }
    })
}


const initialise = () => {
    appHandler()
}

initialise()
