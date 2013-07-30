local class = require("org.xboot.lang.class")
local event = require("org.xboot.event.event")
local display_object = require("org.xboot.display.display_object")

local M = class(display_object)

function M:init(normal, active)
	display_object.init(self)

	self.normal = normal
	self.active = active
	self.focus = false

	self:add_child(self.normal)
	self:add_child(self.active)
	self:update_visual_state(self.focus)

	self:add_event_listener(event.MOUSE_DOWN, self.on_mouse_down, self)
	self:add_event_listener(event.MOUSE_MOVE, self.on_mouse_move, self)
	self:add_event_listener(event.MOUSE_UP, self.on_mouse_up, self)

	self:add_event_listener(event.TOUCHES_BEGIN, self.on_touches_begin, self)
	self:add_event_listener(event.TOUCHES_MOVE, self.on_touches_move, self)
	self:add_event_listener(event.TOUCHES_END, self.on_touches_end, self)
	self:add_event_listener(event.TOUCHES_CANCEL, self.on_touches_cancel, self)
end

function M:on_mouse_down(e)
	if self:hit_test_point(e.msg.x, e.msg.y) then
		self.focus = true
		self:update_visual_state(self.focus)
		e:stop_propagation()
	end
end

function M:on_mouse_move(e)
	if self.focus then
		if not self:hit_test_point(e.msg.x, e.msg.y) then	
			self.focus = false
			self:update_visual_state(self.focus)
		end
		e:stop_propagation()
	end
end

function M:on_mouse_up(e)
	if self.focus then
		self.focus = false
		self:update_visual_state(self.focus)
		self:dispatch_event(event:new("click"))
		e:stop_propagation()
	end
end

function M:on_touches_begin(e)
	if self.focus then
		e:stop_propagation()
	end
end

function M:on_touches_move(e)
	if self.focus then
		e:stop_propagation()
	end
end

function M:on_touches_end(e)
	if self.focus then
		e:stop_propagation()
	end
end

function M:on_touches_cancel(e)
	if self.focus then
		self.focus = false;
		self:update_visual_state(false)
		e:stop_propagation()
	end
end

function M:update_visual_state(state)
	if state then
		self.normal:visible(false)
		self.active:visible(true)
		self.width = self.active.width
		self.height = self.active.height
	else
		self.normal:visible(true)
		self.active:visible(false)
		self.width = self.normal.width
		self.height = self.normal.height
	end
end

return M