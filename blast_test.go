package main

import (
	"testing"
)

func TestParseValidHeaderFlag(t *testing.T) {
	match, err := parseInputWithRegexp("X-Something: !Y10K:;(He@poverflow?)", headerRegexp)
	if err != nil {
		t.Errorf("parseInputWithRegexp errored: %v", err)
	}
	if got, want := match[1], "X-Something"; got != want {
		t.Errorf("got %v; want %v", got, want)
	}
	if got, want := match[2], "!Y10K:;(He@poverflow?)"; got != want {
		t.Errorf("got %v; want %v", got, want)
	}
}

func TestParseInvalidHeaderFlag(t *testing.T) {
	_, err := parseInputWithRegexp("X|oh|bad-input: badbadbad", headerRegexp)
	if err == nil {
		t.Errorf("Header parsing errored; want no errors")
	}
}

func TestParseValidAuthFlag(t *testing.T) {
	match, err := parseInputWithRegexp("_coo-kie_:!!bigmonster@1969sid", authRegexp)
	if err != nil {
		t.Errorf("A valid auth flag was not parsed correctly: %v", err)
	}
	if got, want := match[1], "_coo-kie_"; got != want {
		t.Errorf("got %v; want %v", got, want)
	}
	if got, want := match[2], "!!bigmonster@1969sid"; got != want {
		t.Errorf("got %v; want %v", got, want)
	}
}

func TestParseInvalidAuthFlag(t *testing.T) {
	_, err := parseInputWithRegexp("X|oh|bad-input: badbadbad", authRegexp)
	if err == nil {
		t.Errorf("Header parsing errored; want no errors")
	}
}

func TestParseAuthMetaCharacters(t *testing.T) {
	_, err := parseInputWithRegexp("plus+$*{:boom", authRegexp)
	if err != nil {
		t.Errorf("Auth header with a plus sign in the user name errored: %v", err)
	}
}
