docker build -t sauravbiswas/multi-client:latest -t sauravbiswas/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t sauravbiswas/multi-server:latest -t sauravbiswas/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t sauravbiswas/multi-worker:latest -t sauravbiswas/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push sauravbiswas/multi-client:latest
docker push sauravbiswas/multi-server:latest
docker push sauravbiswas/multi-worker:latest

docker push sauravbiswas/multi-client:$SHA
docker push sauravbiswas/multi-server:$SHA
docker push sauravbiswas/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sauravbiswas/multi-server:$SHA
kubectl set image deployments/client-deployment client=sauravbiswas/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sauravbiswas/multi-worker:$SHA