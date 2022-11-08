# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
# ログの出力先を設定
set :output, 'log/cron.log'
# production 環境で cron 実行
set :environment, :production
ENV.each { |k, v| env(k, v) } #追加
every 2.minute do
  begin
    runner "Batch::DataReset.data_reset", :environment => :development
  rescue => e
    Rails.logger.error("aborted rails runner")
    raise e
  end
end