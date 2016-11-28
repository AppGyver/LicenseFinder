module LicenseFinder
  class MergedPackage

    attr_reader :dependency

    def initialize(dependency, subproject_paths)
      @dependency = dependency
      @subproject_paths = subproject_paths.map { |p| Pathname(p) }
    end

    def name
      dependency.name
    end

    def version
      dependency.version
    end

    def licenses
      dependency.licenses
    end

    def install_path
      dependency.install_path
    end

    def subproject_paths
      @subproject_paths.map { |p| p.expand_path.to_s }
    end

    def <=>(other)
      dependency <=> other.dependency
    end

    def eql?(other)
      dependency.eql?(other.dependency)
    end

    def hash
      dependency.hash
    end

    def method_missing(method_name, *args)
      # STDERR.puts "WARNING, METHOD MISSING: #{method_name}"
      if dependency.respond_to? method_name
        dependency.send method_name, *args
      else
        nil
      end
    end

    def groups
      dependency.groups
    end

    def parents
      dependency.parents
    end

    def children
      dependency.children
    end

    def approved?
      if dependency.approved?
        true
      else
        #STDERR.puts "WARNING, unapproved shit: #{self.inspect}\n #{dependency.inspect.to_s[0..50]}"
        false
      end
    end

    def approved_manually?
      dependency.approved_manually?
    end

    def whitelisted?
      dependency.whitelisted?
    end

    def homepage
      dependency.homepage
    end

    def summary
      dependency.summary
    end

    def description
      dependency.description
    end

    def decide_on_license(licence)
      dependency.decide_on_license(licence)
    end
  end
end
