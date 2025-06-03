#!/bin/bash
set -e
REPOSITORY_NAME="$1"
USERNAME="$2"
PASSWORD="$3"
if [ -z "$REPOSITORY_NAME" ] || [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
  echo "Usage: $0 <repository_name> <username> <password>"
  exit 1
fi
REMOTE_URL="https://${USERNAME}:${PASSWORD}@github.com/${USERNAME}/${REPOSITORY_NAME}.git"
mkdir "$REPOSITORY_NAME"
cd "$REPOSITORY_NAME"
echo "# ${REPOSITORY_NAME}" >> README.md
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
git init
git add .
git commit -m "first commit"
git remote add origin "$REMOTE_URL"
git branch -m main
git push -u origin main
