class zabbix {
    
  package {"zabbix":
        ensure => installed,
  } 
  package {"zabbix-agent":
        ensure => installed,
  }
  file {"/etc/zabbix/zabbix_agentd.conf":
        content => template("zabbix/zabbix_agentd_conf.erb"),
        ensure  => file,
  }
  service { "zabbix-agent":
        ensure      => running,
        hasstatus   => true,
        enable      => true,
        subscribe   => [ File["/etc/zabbix/zabbix_agentd.conf"] ],
  }

  Package ["zabbix-agent"] -> File["/etc/zabbix/zabbix_agentd.conf"] -> Service["zabbix-agent"]
}
