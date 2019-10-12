import * as xhr from 'xhr';

export const getCsrfToken = () => {
  return document.querySelector('meta[name="csrf-token"]').getAttribute('content');
};

export const post = (uri, data, cb): void => {
  // @ts-ignore
  xhr({
    uri,
    method: 'post',
    json: true,
    body: data,
    headers: {
      'X-CSRF-Token': getCsrfToken(),
    },
  }, (err, response, body) => {
    if (err) {
      cb(err);
      return;
    }

    if (!response || response.statusCode > 399) {
      cb(new Error('Request failed'));
      return;
    }

    cb(null, body);
  });
};
