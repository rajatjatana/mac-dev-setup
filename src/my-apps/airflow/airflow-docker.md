

# This installs the airflow over the docker 
[Skip to one script](#run-all-together)


### Pull the docker image 
```
docker pull puckel/docker-airflow
```
**Check if the image has been pulled**
```
docker images
```

### Run the docker image 
```
docker run -d -p 8080:8080 puckel/docker-airflow webserver

# Check if the container is running
docker ps 

# Jump into your container shell 

docker exec -ti <container name> bash 
```
### Mount the dags folder to the container volume 

```
docker run -d -p 8080:8080 -v <path to dags folder>:/usr/local/airflow/dags  puckel/docker-airflow webserver

# In my case 

docker run -d -p 8080:8080 -v ~/repos/airflow-dags:/usr/local/airflow/dags  puckel/docker-airflow webserver
```


### Run all together 

```
docker pull puckel/docker-airflow
mkdir -p ~/repos/airflow-dags
curl https://raw.githubusercontent.com/vishalsatam/Data-Pipelining/master/Airflow/AirflowDemo/Helloworld.py -o ~/repos/airflow-dags/dag.py

docker run -d -p 8080:8080 -v ~/repos/airflow-dags:/usr/local/airflow/dags  puckel/docker-airflow webserver

```
