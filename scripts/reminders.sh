#!/usr/bin/bash

echo $(osascript -e "tell application \"Reminders\" to set reminderCount to count of (reminders in list \"Reminders\" whose completed is false)")
