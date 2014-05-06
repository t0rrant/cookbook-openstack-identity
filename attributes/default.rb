# encoding: UTF-8
#
# Cookbook Name:: openstack-identity
# Recipe:: default
#
# Copyright 2012-2013, AT&T Services, Inc.
# Copyright 2013, Opscode, Inc.
# Copyright 2013, IBM Corp.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Set to some text value if you want templated config files
# to contain a custom banner at the top of the written file
default['openstack']['identity']['custom_template_banner'] = "
# This file autogenerated by Chef
# Do not edit, changes will be overwritten
"

# Adding these as blank
# this needs to be here for the initial deep-merge to work
default['credentials']['EC2']['admin']['access'] = ''
default['credentials']['EC2']['admin']['secret'] = ''

default['openstack']['identity']['verbose'] = 'False'
default['openstack']['identity']['debug'] = 'False'

# Specify a location to retrieve keystone-paste.ini from
default['openstack']['identity']['pastefile_url'] = nil

default['openstack']['identity']['region'] = node['openstack']['region']
default['openstack']['identity']['token']['expiration'] = '86400'

# Logging stuff
default['openstack']['identity']['syslog']['use'] = false
default['openstack']['identity']['syslog']['facility'] = 'LOG_LOCAL2'
default['openstack']['identity']['syslog']['config_facility'] = 'local2'

# RPC attributes
default['openstack']['identity']['control_exchange'] = 'openstack'
default['openstack']['identity']['rpc_thread_pool_size'] = 64
default['openstack']['identity']['rpc_conn_pool_size'] = 30
default['openstack']['identity']['rpc_response_timeout'] = 60
case node['openstack']['mq']['service_type']
when 'rabbitmq'
  default['openstack']['identity']['rpc_backend'] = 'rabbit'
when 'qpid'
  default['openstack']['identity']['rpc_backend'] = 'qpid'
end

default['openstack']['identity']['admin_user'] = 'admin'
default['openstack']['identity']['admin_tenant_name'] = 'admin'

default['openstack']['identity']['users'] = {
  default['openstack']['identity']['admin_user'] => {
    'default_tenant' => default['openstack']['identity']['admin_tenant_name'],
    'roles' => {
      'admin' => ['admin'],
      'KeystoneAdmin' => ['admin'],
      'KeystoneServiceAdmin' => ['admin']
    }
  }
}

# PKI signing. Corresponds to the [signing] section of keystone.conf
# Note this section is only written if node['openstack']['auth']['strategy'] == 'pki'
default['openstack']['identity']['signing']['basedir'] = '/etc/keystone/ssl'
default['openstack']['identity']['signing']['certfile'] = "#{node['openstack']['identity']['signing']['basedir']}/certs/signing_cert.pem"
default['openstack']['identity']['signing']['keyfile'] = "#{node['openstack']['identity']['signing']['basedir']}/private/signing_key.pem"
default['openstack']['identity']['signing']['ca_certs'] = "#{node['openstack']['identity']['signing']['basedir']}/certs/ca.pem"
default['openstack']['identity']['signing']['certfile_url'] = nil
default['openstack']['identity']['signing']['keyfile_url'] = nil
default['openstack']['identity']['signing']['ca_certs_url'] = nil
default['openstack']['identity']['signing']['key_size'] = '2048'
default['openstack']['identity']['signing']['valid_days'] = '3650'
default['openstack']['identity']['signing']['ca_password'] = nil

# These switches set the various drivers for the different Keystone components
default['openstack']['identity']['identity']['backend'] = 'sql'
default['openstack']['identity']['token']['backend'] = 'sql'
default['openstack']['identity']['catalog']['backend'] = 'sql'
default['openstack']['identity']['policy']['backend'] = 'sql'

# LDAP backend general settings
default['openstack']['identity']['ldap']['url'] = 'ldap://localhost'
default['openstack']['identity']['ldap']['user'] = 'dc=Manager,dc=example,dc=com'
default['openstack']['identity']['ldap']['password'] = nil
default['openstack']['identity']['ldap']['suffix'] = 'cn=example,cn=com'
default['openstack']['identity']['ldap']['use_dumb_member'] = false
default['openstack']['identity']['ldap']['allow_subtree_delete'] = false
default['openstack']['identity']['ldap']['dumb_member'] = 'cn=dumb,dc=example,dc=com'
default['openstack']['identity']['ldap']['page_size'] = 0
default['openstack']['identity']['ldap']['alias_dereferencing'] = 'default'
default['openstack']['identity']['ldap']['query_scope'] = 'one'

# LDAP backend user related settings
default['openstack']['identity']['ldap']['user_tree_dn'] = nil
default['openstack']['identity']['ldap']['user_filter'] = nil
default['openstack']['identity']['ldap']['user_objectclass'] = 'inetOrgPerson'
default['openstack']['identity']['ldap']['user_id_attribute'] = 'cn'
default['openstack']['identity']['ldap']['user_name_attribute'] = 'sn'
default['openstack']['identity']['ldap']['user_mail_attribute'] = 'email'
default['openstack']['identity']['ldap']['user_pass_attribute'] = 'userPassword'
default['openstack']['identity']['ldap']['user_enabled_attribute'] = 'enabled'
default['openstack']['identity']['ldap']['user_domain_id_attribute'] = 'businessCategory'
default['openstack']['identity']['ldap']['user_enabled_mask'] = 0
default['openstack']['identity']['ldap']['user_enabled_default'] = 'true'
default['openstack']['identity']['ldap']['user_attribute_ignore'] = 'tenant_id,tenants'
default['openstack']['identity']['ldap']['user_allow_create'] = true
default['openstack']['identity']['ldap']['user_allow_update'] = true
default['openstack']['identity']['ldap']['user_allow_delete'] = true
default['openstack']['identity']['ldap']['user_enabled_emulation'] = false
default['openstack']['identity']['ldap']['user_enabled_emulation_dn'] = nil

# LDAP backend tenant related settings
default['openstack']['identity']['ldap']['tenant_tree_dn'] = nil
default['openstack']['identity']['ldap']['tenant_filter'] = nil
default['openstack']['identity']['ldap']['tenant_objectclass'] = 'groupOfNames'
default['openstack']['identity']['ldap']['tenant_id_attribute'] = 'cn'
default['openstack']['identity']['ldap']['tenant_member_attribute'] = 'member'
default['openstack']['identity']['ldap']['tenant_name_attribute'] = 'ou'
default['openstack']['identity']['ldap']['tenant_desc_attribute'] = 'description'
default['openstack']['identity']['ldap']['tenant_enabled_attribute'] = 'enabled'
default['openstack']['identity']['ldap']['tenant_domain_id_attribute'] = 'businessCategory'
default['openstack']['identity']['ldap']['tenant_attribute_ignore'] = nil
default['openstack']['identity']['ldap']['tenant_allow_create'] = true
default['openstack']['identity']['ldap']['tenant_allow_update'] = true
default['openstack']['identity']['ldap']['tenant_allow_delete'] = true
default['openstack']['identity']['ldap']['tenant_enabled_emulation'] = false
default['openstack']['identity']['ldap']['tenant_enabled_emulation_dn'] = nil

# LDAP backend role related settings
default['openstack']['identity']['ldap']['role_tree_dn'] = nil
default['openstack']['identity']['ldap']['role_filter'] = nil
default['openstack']['identity']['ldap']['role_objectclass'] = 'organizationalRole'
default['openstack']['identity']['ldap']['role_id_attribute'] = 'cn'
default['openstack']['identity']['ldap']['role_name_attribute'] = 'ou'
default['openstack']['identity']['ldap']['role_member_attribute'] = 'roleOccupant'
default['openstack']['identity']['ldap']['role_attribute_ignore'] = nil
default['openstack']['identity']['ldap']['role_allow_create'] = true
default['openstack']['identity']['ldap']['role_allow_update'] = true
default['openstack']['identity']['ldap']['role_allow_delete'] = true

# LDAP backend group related settings
default['openstack']['identity']['ldap']['group_tree_dn'] = nil
default['openstack']['identity']['ldap']['group_filter'] = nil
default['openstack']['identity']['ldap']['group_objectclass'] = 'groupOfNames'
default['openstack']['identity']['ldap']['group_id_attribute'] = 'cn'
default['openstack']['identity']['ldap']['group_name_attribute'] = 'ou'
default['openstack']['identity']['ldap']['group_member_attribute'] = 'member'
default['openstack']['identity']['ldap']['group_desc_attribute'] = 'description'
default['openstack']['identity']['ldap']['group_domain_id_attribute'] = 'businessCategory'
default['openstack']['identity']['ldap']['group_attribute_ignore'] = nil
default['openstack']['identity']['ldap']['group_allow_create'] = true
default['openstack']['identity']['ldap']['group_allow_update'] = true
default['openstack']['identity']['ldap']['group_allow_delete'] = true

# Token flushing cronjob
default['openstack']['identity']['token_flush_cron']['enabled'] = node['openstack']['identity']['token']['backend'] == 'sql'
default['openstack']['identity']['token_flush_cron']['log_file'] = '/var/log/keystone/token-flush.log'
default['openstack']['identity']['token_flush_cron']['hour'] = '*'
default['openstack']['identity']['token_flush_cron']['minute'] = '0'
default['openstack']['identity']['token_flush_cron']['day'] = '*'
default['openstack']['identity']['token_flush_cron']['weekday'] = '*'

# platform defaults
case platform_family
when 'fedora', 'rhel' # :pragma-foodcritic: ~FC024 - won't fix this
  default['openstack']['identity']['user'] = 'keystone'
  default['openstack']['identity']['group'] = 'keystone'
  default['openstack']['identity']['platform'] = {
    'mysql_python_packages' => ['MySQL-python'],
    'db2_python_packages' => ['python-ibm-db', 'python-ibm-db-sa'],
    'postgresql_python_packages' => ['python-psycopg2'],
    'memcache_python_packages' => ['python-memcached'],
    'keystone_packages' => ['openstack-keystone'],
    'keystone_client_packages' => ['python-keystoneclient'],
    'keystone_service' => 'openstack-keystone',
    'keystone_process_name' => 'keystone-all',
    'package_options' => ''
  }
when 'suse'
  default['openstack']['identity']['user'] = 'openstack-keystone'
  default['openstack']['identity']['group'] = 'openstack-keystone'
  default['openstack']['identity']['platform'] = {
    'mysql_python_packages' => ['python-mysql'],
    'postgresql_python_packages' => ['python-psycopg2'],
    'memcache_python_packages' => ['python-python-memcached'],
    'keystone_packages' => ['openstack-keystone'],
    'keystone_client_packages' => ['python-keystoneclient'],
    'keystone_service' => 'openstack-keystone',
    'keystone_process_name' => 'keystone-all',
    'package_options' => ''
  }
when 'debian'
  default['openstack']['identity']['user'] = 'keystone'
  default['openstack']['identity']['group'] = 'keystone'
  default['openstack']['identity']['platform'] = {
    'mysql_python_packages' => ['python-mysqldb'],
    'postgresql_python_packages' => ['python-psycopg2'],
    'memcache_python_packages' => ['python-memcache'],
    'keystone_packages' => ['keystone'],
    'keystone_client_packages' => ['python-keystoneclient'],
    'keystone_service' => 'keystone',
    'keystone_process_name' => 'keystone-all',
    'package_options' => "-o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-confdef'"
  }
end
