import * as qs from 'qs';

export const getParams = (location) => {
  return qs.parse(location.search, {ignoreQueryPrefix: true});
};

export const buildRoute = (pathname: string, params, location) => {
  const query = qs.stringify(Object.assign(getParams(location), params));
  return `${pathname}?${query}`;
};

export const assetPath = (name: string): string => {
  if (typeof window !== 'undefined') {
    return window['app']['assets'][name];
  }
  return name;
};
