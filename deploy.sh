docker build -t aqrulesms/multi-client:latest -t aqrulesms/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aqrulesms/multi-server:latest -t aqrulesms/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aqrulesms/multi-worker:latest -t aqrulesms/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push aqrulesms/multi-client:latest
docker push aqrulesms/multi-server:latest
docker push aqrulesms/multi-worker:latest
docker push aqrulesms/multi-client:$SHA
docker push aqrulesms/multi-server:$SHA
docker push aqrulesms/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aqrulesms/multi-server:$SHA
kubectl set image deployments/client-deployment client=aqrulesms/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aqrulesms/multi-worker:$SHA