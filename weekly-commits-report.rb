#!/usr/bin/env ruby

require 'rugged'

# path should be the actual .git path from the repo
def fetch(path)
  work_tree = path.gsub(".git", "")
  system( *%W(git --git-dir #{path} --work-tree #{work_tree} fetch) )
end

working_dir = ARGV.shift

abort("Must provide a working directory") unless working_dir

working_glob = File.join(working_dir, "**", ".git")

repo_dirs = Dir.glob(working_glob, File::FNM_DOTMATCH)

repo_dirs.map do |repo_path|
  p "successfully fetched #{repo_path}" if fetch repo_path
end



