module Dynamic53
  class Cli
    
    def self.start(params)
      new(params)
    end
    
    attr_accessor :user, :hostname, :update_hostname, :local_ip, :route53, :zone, :record
    
    def initialize(params)
      @user = params[0]
      @hostname = params[1]
      @update_hostname = params[2] ? params[2] : stringify_computer
      update_dns 
    end
    
    def update_dns
      if record
        record.update(nil,nil,nil,[local_ip])
      else
        create_record
      end
    end
    
    private
    
    def create_record
      record = Route53::DNSRecord.new("#{update_hostname}.#{hostname}.","CNAME","60",[local_ip], zone)
      record.create
    end
    
    def stringify_computer
      `/usr/sbin/scutil --get ComputerName`.chomp.downcase.gsub(" ", "-").gsub(/[^a-z0-9]/i, "")
    end
    
    def record
      @record ||= zone.get_records("CNAME").select {|r| r.name =~ /#{update_hostname}/ }.first
    end
    
    def zone
      @zone ||= route53.get_zones(hostname).first
    end
    
    def route53
      conf = File.read("/Users/#{user}/.dynamic53").split(',')
      @route53 ||= Route53::Connection.new(conf.first.chomp, conf.last.chomp)
    end
    
    def local_ip
      @local_ip ||= `/usr/bin/curl -s curlmyip.com`.chomp
    end
    
  end
end