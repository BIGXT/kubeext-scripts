curl -L https://github.com/jenkins-x/jx/releases/download/v2.0.1220/jx-linux-amd64.tar.gz | tar xzv 
sudo mv jx /usr/local/bin
#kubectl apply -f crd-jenkins.yaml
#kubectl apply -f instance-operator.yaml
#kubectl apply -f operator-jenkins.yaml
#kubectl get secret jenkins-operator-credentials-<cr_name> -o 'jsonpath={.data.user}' | base64 -d
#kubectl get secret jenkins-operator-credentials-<cr_name> -o 'jsonpath={.data.password}' | base64 -d

