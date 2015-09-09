##
# Interpolated Regex Strings

TAGS_LIST = '(a|abbr|address|article|aside|audio|b|bdi|bdo|blockquote|body|button|canvas|caption|cite|code|colgroup|datalist|dd|del|details|dfn|div|dl|dt|em|fieldset|figcaption|figure|footer|form|h1|h2|h3|h4|h5|h6|head|header|hgroup|html|i|iframe|ins|kbd|label|legend|li|main|map|mark|menu|meter|nav|noscript|object|ol|optgroup|option|output|p|pre|progress|q|rp|rt|ruby|s|samp|script|section|select|small|span|strong|style|sub|summary|sup|table|tbody|td|textarea|tfoot|th|thead|time|title|tr|u|ul|var|video)'

ATTRIBUTES = %Q{(( [a-z_0-9-]+=\\\\?("|')[^"']+\\\\?("|')){0,})}

SELF_CLOSING_TAGS_LIST = '(area|base|br|col|command|embed|hr|img|input|keygen|link|meta|param|source|track|wbr)'

##
# Regexes

DOCTYPE = /<!doctype (html|math|svg(:svg)?)( public)?((?!>).){0,}>/i

ROOT = /<html.*<\/html>/m
ROOT_OPENING = /<html.*/
ROOT_CLOSING = /<\/html>/

ANGLE_BRACKETS = /<.*>/

ATTRIBUTE = /([a-z_0-9-]+=\\?("|')[^"']+\\?("|'))/

OPENING_TAG = /<#{TAGS_LIST}#{ATTRIBUTES}>/
CLOSING_TAG = /<\/#{TAGS_LIST}>/

TAG = /<#{TAGS_LIST}#{ATTRIBUTES}>(.*)<\/\1>/
SELF_CLOSING_TAG = /<#{SELF_CLOSING_TAGS_LIST}#{ATTRIBUTES}\/?>/
