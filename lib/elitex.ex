defmodule Elitex do
	require EEx

	def parse_file(filename) do
  parsed_file = EEx.eval_file filename, [by: "\\newline by Martin Karrer"]
  {:ok, file} = File.open filename<>".raw", [:write]
  IO.binwrite file, parsed_file
  File.close file
	end

	def console do 
		filename = IO.gets "Enter Filename to parse: "

		filename 
		|> String.rstrip
		|> parse_file
	end

	def compile_to_pdf(filename) do
		response = System.find_executable("pdflatex")
		case {response} do 
			{nil} ->	IO.puts "pdflatex not found - make sure it is in you $PATH"
			_			->	IO.puts "pdflatex Compiler Found - we will try to compile "
								System.cmd("pdflatex", [filename<>".raw"])
		end 
	end
end
