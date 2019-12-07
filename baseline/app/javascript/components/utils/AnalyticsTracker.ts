export class AnalyticsTracker {
  isTrackingEnabled: boolean;
  isLoggingEnabled: boolean;

  constructor () {
    this.isTrackingEnabled = process.env.NODE_ENV !== 'development';
    this.isLoggingEnabled = false;
  }

  get analytics () {
    if (typeof window !== 'undefined') {
      return window['analytics'];
    }
  }

  log (...args) {
    if (this.isLoggingEnabled) {
      console.info(...args); // tslint:disable-line
    }
  }

  identify (userId: string, traits: {[key: string]: any} = {}): void {
    this.log('analytics:identify', userId, traits);
    if (this.analytics && this.isTrackingEnabled) {
      this.analytics.identify(userId, traits);
    }
  }

  group (groupId: string, traits: {[key: string]: any} = {}): void {
    this.log('analytics:group', groupId, traits);
    if (this.analytics && this.isTrackingEnabled) {
      this.analytics.group(groupId, traits);
    }
  }

  track (event: string, properties: {[key: string]: any} = {}): void {
    this.log('analytics:track', event, properties);
    if (this.analytics && this.isTrackingEnabled) {
      this.analytics.track(event, properties);
    }
  }

  page (name: string): void {
    this.log('analytics:page', name);
    if (this.analytics && this.isTrackingEnabled) {
      this.analytics.page(name);
    }
  }
}

export const tracker = new AnalyticsTracker();
