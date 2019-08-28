FILE=$(cat)
FIFO="/tmp/dotfiles_pass_fifo_$$"
mkfifo -m 0600 $FIFO
secret-tool lookup name dotfiles_pass > $FIFO &
openssl enc -aes-256-ctr -pbkdf2 -d -pass file:$FIFO -base64 <<< $FILE
rm $FIFO
