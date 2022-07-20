docker build -t wafahmi/multi-client:latest -t wafahmi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wafahmi/multi-api:latest -t wafahmi/multi-api:$SHA -f ./server/Dockerfile ./server
docker build -t wafahmi/multi-worker -t wafahmi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push wafahmi/multi-client:latest
docker push wafahmi/multi-api:latest
docker push  wafahmi/multi-worker:latest

docker push wafahmi/multi-client:$SHA
docker push wafahmi/multi-api:$SHA
docker push  wafahmi/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=wafahmi/multi-client:$SHA
kubectl set image deployments/server-deployment api=wafahmi/multi-api:$SHA
kubectl set image deployments/worker-deployment worker=wafahmi/multi-worker:$SHA