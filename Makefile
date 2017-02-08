PROJECT = emq_mod_presence
PROJECT_DESCRIPTION = Presence Module
PROJECT_VERSION = 2.0.7

DEPS = ecpool brod supervisor3 kafka_protocol snappyer
dep_ecpool = git https://github.com/emqtt/ecpool master
dep_brod = git https://github.com/klarna/brod master
dep_supervisor3 = git https://github.com/klarna/supervisor3 master
dep_kafka_protocol = git https://github.com/klarna/kafka_protocol master
dep_snappyer = git https://github.com/zmstone/snappyer master

BUILD_DEPS= emqttd cuttlefish gpb
dep_emqttd = git https://github.com/emqtt/emqttd master
dep_cuttlefish = git https://github.com/emqtt/cuttlefish
dep_gpb = git https://github.com/tomas-abrahamsson/gpb master

ERLC_OPTS += +'{parse_transform, lager_transform}'

include erlang.mk

app.config::
	./deps/cuttlefish/cuttlefish -l info -e etc/ -c etc/emq_mod_presence.conf -i priv/emq_mod_presence.schema -d data
