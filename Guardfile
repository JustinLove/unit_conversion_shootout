require 'guard/guard'

module ::Guard
  class Ruby < ::Guard::Guard
    def start
      run_all
    end

    def run_all
      run_on_change(Watcher.match_files(self, Dir.glob('*.rb')))
    end

    def run_on_change(paths)
      paths.each {|path| system("ruby #{path}")}
    end
  end
end

guard :ruby do
  watch(/bench.*\.rb/)
end
