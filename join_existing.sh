#!/bin/bash
set -e
REPOSITORY_NAME="$1"
USERNAME="$2"
TOKEN="$3"
if [ -z "$REPOSITORY_NAME" ] || [ -z "$USERNAME" ] || [ -z "$TOKEN" ]; then
  echo "Usage: $0 <repository_name> <username> <token>"
  exit 1
fi
REMOTE_URL="https://${USERNAME}:${TOKEN}@github.com/${USERNAME}/${REPOSITORY_NAME}.git"
git clone "$REMOTE_URL"
cd "$REPOSITORY_NAME"
cat << 'EOF' > push.sh
#!/bin/bash
set -e
if [ -z "$1" ]; then
  echo "Usage: $0 <commit_message>"
  exit 1
fi
git rm -r --cached --ignore-unmatch .
git add .
git commit -m "$1"
git push
EOF
chmod +x push.sh
echo "/push.sh" >> .gitignore
