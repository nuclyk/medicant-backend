package auth

import (
	"net/http"
	"reflect"
	"testing"
)

func TestGetBearer(t *testing.T) {
	tests := []struct {
		name  string
		input string
		want  string
	}{
		{name: "valid bearer", input: "Bearer xxxxxx", want: "xxxxxx"},
		{name: "no token", input: "Bearer ", want: ""},
		{name: "wrong prefix", input: "bearer ", want: ""},
		{name: "empty header", input: "", want: ""},
	}

	for i, tc := range tests {
		header := http.Header{}
		header.Add("Authorization", tc.input)
		got, _ := GetBearerToken(header)
		if !reflect.DeepEqual(tc.want, got) {
			t.Fatalf("test: %d, name: %s, expected: %v, got: %v", i, tc.name, tc.want, got)
		}
	}
}
