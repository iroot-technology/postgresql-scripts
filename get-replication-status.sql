SELECT 
    slot.slot_name,
    slot.slot_type, 
    slot.active,
    stat.state, 
    stat.sync_state,
/*
    pg_current_wal_lsn() AS current_lsn,
    stat.sent_lsn,
    stat.write_lsn,
    stat.flush_lsn,
    stat.replay_lsn,
    stat.write_lag,
    stat.flush_lag,
*/
    stat.replay_lag,
    pg_size_pretty(pg_wal_lsn_diff(pg_current_wal_lsn(),stat.replay_lsn)) AS lag_replication
 FROM pg_replication_slots slot
 LEFT JOIN pg_stat_replication stat ON stat.pid = slot.active_pid 
;