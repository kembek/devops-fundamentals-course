echo -n "USERNAME: "; IFS= read -r uname
echo -n "PASSWORD: "; stty -echo; IFS= read -r passwd; stty echo; echo
docker login -u "$uname" -p "$passwd"
unset -v passwd 

echo -n "Please type tag: "; IFS= read -r tag

docker build -t kembek/test_repository:$tag .
docker push kembek/test_repository:$tag