import fetch from 'isomorphic-fetch';
import qs from 'query-string';

function log(message) {
    if (window.console && window.console.log) {
        window.console.log(message);
    }
}

function parseJSON(response) {
    return response.json();
}

function checkStatus(response) {
    if (response.status >= 200 && response.status < 300) {
        return response;
    }

    const error = new Error(response.statusText);
    error.response = response;
    throw error;
}

function sendRequest(statsUrl, appid, pageHost, pagePath) {
    const params = {
        appid,
        host: pageHost,
        path: pagePath,
    }
    const requestUrl = statsUrl + '?' + qs.stringify(params);
    return fetch(requestUrl)
        .then(checkStatus)
        .then(parseJSON)
        .catch(error => {
            console.error('Error -', error);
        });
}

async function requestStats(statsUrl, appid, callback) {
    if (!statsUrl || !appid) {
        log('appid is required as parameter');
        return;
    }
    const host = window.location.host;
    const path = window.location.pathname;

    const result = await sendRequest(statsUrl, appid, host, path);
    window.pageStats = result;

    if (result && callback && typeof callback === 'function') {
        try {
            callback(result);
        } catch (e) {
            window.console.error('callback error -', e);
        }
    }
}

window.ppstats = requestStats;
