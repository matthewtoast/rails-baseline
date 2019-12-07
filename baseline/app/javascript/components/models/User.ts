import {Base} from './Base';

export class User extends Base {
  get email (): string { return this.data.email; }
  get pictureUrl (): string { return this.data.picture_url; }
  get givenName (): string { return this.data.given_name; }
  get familyName (): string { return this.data.family_name; }
  get isAdmin (): boolean { return this.data.role.name === 'admin'; }
  get fullName (): string {
    return `${this.givenName} ${this.familyName}`;
  }

  static hydrate = (data): User => {
    return new User(data);
  }
}
