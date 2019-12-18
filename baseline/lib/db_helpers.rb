class DbHelpers
  BATCH_SIZE = 10_000

  class << self
    def exec_sql(q)
      ActiveRecord::Base.connection.execute(q)
    end

    def insert(table, fields, groups)
      if groups.blank?
        return
      end
      exec_sql(build_insert_string(table, fields, groups))
    end

    def insert_as_batches(table, fields, groups)
      groups.each_slice(BATCH_SIZE) do |groups_batch|
        insert(table, fields, groups_batch)
      end
    end

    def build_insert_string(table, fields, groups)
      collated = groups.map { |group| "(#{fmt(group)})" }.join(',')
      "INSERT INTO #{table} (#{fields.join(',')}) VALUES #{collated}"
    end

    def fmt(values)
      values.map do |v|
        if v.is_a?(String)
          if v == 'NULL'
            v
          else
            "'#{v}'"
          end
        else
          v
        end
      end.join(',')
    end
  end
end
