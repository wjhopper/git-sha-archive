# git-sha-archive
Sometimes, it's useful to have a record of the git commit that is associated with a set of files available when you're working with an exported copy of the repository.

`release.sh` is a wrapper around `git archive` that adds a file called `version.txt` containing the SHA1 of the commit being archived to the exported archive. You can then read `version.txt` to know what "version" of a repository the files you have came from when you're in an environment disconnected from your repository, and know what to point in the revision history to compare them to.

This repository also includes scripts/functions for some interpreted languages to read the data in `version.txt`, e.g., `get_version_string.m` for use with MATLAB/Octave. See the source code for each of those files for documentation on how to use them. In general, they are functions that take two parameters: the path to the `version.txt`, and a fallback string to use if the file cannot be found/read.

## Usage
```bash
cd /path/to/git/repo
release.sh
```
### Output
`release.sh` outputs the path to the exported .zip file archive.

## Notes
Tested on Windows using git and bash from [Git for Windows](https://gitforwindows.org/) version 2.13.3.
