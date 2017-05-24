#!/usr/bin/bash

echo $(osascript -e "tell application \"Reminders\" to set reminderCount to count of (reminders whose completed is false)")
