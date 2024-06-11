{{- define "barbican-conf" }}
[DEFAULT]
host_href={{ .Values.conf.host_href }}

[database]
connection_recycle_time=600

[oslo_messaging_rabbit]
amqp_durable_queues=True
ssl=True

[oslo_policy]
policy_file=/etc/barbican/policy.yaml
enforce_new_defaults=True

[oslo_middleware]
enable_proxy_headers_parsing=True

[keystone_authtoken]
auth_url={{ .Values.conf.keystone.auth_url }}
www_authenticate_uri={{ .Values.conf.keystone.auth_url }}
username={{ .Values.conf.keystone.username }}
project_name={{ .Values.conf.keystone.project_name }}
user_domain_name=Default
project_domain_name=Default
auth_type=password
{{- if .Values.conf.keystone.memcached_servers }}
memcached_servers={{ join "," .Values.conf.keystone.memcached_servers }}
{{- end }}
service_type=key-manager
service_token_roles_required=True

[secretstore]
enable_multiple_secret_stores=False
stores_lookup_suffix=simple_crypto

[secretstore:simple_crypto]
secret_store_plugin=store_crypto
crypto_plugin=simple_crypto
global_default=False

{{- end }}
