#!/bin/sh

# docker-entrypoint file (source and overwrite).
DOCKER_ENTRYPOINT_FILE="/usr/local/bin/docker-php-entrypoint"

# Count phrase '# BEGIN Additional Commands.'.
COMMAND_COUNT=$(grep -c '# BEGIN Additional Commands.' $DOCKER_ENTRYPOINT_FILE)

# Remember original content "docker-php-entrypoint".
ORIGINAL_CONTENT=$(cat $DOCKER_ENTRYPOINT_FILE)

# Insert Postfix Command.
INSERT_COMMAND="
# BEGIN Additional Commands.
sudo /usr/local/bin/provision-php-ini.sh
sudo /usr/local/bin/provision-apache2-conf.sh
# END Additional Commands."

# Replace some characters.
#  \n → LINEFEED
#  /  → SLASH
INSERT_COMMAND=$(echo "$INSERT_COMMAND" | sed -z "s%\n%LINEFEED%g; s%/%SLASH%g")

# Overwrite docker-entrypoint file.
#  (Undo replaced characters.)
#  LINEFEED → \n
#  SLASH    → /
if [ 0 -eq "$COMMAND_COUNT" ]; then
  echo "$ORIGINAL_CONTENT" \
    | tac \
    | sed -z "0,/\n\n/ s/\n\n/\n_MARKER_\n/" \
    | tac \
    | sed -z "s%_MARKER_%$INSERT_COMMAND%" \
    | sed -z "s%LINEFEED%\n%g; s%SLASH%/%g" \
    > $DOCKER_ENTRYPOINT_FILE
fi