#!/bin/sh

# Origin branches
function origin_branches() {
    git branch -r | grep "origin/" | grep -v "HEAD" | sed 's/origin\///'
}

# Local branches
function local_branches() {
    git branch -l
}

# branch_trees returns a list of all the trees
# for each commit in a branch
function branch_trees() {
    local branch=$1

    git log --format="%T" "${branch}" --
}

# branch_tip_tree returns the tree of the latest commit in a branch
function branch_tip_tree() {
    local branch=$1

    git log --format="%T" -n1 "${branch}" --
}

# merged_in_master returns a list of all local branches already merged into "master"
function merged_in_master() {
    git branch --merged | grep -v "*" | grep -v master | grep -v gh-pages
}

# squased_in_master returns a list of all local branches already squashed into "master"
# it checks if the tree of the commit is present in the master
function squashed_in_master() {
    # Local branches, excluding "master", current branch and "gh-pages"
    local lbranches=$(local_branches | grep -v "*" | grep -v master | grep -v gh-pages)
    local ltrees=$(branch_trees "master")

    for branch in ${lbranches}; do
        local branch_tree=$(branch_tip_tree "${branch}")

        #echo "${branch} - ${branch_tree}"

        echo "${ltrees}" | grep "${branch_tree}" &> /dev/null && echo "${branch}"
    done
}

# non_origin_branches returns a list of local branches
# that do not exist remotely
function non_origin_branches() {
    local obranches=$(origin_branches)
    local lbranches=$(local_branches | grep -v "*" | grep -v master | grep -v gh-pages)

    for branch in ${lbranches}; do
        echo "${obranches}" | grep "${branch}" &> /dev/null || echo "${branch}"
    done
}

function remove_merged() {
    merged_in_master | xargs git branch -d
}

function remove_squashed() {
    squashed_in_master | xargs git branch -D
}

function remove_non_origin() {
    non_origin_branches | xargs git branch -D
}

# Remove unused branches
remove_merged
remove_squashed
remove_non_origin
