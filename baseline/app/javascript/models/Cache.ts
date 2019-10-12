export class Cache {
  data: {[key: string]: any};
  constructor () {
    this.data = {};
  }
  get (key: string): any { return this.data[key]; }
  set (key: string, value: any) { this.data[key] = value; }
  fetch (key: string, provider: () => any) {
    const maybe = this.get(key);
    if (maybe !== undefined) {
      return maybe;
    }
    const value = provider();
    this.set(key, value);
    return value;
  }
}
