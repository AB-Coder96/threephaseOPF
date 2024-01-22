import pypandoc

def convert_latex_to_markdown(input_file, output_file):
    try:
        # Convert LaTeX to Markdown
        pypandoc.convert_file(input_file, 'md', format='latex', outputfile=output_file)
        print(f"Conversion successful. Output saved to {output_file}")
    except Exception as e:
        print(f"Conversion failed. Error: {e}")

# Replace 'input.tex' and 'output.md' with your file paths
convert_latex_to_markdown('Main.tex', 'output.md')
