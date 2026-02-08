import { appendFileSync, mkdirSync, writeFileSync, existsSync } from 'fs';
import { join } from 'path';

const LOG_DIR = join(process.cwd(), 'tmp');
const LOG_PATH = join(LOG_DIR, 'debug.log');

try { mkdirSync(LOG_DIR, { recursive: true }); } catch {}

/**
 * Write a structured debug trace to tmp/debug.log.
 * @param hypothesis - Which hypothesis this trace validates (H1, H2, H3...)
 * @param location - Code location identifier (e.g. "processOrder:entry")
 * @param data - Any runtime data to capture
 */
export function debugTrace(hypothesis: string, location: string, data?: any) {
  const entry = JSON.stringify({
    t: new Date().toISOString(),
    h: hypothesis,
    loc: location,
    data: data ?? null,
  }) + '\n';
  try { appendFileSync(LOG_PATH, entry); } catch {}
}

/** Clear the log file before a new reproduction session. */
export function debugClear() {
  try { writeFileSync(LOG_PATH, ''); } catch {}
}

/** Check if the log file exists and has content. */
export function debugHasLogs(): boolean {
  try { return existsSync(LOG_PATH); } catch { return false; }
}
