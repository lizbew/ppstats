import fetch from 'isomorphic-fetch';
import qs from 'query-string';

function log(message) {
    if (window.console && window.console.log){
        window.console.log(message);
    }
}


function sendRequest(statsUrl, appid, pageHost, pageUrl) {
    const params = {
        appid,
        host: pageHost,
        url: pageUrl,
    }
    const requestUrl = statsUrl + '?' + qs.stringify(params);
    return fetch(requestUrl)
        .then(response => response.json())
        .catch(error => {
            console.error('Error -', error);
        });
    }

async function requestStats(statsUrl, appid, callback) {
    if (!statsUrl || !appid ){
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
        } catch(e) {
            window.console.error('callback error -', e);
        }
    }
}

window.ppstats = requestStats;
