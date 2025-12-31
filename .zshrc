battery() {
  acpi 2>/dev/null | grep -o '[0-9]\+%' | head -n1 | sed 's/%/%%/'
}

PROMPT="$(battery) %~ > "
