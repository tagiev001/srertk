!!! ПЕРЕД НАЧАЛОМ НЕОБХОДИМО ПЕРЕНЕСТИ ФАЙЛЫ ИЗ АРХИВА https://drive.google.com/file/d/1JximJBBy-RnKHoi4ZbmnrYdvrU9f8abw/view?usp=sharing 
!!! В ./ansible/playbooks/monitoring
!!! Так сделано, потому что графану без впн не очень удобно качать с интернета, да и остальное из списка раз на 5 при тестах надоело качать
СОДЕРЖИМОЕ АРХИВА:
srertk_deb_and_tar.zip
├── grafana-enterprise_12.3.1_20271043721_linux_amd64.deb
├── node_exporter-1.10.2.linux-amd64.tar.gz
├── prometheus-3.5.1.linux-amd64.tar.gz
└── victoria-metrics-linux-amd64-v1.134.0.tar.gz


backend* - бекэнд
lb* - балансировщики
ansible - ansible
mon - сервер victoriametrics
grafana - grafana

СТРУКТУРА:
srertk
├── ansible
│   ├── Dockerfile
│   ├── playbooks
│   │   ├── ansible.cfg
│   │   ├── backend
│   │   │   ├── configure_backend.yaml
│   │   │   ├── index.html
│   │   │   └── nginx.conf
│   │   ├── inventory.ini
│   │   ├── lb
│   │   │   ├── configure_lb.yaml
│   │   │   ├── configure_master.yaml
│   │   │   ├── configure_nginx.yaml
│   │   │   ├── configure_slave.yaml
│   │   │   ├── kpmaster.conf
│   │   │   ├── kpslave.conf
│   │   │   ├── nginx.conf
│   │   │   └── start_services.yaml
│   │   ├── localhost
│   │   │   └── ssh-keyscan.yaml
│   │   └── monitoring
│   │       ├── add_exporters.yaml
│   │       ├── configure_monitoring.yaml
│   │       ├── exbackend.yaml
│   │       ├── exbasic.yaml
│   │       ├── exlb.yaml
│   │       ├── grafana.ini
│   │       ├── prometheus.yaml
│   │       ├── provisioning
│   │       │   ├── dashboards
│   │       │   │   └── srertk.yaml
│   │       │   └── datasources
│   │       │       └── srertk.yaml
│   │       ├── setup_grafana.yaml
│   │       ├── setup_prometheus.yaml
│   │       ├── setup_victoriametrics.yaml
│   │       └── start.sh
│   └── ssh-keys
│       ├── private
│       │   └── id_rsa
│       └── public
│           └── id_rsa.pub
├── backend1
│   └── Dockerfile
├── backend2
│   └── Dockerfile
├── docker-compose.yml
├── grafana
│   ├── data
│   │   └── srertk.json
│   └── Dockerfile
├── lb1
│   ├── Dockerfile
│   └── keepalived.conf
├── lb2
│   ├── Dockerfile
│   └── keepalived.conf
├── monitoring
│   ├── Dockerfile
│   └── metrics
├── readme.txt
└── sshd_config

тут заранее сгенерирована пара ключей(приватный для ansible, публичных для всех остальных)

Порядок установки
Из директории проекта
docker compose up -d

После старта всех контейнеров
docker exec -it ansible bash


Из ансибл контейнера
	ansible-playbook localhost/ssh-keyscan.yaml узнаем о остальных контейнерах

	Проверяем связность 
	ansible all -i inventory.ini -m ping



	Устанавливаем и стартуем софт
	ansible-playbook backend/configure_backend.yaml
	ansible-playbook lb/configure_lb.yaml
	ansible-playbook monitoring/add_exporters.yaml
	ansible-playbook monitoring/configure_monitoring.yaml
	ansible-playbook monitoring/setup_grafana.yaml

	Проверить работоспособность балансировщиков и бэкэнда
	while true; do curl -s http://172.18.1.1; sleep 1; done #можно и с хоста

	Проверить кому принадлежит VIP
	ansible lb -i inventory.ini -a "ip addr"


Графана доступна по 3000 порту
Предустановлен дашборд(в grafana контейнере /var/lib/grafana/srertk.json) и датасорс(http://mon:8428)


МЕТРИКИ ХРАНЯТЬСЯ ПО ПУТИ
./monitoring/metrics
ДАШБОРДЫ
./grafana/data
КОНФИГИ СОФТОВ И ПРОЧЕЕ
.ansible/playbooks
