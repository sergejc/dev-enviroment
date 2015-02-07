#!/bin/zsh

# Install email
echo "enter user name for msmtp"
read USERNAME
echo "enter real name"
read REALNAME
echo "password for msmtp"
read PASSWORD
echo "enter your email"
read EMAIL

# MSMTP
sudo apt-get install msmtp -y
touch $HOME/.msmtprc 
touch $HOME/.msmtp.log

cat <<EOF > "$HOME/.msmtprc"
account default
host smtp.gmail.com
port 587
from "$EMAIL"
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt 
auth on
user "$EMAIL"
password "$PASSWORD"
logfile ~/.msmtp.log
EOF
chmod 600 $HOME/.msmtprc

# Fetchmail
sudo apt-get install fetchmail -y

cat <<EOF > "$HOME/.fetchmailrc"
with proto POP3
user "$EMAIL"
there with password "$PASSWORD"
is "$USERNAME" here
mda "/usr/bin/procmail -d %T"
options
no keep
ssl
sslcertck
sslcertpath /etc/ssl/certs
EOF
chmod 600 $HOME/.fetchmailrc

#Procmail
sudo apt-get install procmail -y
echo "MAIL=/var/spool/mail/$USERNAME && export MAIL" >> $HOME/dotfiles/bash/env

cat <<EOF > "$HOME/.procmailrc"
PATH=/bin:/usr/bin:/usr/local/bin
VERBOSE=off
MAILDIR=$HOME/Mail
LOGFILE=$HOME/.procmaillog
EOF

# Mutt
cat <<EOF > "$HOME/.muttrc"
set realname =$REALNAME
set from =$EMAIL
set use_from = yes
set envelope_from ="yes"
set sendmail="/usr/bin/msmtp"

# If not set in environment variables:
set spoolfile = /var/spool/mail/$USERNAME


#======================================================#
# Folders
set folder="~/Mail"                # Mailboxes in here
set record="+sent"                 # where to store sent messages
set postponed="+postponed"         # where to store draft messages
set move=no                        # Don't move mail from the spool.

#======================================================#
# Watch these mailboxes for new mail:
mailboxes ! +Fetchmail +slrn +mutt
set sort_browser=alpha    # Sort mailboxes by alpha(bet)

#======================================================#
# Order of headers and what to show
hdr_order Date: From: User-Agent: X-Mailer \
              To: Cc: Reply-To: Subject:
ignore *
unignore Date: From: User-Agent: X-Mailer  \
             To: Cc: Reply-To: Subject:
#======================================================#
# which editor do you want to use? 
# vim of course!
set editor="vim -c 'set tw=70 et' '+/^$' "
set edit_headers          # See the headers when editing
#======================================================#
# Aliases

set sort_alias=alias     # sort aliases in alpha order by alias name

#======================================================#
# Odds and ends
set markers          # mark wrapped lines of text in the pager with a +
set smart_wrap       # Don't wrap mid-word
set pager_context=5  # Retain 5 lines of previous page when scrolling.
set status_on_top    # Status bar on top.
push <show-version>  # Shows mutt version at startup
EOF
