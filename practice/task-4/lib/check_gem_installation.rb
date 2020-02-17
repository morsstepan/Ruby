# A base module for checking if gem is / is not installed
module CheckGemInstallation
  def self.look(gdep)
    found_gspec = gdep.matching_specs.max_by(&:version)
    found_gspec
  end

  def self.check(gdep)
    found_gspec = look(gdep)
    if found_gspec
      puts "Requirement '#{gdep}' is found"
      puts "It satisfied by #{found_gspec.name}-#{found_gspec.version}"
    else
      puts "Requirement '#{gdep}' not satisfied; installing..."
      reqs_string = gdep.requirements_list.join(', ')
      system('gem', 'install', gem_name, '-v', reqs_string)
    end
  end

  def self.gem_installed?
    gem_name, *gem_ver_reqs = 'chunky_png', '~> 1.3', '>= 1.3.8'
    gdep = Gem::Dependency.new(gem_name, *gem_ver_reqs)
    # look
    check(gdep)
  end
end
