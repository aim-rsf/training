---
tags: training, aim-rsf
---

# Workshop 1 walk-through: Introduction to version control

## Tutorial :sandwich: :books: 

You should have downloaded three files to your local machine.

:one: <span style="display: inline">README.md</span>
:two: instructionsssss.txt
:three: new_sandwich_sightings.csv

[You can find these files in this GitHub respository.](https://github.com/aim-rsf/training/tree/main/version-control/super-sandwich-survey)

> **What is this tutorial about?** You are in charge of the upcoming super sandwich survey! You are getting files ready on your computer locally, before sharing them with othes at a later date. You are writing a README file to explain to others what the sandwich survey is, a .txt file to give instructions on how to take part, and a .csv file for some simple data input when people observe new sandwiches!

> :warning: This tutorial is silly and is designed to help you have a few different lightweight test files to start your first interactions with git and GitHub, without being too dependent on a specific programming language. It does not mirror best practises when collecting or logging data!

### Follow along with GitHub Desktop as the instructor shares their screen

```
Alternative command line options for git will be written in these coding blocks.
Feel free to ignore them if you are only using GitHub Desktop
```

1. **GitHub Desktop orientation** - welcome page
```
git --version
git config
```
>  [Instructions on how to view and set configuration options.](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup)
2. **Create a new `repository` (repo) in GitHub Desktop**
```
mkdir sandwich-survey
cd sandwich-survey
git init .
```

3. **GitHub Desktop orientation** - What are all the boxes?
```
git status
```
4. **What happened when we created a git repository?**
   - A hidden folder named `.git` was created 
   - Let's find it on your computer! Go into the new folder you made:
     - On Mac: In Finder, press these 3 keys: *[Cmd] [shift] [ . ]* 
     - Windows: In File Explorer, View > Show > Hidden items.
```
ls -a 
```
5. **Let's add some files to the newly created folder** 
   - Review the 3 files we are going to add 
   - Drag files into the folder - note how GitHub Desktop changes
   - See the symbol that indicates 'New file'
```
cp /path-to-tutorial-files/README.md ./
cp /path-to-tutorial-files/instructionsssss.txt ./
cp /path-to-tutorial-files/new_sandwich_sightings.csv ./
git status
git add README.md instructionsssss.txt new_sandwich_sightings.csv
git status
```
6. **Write a message to tell git to start paying attention to these 3 starting files: our first snapshot**
   - Check the box next to the 3 files are ticked (this means the files are `staged`)
   - Write a`commit` message

```
git commit -m 'starting files'
git status
```

7. **Edit an existing file & `commit` change**
    - Cannot edit within the GitHub Desktop app: use text editor of choice
    - Improve descriptions for column headers (e.g., Location)
```
git status
git add instructionsssss.txt
git status
git commit -m 'improved column description for location'
git status
```

> Consider the [git diff](https://git-scm.com/docs/git-diff) command to visualise differences along the way
8. **Rename a file & `commit` change**
     - txt file is spelt incorrectly

```
git mv instructionsssss.txt instructions.txt
ls
git status
git commit -m 'corrected file name'
git status 
```
9. **View the `branch` history tab** for changes we've made so far
    - See the history tab to `checkout` previous `commits`
    - Note: 
      - The commit message
      - The time the commit was created
      - The committer's username and profile photo (if available)
      - The commit's SHA-1 hash (the unique ID)
```
git log
```
> Try 'q' to exit git text output
> Try 'Ctrl + C' to cancel current terminal command
```
git log --pretty=oneline
git log --pretty=format:"%h - %an, %ar : %s"
```
10. **Add a new file & `commit` change**
    - Add a file called 'more_instructions.txt' (blank or with content)
```
touch more_instructions.txt
git status
git add more_instructions.txt
git status
git commit -m 'new instruction file'
```
11. **Delete that file & `commit` change**
```
git rm more_instructions.txt
git status 
git commit -m 'delete new instruction file'
```
12. **Discard a change made to a file**
    - Add some random letters to instructions.txt simulating an accidental edit
```
git
git restore --staged instructions.txt (if staged)
git restore instructions.txt 
```
13. ==**Break/Questions**== moving on to edit multiple files ...
14. **Edit 2 files at the same time - one `commit`**
    - Add to the instructions file - 'don't use acronyms for the sandwich name' 
    - Change the part of the .csv file that has the acronym
    - Do one `commit`
```
git status
git add instructions.txt new_sandwich_sightings.csv
git status
git commit -m 'removed acronym for example sandwich and added instruction'
```
15. **Edit 3 files at the same time - two`commits`**
    - Add a whole new row to the csv file with a sandwich you like!
      - Change line 4 of instructions.txt to say 'four' not 'three'
    - Make a change to the README file - up to you!
    - Do two `commits` depending on conceptual grouping
```
git status
git add new_sandwich_sightings.csv instructions.txt
git status
git commit -m 'added a fourth sandwich example'
git status

git add README.md
git status
git commit -m '<describe your change>'
git status
```
16. **View the `branch` history tab again to manage `commits`**
     - Change your *last* `commit` (only do this if you have not pushed to remote!)
       - Amend last commit if you forgot a change / want to edit the message
       - Undo the last commit whilst keeping changes to files (this is a soft`reset`)
     - To change all other previous commits, consider `revert` 
       - When you `revert` to a previous `commit`, the `revert` is also a `commit`. The original `commit `also remains in the repository's history, it does not re-write anything.
       - When you revert multiple `commits`, it's best to revert in order from newest to oldest. If you `revert` `commits` in a different order, you may see `merge conflicts`.

```
git log 

To revert the last commit write:
git revert HEAD  
```
 
    
> **.DS_Store (Mac users only)** 
When you interact with files via Finder, the hidden file '.DS_Store' will likely keep popping up as a new file in GitHub Desktop, and it's annoying! We can either discard these changes (delete the file) or - even better - add it to the `.gitignore` file - a file that includes a list of intentionally untracked files that git should ignore.


## GitHub Desktop annotated

![](https://hackmd.io/_uploads/HkV3cQxO3.png)
