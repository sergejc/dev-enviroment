#!/bin/zsh


# Mutt
sudo apt install mutt

# Install email
echo "enter user name"
read USERNAME
echo "enter real name"
read REALNAME
echo "enter password"
read PASSWORD
echo "enter your email"
read EMAIL


cat <<EOF > $HOME/.muttrc
set from = $EMAIL
set realname = $USERNAME

set imap_user = $EMAIL
set imap_pass = $PASSWORD

# REMOTE GMAIL FOLDERS
set folder = 'imaps://imap.gmail.com:993'
set spoolfile = '+INBOX'
set postponed ='+[Google Mail]/Drafts'
set trash = '+[Google Mail]/Trash'
set any_label = '+[Google Mail]/any_label'

# LOCAL FOLDERS FOR CACHED HEADERS AND CERTIFICATES
set header_cache =~/.mutt/cache/headers
set message_cachedir =~/.mutt/cache/bodies
set certificate_file =~/.mutt/certificates

# SMTP SETTINGS
set smtp_url = 'smtp://sergej.charski@smtp.gmail.com:587/'
set smtp_pass = $PASSWORD

# SECURING
set move = no  #Stop asking to move read messages to mbox!
set imap_keepalive = 900

bind editor  noop
macro index gi '=INBOX' 'Go to inbox'
macro index ga '=[Google Mail]/All Mail' 'Go to all mail'
macro index gs '=[Google Mail]/Sent Mail' 'Go to Sent Mail'
macro index gd '=[Google Mail]/Drafts' 'Go to drafts'
EOF

chmod 700 $HOME/.muttrc

sudo apt autoremove -y
