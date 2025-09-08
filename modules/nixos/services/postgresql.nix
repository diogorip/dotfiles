{
  lib,
  self,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (self.lib) mkServiceOption;

  cfg = config.sys.services.postgresql;
in
{
  options.sys.services.postgresql = mkServiceOption "postgresql" { };

  config = mkIf cfg.enable {
    services.postgresql = {
      enable = true;

      ensureUsers = [
        {
          name = "postgres";
          ensureClauses = {
            superuser = true;
            login = true;
            createrole = true;
            createdb = true;
            replication = true;
          };
        }
      ];

      checkConfig = true;
      enableTCPIP = false;

      settings = {
        max_connections = 100;
        superuser_reserved_connections = 3;
        shared_buffers = "2048 MB";
        work_mem = "32 MB";
        maintenance_work_mem = "320 MB";
        huge_pages = "off";
        effective_cache_size = "3 GB";
        effective_io_concurrency = 100;
        random_page_cost = 1.25;
        shared_preload_libraries = "pg_stat_statements";
        track_io_timing = "on";
        track_functions = "pl";
        wal_level = "replica";
        max_wal_senders = 0;
        synchronous_commit = "on";
        checkpoint_timeout = "15 min";
        checkpoint_completion_target = 0.9;
        max_wal_size = "1024 MB";
        min_wal_size = "512 MB";
        wal_compression = "on";
        wal_buffers = -1;
        wal_writer_delay = "200ms";
        wal_writer_flush_after = "1MB";
        wal_keep_size = "3650 MB";
        bgwriter_delay = "200ms";
        bgwriter_lru_maxpages = 100;
        bgwriter_lru_multiplier = 2.0;
        bgwriter_flush_after = 0;
        max_worker_processes = 4;
        max_parallel_workers_per_gather = 2;
        max_parallel_maintenance_workers = 2;
        max_parallel_workers = 4;
        parallel_leader_participation = "on";
        enable_partitionwise_join = "on";
        enable_partitionwise_aggregate = "on";
        jit = "on";
        log_connections = true;
        log_statement = "all";
        logging_collector = true;
        log_destination = lib.mkForce "syslog";
      };
    };
  };
}
