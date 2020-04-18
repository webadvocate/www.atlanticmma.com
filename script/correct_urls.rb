require "fileutils"

def html_files
  Dir.glob("**/*.html")
end

def each_html_file
  html_files.each do |html_file|
    yield html_file
  end
end

def convert_files!
  created_diretory_count = 0
  created_file_count = 0
  files_written_count = 0

  each_html_file do |original_filename|
    next if File.basename(original_filename) == "index.html"

    directory_to_create = File.join(
      File.dirname(original_filename),
      File.basename(original_filename, ".html")
    )

    if !Dir.exist?(directory_to_create)
      puts "Creating directory #{directory_to_create}"
      created_diretory_count += 1
      Dir.mkdir(directory_to_create)
    end

    new_index_file = File.join(directory_to_create, "index.html")

    if !File.exist?(new_index_file)
      puts "Creating file #{new_index_file}"
      created_file_count += 1
      FileUtils.cp(original_filename, new_index_file)
    end

    old_href = %{href="#{original_filename}"}
    new_href = %{href="/#{directory_to_create}/"}.gsub("//", "/")
    each_html_file do |fn|
      original_contents = File.read(fn)
      updated_contents = original_contents.gsub(old_href, new_href)
      if original_contents != updated_contents
        puts "Writing #{fn}"
        files_written_count += 1
        File.write(fn, updated_contents)
      end
    end
  end

  puts "Created #{created_diretory_count} directories"
  puts "Created #{created_file_count} files"
  puts "Updated #{files_written_count} files"
end

def convert_refs!
  each_html_file do |filename|
    original_contents = File.read(filename)
    updated_contents = original_contents.gsub(/\.\.[\.\/]*/, "/")
    updated_contents = updated_contents.gsub(/\.\//, "/")
    updated_contents = updated_contents.gsub(%{"javascripts/}, %{"/javascripts/})
    updated_contents = updated_contents.gsub(%{"stylesheets/}, %{"/stylesheets/})
    updated_contents = updated_contents.gsub(%{"assets/}, %{"/assets/})
    updated_contents = updated_contents.gsub(%{"images/}, %{"/images/})
    updated_contents = updated_contents.gsub(%{"index.html}, %{"/index.html})
    updated_contents = updated_contents.gsub(%{<script src='http://cdn.goroost.com/roostjs/7bc6889c1b38471c93a34a7a5dbd7e64' async></script>}, "")
    if updated_contents != original_contents
      File.write(filename, updated_contents)
    end
  end
end

convert_files!
convert_refs!
