FILE=$(cat)
SALT=$(openssl dgst -sha256 <<< $FILE | cut -d ' ' -f2- | cut -c-16)
FIFO="/tmp/dotfiles_pass_fifo_$$"
mkfifo -m 0600 $FIFO
secret-tool lookup name dotfiles_pass > $FIFO &
openssl enc -aes-256-ctr -pbkdf2 -e -pass file:$FIFO -base64 -salt -S "$SALT" <<< $FILE
rm $FIFO
