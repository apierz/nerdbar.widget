#!/usr/bin/python3

import mailbox

mbox = mailbox.Maildir("~/.Maildir/personal/INBOX")
mbox.lock()
count = 0
for message in mbox:
    count += 1
print(str(count))
mbox.close()
