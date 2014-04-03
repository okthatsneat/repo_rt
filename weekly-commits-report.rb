#!/usr/bin/env ruby

# use https://github.com/libgit2/rugged
require 'rugged'

# all dirs under the current path with git repos
repo_dirs = Dir.glob("**/.git", File::FNM_DOTMATCH)

# init rugged objects
repos = repo_dirs.map do |repo_path|
  Rugged::Repository.new repo_path
end

# TODO fetch the latest state


# inspect all commits
repos.each do |repo|
  walker = Rugged::Walker.new(repo)
  walker.push repo.head.target #push the head's commit sha onto the walker
  walker.each { |c| puts c.inspect } # inspect all commits from that down
end

# TODO git log commits on all branches within the last 7 days

# TODO redirect the result into something like an excel sheet /db
# ex git log --since='last month' --pretty=format:'%h,%an,%ar,%s' > log.csv
