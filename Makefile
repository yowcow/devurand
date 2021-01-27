all: rebar/compile

clean:
	rm -rf _build

test: rebar/eunit rebar/ct rebar/dialyzer rebar/xref

rebar/%: REBAR = rebar3
rebar/%:
	$(REBAR) $*
