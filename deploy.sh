docker build -t prabhneetdocker/multi-client:latest -t prabhneetdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t prabhneetdocker/multi-server:latest -t prabhneetdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t prabhneetdocker/multi-worker:latest -t prabhneetdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push prabhneetdocker/multi-client:latest
docker push prabhneetdocker/multi-server:latest
docker push prabhneetdocker/multi-worker:latest

docker push prabhneetdocker/multi-client:$SHA
docker push prabhneetdocker/multi-server:$SHA
docker push prabhneetdocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=prabhneetdocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=prabhneetdocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=prabhneetdocker/multi-worker:$SHA