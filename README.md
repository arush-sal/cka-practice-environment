# cka-practice-environment

## Getting the environment up and ready

Make sure that you have docker-compose installed([installation instructions](https://docs.docker.com/compose/install/)).

To start the lab environment just run `docker-compose up -d` and point your browser at `localhost`


Things to note:
* The setup currently is in `Bring Your Own Cluster` state.
* If your reload the `exam.html` it will reset the timer as the timer currently being used is jQuery based. - solution WIP
* Since we are using jQuery to initialize and connect to GateOne therefore the application needs to be reachable from your browser host on port 8080. - solution WIP
