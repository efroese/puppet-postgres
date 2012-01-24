# = Define: postgres::backup
#
# Set up a cron job to peridocially back up and zip a postgres db
#
# == Parameters:
#
# $backup_dir:: Where the backups go
#
# $date_format:: Format to send to date to make a timestamp
#
# $minute::     Minute(s) on the hour the cron job will run
#
# $hour::     Hour(s) the cron job will run
#
class postgres::backup::simple ($backup_dir, $date_format='%m%d%Y-%H%M', $hour, $minute) {
     cron { "backup-postgres-${db}":
        command => $date_format ? {
            /''/    => "pg_dump ${name} | gzip > ${backup_dir}/${db}.sql.gz",
            default => "pg_dump ${name} | gzip > ${backup_dir}/${db}.`date +'${date_format}'`.sql.gz",
        },
        user    => 'postgres',
        minute  => $minute,
        hour    => $hour,
    }
}