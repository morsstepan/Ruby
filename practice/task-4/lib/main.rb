require 'chunky_png'
require_relative 'reading_module'
require_relative 'ui_module'
require_relative 'drawing_module'
require_relative 'check_gem_installation'
def main
  CheckGemInstallation.gem_installed?
  UIModule.main_menu
end
main
