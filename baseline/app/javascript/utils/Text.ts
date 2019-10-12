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
