REBAR=`which rebar`
DIALYZER=`which dialyzer`
RELX=`which relx`

all: deps compile

deps:
	@$(REBAR) get-deps

compile: deps
	@$(REBAR) compile

release: clean
	@$(RELX) release tar

relup: clean
	@$(RELX) release relup tar

repl:
	_rel/bin/locker

clean:
	@$(RM) -rf deps/
	@$(REBAR) clean

.PHONY: all clean dialyze deps ct
