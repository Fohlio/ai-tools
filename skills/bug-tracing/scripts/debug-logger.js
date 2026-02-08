const { appendFileSync, mkdirSync, writeFileSync, existsSync } = require('fs');
const { join } = require('path');

const LOG_DIR = join(process.cwd(), 'tmp');
const LOG_PATH = join(LOG_DIR, 'debug.log');

try { mkdirSync(LOG_DIR, { recursive: true }); } catch {}

/**
 * Write a structured debug trace to tmp/debug.log.
 * @param {string} hypothesis - Which hypothesis this trace validates (H1, H2, H3...)
 * @param {string} location - Code location identifier (e.g. "processOrder:entry")
 * @param {*} [data] - Any runtime data to capture
 */
function debugTrace(hypothesis, location, data) {
  const entry = JSON.stringify({
    t: new Date().toISOString(),
    h: hypothesis,
    loc: location,
    data: data !== undefined ? data : null,
  }) + '\n';
  try { appendFileSync(LOG_PATH, entry); } catch {}
}

/** Clear the log file before a new reproduction session. */
function debugClear() {
  try { writeFileSync(LOG_PATH, ''); } catch {}
}

/** Check if the log file exists and has content. */
function debugHasLogs() {
  try { return existsSync(LOG_PATH); } catch { return false; }
}

module.exports = { debugTrace, debugClear, debugHasLogs };
