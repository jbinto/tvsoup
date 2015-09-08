# http://subscene.com/subtitles/downton-abbey-first-season/english/522879

cat Downton.Abbey.S01E*.srt | \

  # Strip leading hyphen
  # (e.g. "- First post, ma'am." becomes "First post, ma'am."
  sed 's/^- //' | \

  # Strip dialog leaders
  # (e.g. "DUKE: I really mustn't be late." becomes "I really mustn't be late.")
  sed 's/^[A-Z]*: //' | \

  # Keep only dialog lines. Strips out timecodes.
  # BUG: Mixed dialog like "(CHUCKLING) Ms Bird" are left out. No big loss.
  grep -e '^[a-zA-Z]'

  # TODO: Remove newlines not ending in terminator punctuation [!.?]
  # e.g. 
  #    My lords, ladies and gentlemen,
  #    can I ask for silence?
  # becomes:
  #    My lords, ladies and gentlemen, can I ask for silence?
  # XXX: 
  #  Can't use sed, because sed operates line-wise.
  #  Can't use tr, because tr doesn't support regular expressions. (e.g. tr abc def doesn't change abc to def, it changes a to d, b to e, c to f)
  #  Best bet is ruby one-liner: 
  #   a = File.readlines('foo.txt')
  #   a.each { |x| puts x.gsub(/([^.!?])\n$/, '\1COLLAPSE') }
