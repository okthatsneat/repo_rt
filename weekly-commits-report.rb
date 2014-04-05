#!/usr/bin/env ruby

require 'rugged'

working_dir = ARGV.shift

abort("Must provide a working directory") unless working_dir

working_glob = File.join(working_dir, "**", ".git")

repo_dirs = Dir.glob(working_glob, File::FNM_DOTMATCH)

repos = repo_dirs.map do |repo_path|
  Rugged::Repository.new repo_path
end

repos.each do |repo|
  walker = Rugged::Walker.new(repo)
  walker.push repo.head.target #push the head's commit sha onto the walker
  walker.each { |c| puts c.inspect } # inspect all commits from that down
end

