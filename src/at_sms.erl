-module(at_sms).

-export([messaging/1,
         fetch_messages/1,
         fetch_messages/2]).

messaging(#{<<"username">> := Username,
            <<"to">> := To,
            <<"message">> := Message} = Map) ->
    {ok, Url} = application:get_env(at_sms, url),
    {ok, ApiKey} = application:get_env(at_sms, apikey),
    Path = [Url, <<"/version1/messaging">>],
    Body = something,
    shttpc:post(Path, Body, opts(ApiKey)).

fetch_messages(Username) ->
    fetch_messages(Username, 0).

fetch_messages(Username, LastReceivedId) ->
    {ok, Url} = application:get_env(at_sms, url),
    {ok, ApiKey} = application:get_env(at_sms, apikey),
    Query = <<"?username=", Username/binary, "&lastReceivedId=", LastReceivedId/binary>>,
    Path = [Url, <<"/version1/messaging", Query/binary>>],
    shttpc:get(Path, opts(ApiKey)).

opts(ApiKey) ->
    #{headers => #{'Content-Type' => <<"application/json">>,
                   'Accept' => <<"application/json">>,
                   'apiKey' => ApiKey},
      close => true}.