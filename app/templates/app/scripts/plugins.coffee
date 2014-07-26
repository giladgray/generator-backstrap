# Add jQuery, Underscore, and Handlebars plugins here!

# removes the given class from all elements (optionally within scope selector)
# and applies it to this element. useful for singleton class, such as .active
$.fn.takeClass = (targetClass, scope='') ->
  $(scope + " ." + targetClass).removeClass targetClass
  @addClass targetClass

# removes the old class and adds the new one
$.fn.swapClass = (oldClass, newClass) ->
  @removeClass(oldClass).addClass(newClass)

# executes block on just the first element of context array
Handlebars.registerHelper 'first', (context, options) ->
  if context.length then options.fn(context[0])

# executes the block iff the user is logged in to Parse
Handlebars.registerHelper 'ifLoggedIn', (context, options) ->
  if Parse.User.current() then options.fn(context) else options.inverse(context)

# allows for dynamically choosing which partial to render.
# {{partial [template] [context]}}
Handlebars.registerHelper 'partial', (template, context, opts) ->
  partial = Handlebars.partials[template];
  throw "partial template '#{template}' not found" unless partial
  # execute selected partial against context and make it safe
  new Handlebars.SafeString(partial(context))
