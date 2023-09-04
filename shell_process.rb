tty = ARGV[0]
old_tty_number = tty[/\d+$/]
incremented_tty_number = (old_tty_number.to_i + 1).to_s.rjust(old_tty_number.length, '0')
tty = tty.sub(old_tty_number, incremented_tty_number)
print `ps -t #{tty} -o command= | tail -n 1`
