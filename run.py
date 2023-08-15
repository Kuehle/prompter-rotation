def read_first_line(file_path):
    with open(file_path, 'r') as file:
        first_line = file.readline().strip()
    return first_line

def replace_template_variable(template_path, variable, replacement):
    with open(template_path, 'r') as template_file:
        template_content = template_file.read()
    
    updated_content = template_content.replace('%%%', replacement)
    
    with open('index.html', 'w') as index_file:
        index_file.write(updated_content)

def update_lines_file(file_path, line):
    with open(file_path, 'r') as file:
        lines = file.readlines()
    
    with open(file_path, 'w') as file:
        file.writelines(lines[1:])  # Remove first line
    
    with open(file_path, 'a') as file:
        file.write(line + '\n')  # Append line as last line

def main():
    lines_path = 'lines'
    template_path = 'template.html'
    
    today = read_first_line(lines_path)
    replace_template_variable(template_path, '%%%', today)
    update_lines_file(lines_path, today)

if __name__ == "__main__":
    main()
