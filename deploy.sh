docker build -t kausjethdoc/complex_client:latest -t kausjethdoc/complex_client:$SHA -f ./client/Dockerfile ./client
docker build -t kausjethdoc/complex_server:latest -t kausjethdoc/complex_server:$SHA -f ./servert/Dockerfile ./server
docker build -t kausjethdoc/complex_worker:latest -t kausjethdoc/complex_worker:$SHA -f ./worker/Dockerfile ./worker
docker push kausjethdoc/complex_client:latest
docker push kausjethdoc/complex_client:$SHA

docker push kausjethdoc/complex_server:latest
docker push kausjethdoc/complex_server:$SHA

docker push kausjethdoc/complex_worker:latest
docker push kausjethdoc/complex_worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-depl server=kausjethdoc/complex_server:$SHA
kubectl set image deployments/client-depl client=kausjethdoc/complex_client:$SHA
kubectl set image deployments/worker-depl worker=kausjethdoc/complex_worker:$SHA

