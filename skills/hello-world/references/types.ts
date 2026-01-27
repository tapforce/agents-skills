/**
 * Example TypeScript Definition
 */

export interface Greeting {
  message: string;
  recipient: string;
  timestamp: Date;
}

export interface SkillConfig {
  name: string;
  enabled: boolean;
  maxRetries?: number;
}
