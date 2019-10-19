export const esser = (
  num: number,
  plural: string,
  singular: string,
): string => {
  if (num === 1) {
    return `${num} ${singular}`;
  }
  return `${num} ${plural}`;
};

export const possesser: string = (
  name: string,
): string => {
  const last = name[name.length - 1];
  return (last.toLowerCase() === 's')
    ? `${name}'`
    : `${name}'s`;
};

export const trunc = (s: string, n: number): string => {
  return s.slice(0, n);
};
