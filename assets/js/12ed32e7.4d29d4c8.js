"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[997],{48153:e=>{e.exports=JSON.parse('{"functions":[{"name":"isPending","desc":"Polls the Future and returns ``true`` if the Future is pending.","params":[],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","source":{"line":95,"path":"lib/init.lua"}},{"name":"isReady","desc":"Polls the Future and returns ``true`` if the Future is ready.","params":[],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","source":{"line":107,"path":"lib/init.lua"}},{"name":"output","desc":"If the Future is ready, returns the results ``...T``. Otherwise, returns ``nil``.","params":[],"returns":[{"desc":"","lua_type":"...T?"}],"function_type":"method","source":{"line":119,"path":"lib/init.lua"}},{"name":"output","desc":"When the Result of the Future is ready, calling ``output`` will return a [Result](https://clownxz.github.io/Luau-Future/api/Result).","params":[],"returns":[{"desc":"","lua_type":"Result"}],"function_type":"method","source":{"line":13,"path":"lib/Output.lua"}}],"properties":[],"types":[],"name":"Future","desc":"A Minimal, Typed Future Implementation inspired by the concept of Futures from the Rust Ecosystem.\\n\\n### Creating a Future\\n\\nTo create a Future, call the Library as a function and provide a yielding function as a parameter.\\n```lua\\nlocal Future = require(path.to.module)\\n\\nlocal myFuture = Future(function(...)\\n\\t-- Something that yields\\nend, ...)\\n```\\n\\n### Polling a Future\\n\\nTo check if a Future is ready with it\'s results, you poll it! You can either call ``isReady()`` or ``isPending``\\nto check whether or not the Future is ready.\\n```lua\\n-- Poll the Future to see if it is ready.\\nif myFuture:isReady() then\\n\\t-- Do something\\nend\\n\\n-- Poll the Future to see if it is pending.\\nif myFuture:isPending() then\\n\\t-- Future is still pending!\\nend\\n```\\n\\n### Retrieving Output\\n\\nTo retrieve the Output of a Future, call ``output()`` on the Future when it is ready.\\n```lua\\nif myFuture:isReady() then\\n\\tlocal result = myFuture:output()\\n\\n\\tif result:ok() then\\n\\t\\tlocal a, b, c... = result()\\n\\n\\t\\t-- Do something\\n\\telseif result:error() then\\n\\t\\twarn(result())\\n\\tend\\nend\\n```\\n\\n:::warning\\nIt is important to Poll a Future first instead of just calling ``output()``!\\n\\nYour Future could no longer be Pending but not return anything, in which case\\n``output()`` will return ``nil``.\\n:::","source":{"line":74,"path":"lib/init.lua"}}')}}]);