# Prerequisite for running this - have a 3 node swarm ready
# Run on manager node:
docker network create --driver overlay frontend
docker network create --driver overlay backend

docker service create --name vote --replicas 3 --network frontend -p 80:80 bretfisher/examplevotingapp_vote

docker service create --name redis --network frontend redis:3.2

docker service create --name worker --network frontend --network backend bretfisher/examplevotingapp_worker

docker service create --name db --network backend --mount type=volume,source=db-data,target=/var/lib/postgresql/data -e POSTGRES_HOST_AUTH_METHOD=trust postgres:9.4

docker service create --name result --network backend -p 5001:80 bretfisher/examplevotingapp_result
