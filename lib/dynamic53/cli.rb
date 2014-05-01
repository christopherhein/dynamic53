module Dynamic53
  class Cli
    
    def self.start(params)
      new(params)
    end
    
    attr_accessor :hostname, :update_hostname, :local_ip, :route53, :zone, :record
    
    def initialize(params)
      @hostname = params[0]
      @update_hostname = params[1] ? params[1] : stringify_computer
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
      `scutil --get ComputerName`.chomp.downcase.gsub(" ", "-").gsub(/[^a-z0-9]/i, "")
    end
    
    def record
      @record ||= zone.get_records("CNAME").select {|r| r.name =~ /#{update_hostname}/ }.first
    end
    
    def zone
      @zone ||= route53.get_zones(hostname).first
    end
    
    def route53
      conf = File.read("#{ENV["HOME"]}/.dynamic53").split(',')
      @route53 ||= Route53::Connection.new(conf.first.chomp, conf.last.chomp)
    end
    
    def local_ip
      @local_ip ||= `curl -s curlmyip.com`.chomp
    end
    
  end
end