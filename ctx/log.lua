local log = require 'log'
local obj = { destroy = function(self) log.info("object destroy: %s",self) end }
local M = obj.class({}, 'ctx.log')

for _,k in pairs({"error","warn","info","debug"}) do
	if log[k] then
		local fun = log[k]
		if k == "warn" then
			M[ k ] = function(self, f, ...)
				fun("[%s]> "..f,self.prefix, ...)
			end
		elseif k == 'error' then
			M[ k ] = function(self, f, ...)
				if self.store then
					for _, log_store in pairs (self.store) do
						local fun_store = log[log_store.name]
						fun_store("[%s]> "..log_store.f,self.prefix,unpack(log_store.params))
					end
					self.store = nil
				end
				fun("[%s]> "..f,self.prefix, ...)
			end
		else
			M[ k ] = function(self, f, ...)
				local params = {...}
				if self.store then
					table.insert(self.store,{
						f      = f;
						params = params;
						name   = k;
						-- time   = os.date("%H:%M:%S");
					})
				else
					fun("[%s]> "..f,self.prefix,...)
				end
			end
		end
	else
		error("Can't find method "..k.." on log")
	end
end

function M:_init(prefix)
	self.store = {}
	self.prefix = tostring(prefix);
end

function M:_prefix( prefix )
	self.prefix = tostring(prefix);
end

return M
