import * as slug from 'slug';
import {Cache} from './Cache';

export class Base {
  cache: Cache;

  constructor (public data: {[key: string]: any}) {
    this.data = data;
    this.cache = new Cache();
  }

  get id (): string { return this.data.id as string; }
  get name (): string { return this.data.name as string; }
  get type (): string { return this.data.type as string; }
  get kind (): string { return this.data.kind as string; }
  get createdAt (): string { return this.data.created_at; }
  get updatedAt (): string { return this.data.updated_at; }

  get slug (): string {
    if (this.data.slug) {
      return this.data.slug as string;
    }
    return slug(this.name.toLowerCase(), '-');
  }
}
