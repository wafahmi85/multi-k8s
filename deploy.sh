docker build -t wafahmi/multi-client:latest -t wafahmi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wafahmi/multi-server:latest -t wafahmi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wafahmi/multi-worker -t wafahmi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push wafahmi/multi-client:latest
docker push wafahmi/multi-server:latest
docker push  wafahmi/multi-worker:latest

docker push wafahmi/multi-client:$SHA
docker push wafahmi/multi-server:$SHA
docker push  wafahmi/multi-worker:$SHA 

kubectl apply -f k8s

kubectl set image deployments/client-deployment server=wafahmi/multi-client:$SHA
kubectl set image deployments/client-server server=wafahmi/multi-server:$SHA
kubectl set image deployments/client-worker server=wafahmi/multi-worker :$SHA