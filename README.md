# Cloud-infra documentatie
Dit project heeft als doel het creëren van infrastructuur door middel van code, waarin ik vervolgens een applicatie laat runnen. Door technologieën zoals Docker, Terraform, Ansible en Kubernetes te integreren, richt ik op het efficiënt beheren, automatiseren en schalen van de applicatie in een cloudomgeving. 

## 1. Applicatie
De applicatie omvat een frontend, backend en database.
- frontend: vanilla HTML, CSS & JavaScript
- backend: Node.js met Express
- database: MongoDb

![App Screenshot](https://i.ibb.co/RcQ2n99/applicatiefoto.png)

## 2. Containers & Docker-Compose
### 2.1 Containerizen
De services worden gecontaineriseerd. Voor elke service wordt een Docker-image gebouwd, met uitzondering van de database, waarvoor al een image beschikbaar is. Om ervoor te zorgen dat de images op meerdere architecturen kunnen worden gebruikt, wordt het buildx-commando gebruikt. De ondersteunde architecturen worden gespecificeerd op basis van het base image.

Voor het bouwen van de images worden twee Dockerfiles aangemaakt, één voor de frontend en één voor de backend. Vervolgens wordt het buildx-commando uitgevoerd, waarbij de ondersteunde architecturen worden meegegeven. De gebouwde images worden naar mijn persoonlijke repository op Docker Hub gepusht.

- **Back-end**:
![Dockerfile backend](https://i.ibb.co/DL5mfFB/Dockerfile-Backend.png)

`docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6,linux/ppc64le,linux/s390x -t denyshabouev/cloud-infra-backend:latest -t denyshabouev/cloud-infra-backend:2 --push `

[Link dockerhub repo](https://hub.docker.com/r/denyshabouev/cloud-infra-backend)

- **Front-end**:
![Dockerfile frontend](https://i.ibb.co/Nr60fDt/Dockerfile-Frontend.png)

`docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6,linux/ppc64le,linux/s390x -t denyshabouev/cloud-infra-frontend:latest -t denyshabouev/cloud-infra-frontend:2 --push`

[Link dockerhub repo](https://hub.docker.com/r/denyshabouev/cloud-infra-frontend)

### 2.2 Composen
Om alles als één geheel op te starten, kun je het docker-compose commando gebruiken. Hiervoor moet je een "docker-compose.yml" bestand aanmaken. Met Docker Compose kun je alle services tegelijkertijd starten, en ze zitten standaard in hetzelfde netwerk. De volgorde van het opstarten is belangrijk. De database moet worden opgestart alvorens de backend kan starten, anders crasht de backend. Dit wordt opgelost met het "depends on" attribuut.

![Docker-compose file](https://i.ibb.co/6YHRrJN/dockercompose.png)

`docker compose up -d` Om de inhoud van de docker-compose.yml file uit te voeren.

- **Resultaat:**

![Docker-compose file](https://i.ibb.co/17H7Bvw/dockercontainers-app.png)
## 3. Cloudinfrastructuur met Terraform
Via Terraform kun je makkelijk infrastructuur bouwen met behulp van code. Voor het project heb ik via Terraform een Kubernetes cluster aangemaakt met drie worker nodes in de cloudomgeving van Oracle. Hiervoor heb ik de stappen gevolgd die Oracle heeft beschreven in hun [**documentatie**](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-cluster/01-summary.htm). Hiervoor zijn verschillende '.tf' bestanden aangemaakt wat het geheel, modulair maakt. Dit zorgt ervoor dat je gemakkelijker overzicht hebt over wat elk bestand doet. 

![files](https://i.ibb.co/Vpr3wXF/bestanden.png)

![StaanInJuisteFolder](https://i.ibb.co/X4k794x/pad-files.png)

Als alles klaar staat. Zorg je ervoor dat je in de folder staat met de alle Terraform files. Je voert de commando's `terraform init` en vervolgens `terraform apply` uit. De init initialiseert een nieuw of bestaand Terraform-project, downloadt benodigde plugins en configureert de backend. De apply past de voorgestelde wijzigingen toe op de infrastructuur.

- **Kubernetes cluster is aangemaakt**:

![ControlNode](https://i.ibb.co/vBVk3Qc/cluster.png)

![WorkerNodes](https://i.ibb.co/xCrx04L/workers.png)

![WorkerNode](https://i.ibb.co/CmcX9hT/voorbeeldworker.png)

**configureren kubectl** 

Volgens de documentatie van Oracle kun je makkelijk een kubeconfig bestand genereren. Hiervoor moet je eerst de OCI CLI installeren en configureren. Dit stelt je in staat om informatie op te halen over je infrastructuur. Vervolgens installeer je de kubectl om te communiceren met je kubernetes cluster. Hiervoor heb je tal van gegevens nodig voor de configbestand zoals de API endpoint, etc. Je kunt via de OCI CLI zo'n config bestand genereren via het commando: 

`oci ce cluster create-kubeconfig --cluster-id ocid1.cluster.oc1.eu-paris-1.aaaaaaaahquzbzwk7xzvsgucr7grwsp7wezf7zmhr5yzyxxz2cypxfnjdq5a --file $HOME/cloudinfra/assignmentscloudinfra-denyshabouev/K8s/kube/config --region eu-paris-1 --token-version 2.0.0 `

> [!NOTE]
> folder "kube" moet reeds aangemaakt zijn.

- **Config bestand automatisch genereerd**

![kubeconfig](https://i.ibb.co/kH6tLmP/kubeconfig.png)

Vervolgens voer je het commando `export KUBECONFIG=$HOME/cloudinfra/assignmentscloudinfra-denyshabouev/K8s/kube/config` uit. 

**Testen van kubectl & simpele front-end**

- **Cluster info**![clusterinfo](https://i.ibb.co/HY7m4t1/clusterinfo.png)

- **Worker nodes**![workernodes](https://i.ibb.co/0f7HMTv/workernodes.png)
- **Deployment file maken**![deploymentfile](https://i.ibb.co/mJqLJh5/deploymentfile.png)deployen via `kubectl apply -f testWebsite.yml` commando.
- **Deployment & pods info**![deployment & pods info](https://i.ibb.co/7Q7HVmL/3frontends.png)

- **Service file maken**![servicefile](https://i.ibb.co/6vXVnK9/servicefile.png)deployen via `kubectl apply -f loadbalancer.yml` commando.

- **Service info & draaiende front-end**![service & draaiende app ](https://i.ibb.co/cg8jmLk/servicesendraaiendeapp.png)deployen via `kubectl apply -f loadbalancer.yml` commando.
> [!NOTE]
> front-end draait foutmelding omdat het niet kan communiceren met de back-end. Enkel front-end dat draait.

## 4. Minikube lokaal test
Minikube is een tool dat maakt dat je een lokale K8s cluster kunt maken en daarin testen. Eerst en vooral moet je Minikube installeren. Dit kun je makkelijk doen aan de hand van de [**documentatie**](https://minikube.sigs.k8s.io/docs/start/) van Minikube zelf. 

Om Minikube te starten moet je het commando `minikube start --driver docker` uitvoeren. '--driver docker' betekent dat het in een dockercontainer moet draaien. Via het commando `docker ps` zie je dat de container effectief draait en via het commando `minkube status` kan de status van Minikube opgevraagd worden.


- **Docker draaiende containers**![draaiende Minikube](https://i.ibb.co/wBBjVSD/minikubedocker.png)

- **Minikube status**
\
![status](https://i.ibb.co/f24KVWf/minikubestatus.png)


Na het opstarten van Minikube, heb ik een aantal bestanden gemaakt, namelijk deployment bestanden, service bestanden, configmap & een secret bestand. De deployment bestanden worden gebruikt voor het definiëren van de pods (hoe ze gemaakt moeten worden, enzovoort). De service bestanden worden gebruikt voor de communicatie tussen de pods binnen in je K8s cluster. Configmap wordt gebruikt voor niet gevoelige omgevingsvariabelen zoals een db connectiestring. Secret file is een beetje hetzelfde als configmap maar dan voor gevoelige data zoals wachtwoorden, namen, etc.

- **Bestanden** 
\
![files deployment](https://i.ibb.co/LrD4rPn/files-Minikube.png)


De files worden uitgevoerd via het commando: `kubectl apply -f . `. De pods en de services worden aangemaakt. Vervolgens wordt het commando `kubectl get all` uitgevoerd. Dit doe je voor controle. De url verkrijg je via `minikube service {service naam}` en via deze url kun je `curl` commando uitvoeren om te zien of het werkt of niet. 

- **Kubectl apply commando**![kubectlapply](https://i.ibb.co/DQdCVHB/kubectlapply.png)

- **Controle**![controle](https://i.ibb.co/yPz7xHy/minikubegetall.png)

- **Service URL verkrijgen**![url minikube](https://i.ibb.co/dBzrFc3/serviceemini.png)

- **Testen via curl**![curl](https://i.ibb.co/sK24BZc/curl.png)


## 5. Live deployment
Voor de live deployment heb ik twee mappen gemaakt waarin de deployments en services gescheiden zijn voor een betere structuur. Buiten deze mappen bevinden zich de configmap en het secrets-bestand. Om alles uit te voeren, heb ik een eenvoudig script opgesteld dat alle yaml-bestanden uitvoert.

- **Afgezonderde bestanden**
\
![bestanden live deployment](https://i.ibb.co/Zz0fdZZ/livedeploymentfiles.png)

Het script wordt uitgevoerd en de pods worden aangemaakt. Omdat mijn front-end gebruik maakt van client-side rendering, staat de back-end API open voor iedereen. Idealiter zou de API samen met de database afgeschermd moeten zijn en alleen aangesproken worden via de pods. Echter, omdat de front-end wordt opgehaald door de gebruiker en pas daarna een oproep gedaan wordt aan de API voor gegevens, is het nodig dat de API open staat.

Hier had ik problemen:

    1) Probleem dat de IP adressen voortdurent aangepast werden.
    2) Communicatie van de back-end naar de database lukte niet.
   Om het eerste probleem op te lossen, moest ik voortdurend een nieuw front-end image pushen naar de Docker-repo omdat bij het opzetten van mijn services voortdurend een nieuw IP-adres werd gegenereerd. Ik heb besloten om met DNS-namen te werken en hiervoor twee A-records gemaakt: één voor de loadbalancer van de front-ends en één voor de loadbalancer van de back-ends. Hierdoor hoef ik alleen de IP-adressen van de A-records (cloud.dawaladeny.eu & cloud2.dawaladeny.eu) aan te passen. De front-end image is aangepast zodat de API-aanroep wordt gedaan naar de endpoint: 'http://cloud.dawaladeny.eu/api/v1/scores'.

- **A-records voor probleem 1**![DNS](https://i.ibb.co/CvV1XZW/dns.png)

Het kostte wat tijd om het tweede probleem op te lossen omdat ik niet kon achterhalen wat er mis liep. Via `kubectl logs {podnaam}` kon ik zien dat de back-end crashte. De ene keer kreeg ik de foutmelding "authentication error", de volgende keer een andere foutmelding. Toen besefte ik dat het mogelijk te maken had met de ingress rules. Mijn back-end probeerde verbinding te maken via 'mongodb://root:example@mongo-service:27017/'. Ik dacht dat de pods mogelijk niet met elkaar konden communiceren omdat bepaalde poorten geblokkeerd waren. Daarom heb ik de publieke netwerkpoorten 22, 80 en 3000 opengesteld voor iedereen. In mijn privénetwerk heb ik alle poorten opengesteld voor de netwerken binnen het bereik van 10.0.0.0/23, omdat het publieke netwerk op "10.0.0.0/24" draait en het private netwerk op "10.0.1.0/24". Dit is momenteel nog niet "veilig" omdat alle poorten openstaan.

- **Ingress rules voor probleem 2**![ingress](https://i.ibb.co/dpft8B0/ingressrules.png)

**Testen van de app**
- **Uitvoeren script**![ingress](https://i.ibb.co/Yt2FjYp/script-Livedeployment.png)

- **Alle info**![ingress](https://i.ibb.co/rs7n3QD/livedeploymentalleinfo.png)
- **Resultaat**![ingress](https://i.ibb.co/GTrMM47/livedeploymentresultaat.png)

De app werkt. Drie pods voor de front-end. Twee pods voor de back-end en één pod voor de database.


## 6. Environments en deployment
Om de app in twee verschillende omgevingen te implementeren, maak ik gebruik van Helm charts. Hierdoor kan ik eenvoudig mijn omgevingen configureren, namelijk de testomgeving en de productieomgeving. Namespaces worden automatisch aangemaakt op basis van de naam die is gedefinieerd in het 'values.yaml' bestand. Een namespace wordt gebruikt om resources in een geïsoleerde omgeving te organiseren. Aan de hand van namespaces kun je makkelijk twee verschillende deployments, deployen.

Met Helm charts kan ik **declaratieve deployments** definiëren. In plaats van handmatig elke configuratie in te stellen, beschrijft het Helm chart op een gestructureerde manier de gewenste staat van de Kubernetes resources. Hierdoor is het eenvoudiger om consistentie te handhaven en reproduceerbare deployments uit te voeren in verschillende omgevingen.

Helm charts bieden een manier om Kubernetes resources templates te maken, waardoor **herbruikbaarheid** wordt bevorderd. Door waarden en parameters in te stellen, kan ik hetzelfde Helm-chart gebruiken voor verschillende omgevingen, zoals ontwikkeling, testen en productie. Dit minimaliseert duplicatie van configuratie en vergemakkelijkt het beheer van meerdere omgevingen.

- **Bestanden**
\
![ingress](https://i.ibb.co/6y7PhVb/helmfiles.png)
- **Declaratives**![ingress](https://i.ibb.co/JcHzP87/helmdeclaritives.png)

Via het commando `helm install {naam} .` kun je de Helm chart installeren. Je moet wel in de juiste directory zitten, waar de chart.yaml staat. Je app wordt geinstalleerd op de kubernetes cluster. Via de commando `helm list` worden alle actieve helm charts getoond.  

- **Installatie productie**![ingress](https://i.ibb.co/Gk14BXd/helmchartinstalleren.png)

Ik heb wat aanpassingen gedaan aan de values file door onder andere de environment van 'production 'naar 'test' te veranderen. Ik voerde hetzelfde commando uit om de Helm chart te installeren

- **Installatie test**![ingress](https://i.ibb.co/N2HSDqT/testomgeving.png)

- **Beide apps runnen**![ingress](https://i.ibb.co/ZXykBN7/beideappsrunnen.png)

> [!NOTE]
> reden niet gevonden voor het niet vekrijgen van meer dan 3 publieke IP adressen.

Dus de twee apps draaien in verschillende namespaces. De namespaces kan je meegeven via de parameter `-n {naam_namespace}`.

- **Testen back-ends**![ingress](https://i.ibb.co/6RFbscP/resultaathelm.png)

Om de apps weg te smijten van je cluster kun je dit makkelijk doen met het commando `helm uninstall {naam}`.

## 7. Ansible voor Management
Met Ansible kun je eenvoudig playbooks via SSH uitvoeren op meerdere servers of workernodes met slechts één commando. Dit is fantastisch, want het voorkomt dat je handmatig verbinding moet maken met elke workernode/server en alles handmatig moet instellen.

In mijn K8S opstelling is er sprake van een publiek en privaat netwerk. In het publieke netwerk draaien de loadbalancers en zijn ze toegankelijk via het internet. In het private netwerk draaien alle workernodes en zijn ze niet bereikbaar via het internet. Het probleem is dat ik niet via SSH kan verbinden met mijn workernodes omdat ze zich in een privaat netwerk bevinden. Oracle biedt hiervoor een oplossing aan, namelijk werken met een Bastion service.

![ingress](https://i.ibb.co/PDNbh58/bastion.png)

Hiervoor moet ik een Bastion service aanmaken en vervolgens voor elke workernode een sessie starten. Dit kan handmatig worden gedaan, maar omdat we streven naar zoveel mogelijk automatisering, heb ik dit geïntegreerd in Terraform via de documentatie op de [Terraform registry](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/bastion_bastion). 


- **Tf bastion**
\
![ingress](https://i.ibb.co/pPqGSVR/tf-bastion.png)

- **Tf sessions**![ingress](https://i.ibb.co/V9NMPCP/tf-sessions.png)

- **Bastion & sessions aangemaakt**![ingress](https://i.ibb.co/2Skd2hy/aangemaakt-Bastion.png)

Nu kan ik een SSH-verbinding tot stand brengen met de worker nodes door de Bastion als proxyjump te gebruiken. Hiervoor heb ik in de folder '.ssh' een configbestand gemaakt met de volgende inhoud:

![config](https://i.ibb.co/4TS6D85/config.png)

- **SSH workernodes**![config](https://i.ibb.co/WkBFvG2/sshverbindingworkernodes.png)

Nu ik SSH kan gebruiken, kan Ansible werken. Ik heb eerst Ansible geinstalleerd. Vervolgens heb ik de hosts file van Ansible aangepast via het commando `sudo nano /etc/ansible/hosts`. Ik heb mijn workernodes toegevoegd onder de groep 'workers'.

![hosts](https://i.ibb.co/vm4RPJ2/hostsansible.png)

Vervolgens heb ik een Ansible playbook gemaakt dat de automatische updates aanzet voor de workernodes. 

![hosts](https://i.ibb.co/WgkfJZd/playbook.png)

Ik heb dan eens getest door te pingen en vervolgens een playbook uitgevoerd via het commando `ansible-playbook unattended-upgrades.yml`.

- **Ping**![config](https://i.ibb.co/Gt5M7Tn/ansibleping.png)

- **Uitvoering**
\
![config](https://i.ibb.co/q1zmjvZ/uitvoeringplaybook.png)

## 8. Monitoring
Voor het monitoren heb ik eerst geprobeerd gebruik te maken van een Helm-chart voor Prometheus en Grafana. Helaas slaagde ik er niet in om de Grafana webinterface service als LoadBalancer te configureren. Ondanks enkele aanpassingen in de values file en het downloaden van bestanden van GitHub, bleef het probleem bestaan.

Vervolgens ben ik overgestapt naar Zabbix. Hoewel ik me kan aanmelden bij de [Zabbix webinterface](http://monitor.dawaladeny.eu), kwam ik voor een nieuw obstakel te staan. Het configureren van alles volgens de documentatie vergt meer tijd dan ik momenteel beschikbaar heb.

![zabbix](https://i.ibb.co/h98h1w8/zabbixxxx.png)

## 9. Links

- front-end 
    - http://cloud2.dawaladeny.eu/
    - 141.145.200.146
- back-end 
    - http://cloud.dawaladeny.eu/api/v1/scores
    -  89.168.41.38/api/v1/scores  
- monitor
    - http://monitor.dawaladeny.eu/
    - 141.145.193.24
- Dockerhub
    - https://hub.docker.com/r/denyshabouev/cloud-infra-backend
    - https://hub.docker.com/r/denyshabouev/cloud-infra-frontend
- Orginele app
    - https://avatar2.dawaladeny.eu