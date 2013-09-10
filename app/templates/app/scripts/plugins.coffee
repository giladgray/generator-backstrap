define ['jquery'], ($) ->

  # removes the given class from all elements (optionally within scope selector)
  # and applies it to this element. useful for singleton class, such as .active
  $.fn.takeClass = (targetClass, scope='') ->
    $(scope + " ." + targetClass).removeClass targetClass
    @addClass targetClass

  Handlebars.registerHelper 'first', (context, options) ->
    if context.length then options.fn(context[0])

  Handlebars.registerHelper 'ifLoggedIn', (context, options) ->
    if Parse.User.current() then options.fn(context) else options.inverse(context)

  # quickly add purecss classes to elements. pure-[base]-[classes...]
  Handlebars.registerHelper 'pure', (base, classes..., options) ->
    new Handlebars.SafeString "pure-#{base} " + _.map(classes, (cls) -> "pure-#{base}-#{cls}").join(' ')

  # allows for dynamically choosing which partial to render.
  # {{partial [template] [context]}}
  Handlebars.registerHelper 'partial', (template, context, opts) ->
    partial = Handlebars.partials[template];
    throw "partial template '#{template}' not found" unless partial
    # execute selected partial against context and make it safe
    new Handlebars.SafeString(partial(context))
