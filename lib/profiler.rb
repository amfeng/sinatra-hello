require 'ruby-prof'

module HelloApp::Profiler
  before do
    RubyProf.start
  end

  after do
    result = RubyProf.stop
    printer = RubyProf::FlatPrinter.new(result)
    printer.print(STDOUT)
  end
end
