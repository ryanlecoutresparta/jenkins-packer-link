required_plugins = %w( vagrant-hostsupdater vagrant-berkshelf )
required_plugins.each do |plugin|
    exec "vagrant plugin install #{plugin};vagrant #{ARGV.join(" ")}" unless Vagrant.has_plugin? plugin || ARGV[0] == 'plugin'
end

Vagrant.configure("2") do |config|

  # config.vm.box = "base"

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/xenial64"
    db.vm.provision "chef_solo" do |chef|
      chef.add_recipe "mongodb::default"
    end
  end

  config.vm.define "app" do |app|
    app.vm.box = "ubuntu/xenial64"
    app.vm.provision "chef_solo" do |chef|
      chef.add_recipe "node::default"
    end
  end
end