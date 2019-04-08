docker build -t kukutapan/fibo-client:latest -t kukutapan/fibo-client:$SHA -f ./client/Dockerfile ./client
docker build -t kukutapan/fibo-server:latest -t kukutapan/fibo-server::$SHA -f ./server/Dockerfile ./server
docker build -t kukutapan/fibo-worker:latest t kukutapan/fibo-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kukutapan/fibo-client:latest
docker push kukutapan/fibo-server:latest
docker push kukutapan/fibo-workerL:latest

docker push kukutapan/fibo-client:$SHA
docker push kukutapan/fibo-server:$SHA
docker push kukutapan/fibo-workerL:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kukutapan/fibo-server:$SHA
kubectl set image deployments/client-deployment client=kukutapan/fibo-client:$SHA
kubectl set image deployments/worker-deployment worker=kukutapan/fibo-worker:$SHA