require 'active_record'

options = {
    adapter: 'postgresql',
    database: 'movieapp'
}

ActiveRecord::Base.establish_connection(options)