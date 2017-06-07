local log = require 'log'
local obj = { destroy = function(self) log.info("object destroy: %s",self) end }
local ctxlog = require 'ctx.log'

local M = obj.class({}, 'ctx')

function M:_init(id)
	self.id = tostring(id);
	self.log = ctxlog(self.id)
end

function M:_stringify()
	return self.___name..'#'..self.___id..'/'..self.id
end

function M:suffix(sfx)
	self.log:_prefix(self.id .. '+' .. tostring(sfx))
end

return M
