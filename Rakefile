require 'bundler/setup'

desc 'install binstubs for gems'
task :stubs do
  puts %x{ bundle install --binstubs }
end

desc 'trust project .rvmrc file'
task :trust do
  %x{ rvm rvmrc trust .rvmrc }
end

desc 'update exuberant-ctags'
task :etags do
    sh %{etags -R}
end

namespace :vagrant do
  require 'vagrant'
  env = Vagrant::Environment.new

  desc 'initialize new Vagrantfile'
  task :init do
    env.cli('init')
  end

  desc 'start Vagrant box'
  task :up do
    env.cli('up')
  end
end
