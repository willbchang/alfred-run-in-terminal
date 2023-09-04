def increase_tty_number(tty)
  old_tty_number = tty[/\d+$/]
  incremented_tty_number = (old_tty_number.to_i + 1).to_s.rjust(old_tty_number.length, '0')
  tty.sub(old_tty_number, incremented_tty_number)
end

def get_last_process(tty)
  tty = increase_tty_number(tty)
  print `ps -t #{tty} -o command= | tail -n 1`
end

get_last_process(ARGV[0])
