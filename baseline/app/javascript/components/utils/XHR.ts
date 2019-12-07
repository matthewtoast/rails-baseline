import * as xhr from 'xhr';
import * as qs from 'qs';

export const getCsrfToken = () => {
  return document.querySelector('meta[name="csrf-token"]').getAttribute('content');
};

export const get = (uri, cb): void => {
  // @ts-ignore
  xhr({
    uri,
    method: 'get',
    json: true,
    headers: {
      'X-CSRF-Token': getCsrfToken(),
    },
  }, handle(cb));
};

export const getWithQs = (pathname, query, cb): void => {
  const uri = `${pathname}?${qs.stringify(query)}`;
  get(uri, cb);
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
  }, handle(cb));
};

export const del = (uri, data, cb): void => {
  // @ts-ignore
  xhr({
    uri,
    method: 'delete',
    json: true,
    body: data,
    headers: {
      'X-CSRF-Token': getCsrfToken(),
    },
  }, handle(cb));
};

export const put = (uri, data, cb): void => {
  // @ts-ignore
  xhr({
    uri,
    method: 'put',
    json: true,
    body: data,
    headers: {
      'X-CSRF-Token': getCsrfToken(),
    },
  }, handle(cb));
};

export const handle = (cb) => (error, response, body) => {
  // First, try to give a friendly error message.
  const status = (body && body.status) || response.statusCode;
  if (status > 399)  {
    const message =
      errorForCustomCode(body.code) ||
      (body && body.message) ||
      errorForStatusCode(status) ||
      DEFAULT_ERROR_MESSAGE;

    cb(new Error(message));
    return;
  }

  if (error) {
    cb(error);
    return;
  }

  cb(null, body, response);
};

export const errorForCustomCode = (_: string): string => {
  return null;
};

export const errorForStatusCode = (status: number): string => {
  if (status === 400 || status === 422) {
    return "Sorry! We couldn't process your request. Please try again with different input.";
  }

  if (status === 401) {
    return "Oops! You're not authorized to do that! Please log in and try again.";
  }

  if (status === 404) {
    return "Sorry! We're unable to find what you're looking for.";
  }

  if (status > 499) { // 5xx
    return 'Oops! Server error! Our developers have been notified. Please try again later.';
  }

  return HTTP_CODES[status];
};

export const DEFAULT_ERROR_MESSAGE = 'Oops! Something went wrong. Please try again later.';

export const HTTP_CODES = {
  100: 'Continue',
  101: 'Switching Protocols',
  102: 'Processing',
  200: 'OK',
  201: 'Created',
  202: 'Accepted',
  203: 'Non-Authoritative Information',
  204: 'No Content',
  205: 'Reset Content',
  206: 'Partial Content',
  207: 'Multi-Status',
  208: 'Already Reported',
  226: 'IM Used',
  300: 'Multiple Choices',
  301: 'Moved Permanently',
  302: 'Found',
  303: 'See Other',
  304: 'Not Modified',
  305: 'Use Proxy',
  306: 'Reserved',
  307: 'Temporary Redirect',
  308: 'Permanent Redirect',
  400: 'Bad Request',
  401: 'Unauthorized',
  402: 'Payment Required',
  403: 'Forbidden',
  404: 'Not Found',
  405: 'Method Not Allowed',
  406: 'Not Acceptable',
  407: 'Proxy Authentication Required',
  408: 'Request Timeout',
  409: 'Conflict',
  410: 'Gone',
  411: 'Length Required',
  412: 'Precondition Failed',
  413: 'Request Entity Too Large',
  414: 'Request-URI Too Long',
  415: 'Unsupported Media Type',
  416: 'Requested Range Not Satisfiable',
  417: 'Expectation Failed',
  422: 'Unprocessable Entity',
  423: 'Locked',
  424: 'Failed Dependency',
  425: 'Unordered Collection',
  426: 'Upgrade Required',
  427: 'Unassigned',
  428: 'Precondition Required',
  429: 'Too Many Requests',
  430: 'Unassigned',
  431: 'Request Header Fields Too Large',
  500: 'Internal Server Error',
  501: 'Not Implemented',
  502: 'Bad Gateway',
  503: 'Service Unavailable',
  504: 'Gateway Timeout',
  505: 'HTTP Version Not Supported',
  506: 'Variant Also Negotiates',
  507: 'Insufficient Storage',
  508: 'Loop Detected',
  509: 'Bandwidth Limit Exceeded',
  510: 'Not Extended',
  511: 'Network Authentication Require',
};
