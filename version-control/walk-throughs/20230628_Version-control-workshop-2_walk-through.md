---
tags: training, aim-rsf
---

## Tutorial :sandwich: :books: 

> **What is this tutorial about?** You are in charge of the upcoming super sandwich survey! You believe this survey has huge potential so you want to share it with everyone.

> :warning: This tutorial is silly and is designed to help you have a few different lightweight test files to start your first interactions with git and GitHub, without being too dependent on a specific programming language. It does not mirror best practises when collecting or logging data!

**Follow along with GitHub and GitHub Desktop as the instructor shares their screen**

```
Alternative command line options will be written in these blocks.
Feel free to ignore them if you are only using GitHub Desktop
```

### 1. GitHub Desktop refresher - repository page

#### On GitHub Desktop

![](https://hackmd.io/_uploads/HkV3cQxO3.png)

#### Or on the command line:

```
# to see if there are unstaged changes
# or staged changes you haven't committed
git status

# to see the history
git log
git log -pretty=oneline

# see the differences between current version and last commit
# if you have unstaged changes
git diff
```

### 2. Publish repository on GitHub

#### On GitHub Desktop

1. Click on `Publish repository`

![](https://hackmd.io/_uploads/B1urqZzd3.png)

2. Untick the `Keep this code private box` and click on `Publish repository`

![](https://hackmd.io/_uploads/HkR2AZMOn.png)

#### Or if you're not using GitHub Desktop:

1. Log in to GitHub
2. Make sure you have SSH set-up. You will need to [check for existing keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/checking-for-existing-ssh-keys#checking-for-existing-ssh-keys), [generate a new one if you don't have one](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key), [add it to GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account#about-addition-of-ssh-keys-to-your-account) and [check that it worked](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection).
3. Create a new repository called sandwich-survey (or whatever you called your repo) and make sure to
    - **not** initialise it with a `README`, `.gitignore`, or `licence` and
    - to initialise the repo as **public**
4. Click on the SSH option from the Quick Setup
5. Navigate to the directory where your repo is
6. Copy the commands from the "...or push an existing repository from the command line"

GitHub repositories are known as the `remote` - you have your local repo on your computer and the remote on GitHub (or other online hosting service).

It is standard practice to name the remote repository `origin`.

### 3. GitHub orientation
There's so much going on!

![](https://hackmd.io/_uploads/Hk2B-1mOn.png)


### 4. Make a change and push the changed file to the remote

Add the sandwich-recipes.md to your project folder and commit the change.

#### On GitHub Desktop

![](https://hackmd.io/_uploads/r1Wi0-m_h.png)


#### On the command line

```
git add sandwich-recipes.md
git commit -m "created sandwich-recipes.md"
git push
```

### 5. Make a change in the remote and pull into the local repo

[make some change]

#### On GitHub Desktop
Fetch the latest changes
![](https://hackmd.io/_uploads/rJTBPlmO2.png)

And pull them into your working directory

![](https://hackmd.io/_uploads/Sy0PwgQ_3.png)

#### On the command line

``` 
git pull
```

### 6. Make a branch

#### On GitHub Desktop

![](https://hackmd.io/_uploads/Hkg-Ub7O2.png)

#### On the command line

```
## create branch "recipe-experiment" from main
git branch recipe-experiment main

# switch to branch "recipe-experiment"
git checkout recipe-experiment        

# see all branches & which one we're on
git branch            
```

### 7. Make a change while on the branch and merge to `main`

Turn the BLT to a BT sandwich

#### On GitHub Desktop

1. Click on the `Current Branch` tab and make sure you're on `main`. Click the `Choose a branch to merge into main` button.


![](https://hackmd.io/_uploads/rkJweG7dn.png)

2. Select the `recipe experiment` branch and click on the `Create a merge commit` button.


![](https://hackmd.io/_uploads/HJBPlMXu3.png)

#### On the command line

```
# to make sure you're on the right branch
git branch

# to merge the recipe-experiment branch into main
git merge recipe-experiment
```

### 8. Make a change while on a branch and publish to GitHub

Make the BT sandwich vegetarian and commit the change to the `recipe-experiment` branch.


#### On GitHub Desktop

![](https://hackmd.io/_uploads/r1-5gywu2.png)

#### On the command line

```
git push -u origin recipe-experiment
```










### 9. Make changes, push branch to GitHub and start a Pull Request

Make changes on a branch that's already on GitHub (or push it to GitHub)


#### On GitHub Desktop

1. Click on the button `Preview Pull Request`

![](https://hackmd.io/_uploads/SJzGxkvOh.png)

2. A wizard will open up. Click on `Create pull request`

![](https://hackmd.io/_uploads/BJr_2kvOh.png)


3. Your browser window will open up with a wizard to open a pull request. Add any additional information, if you want and click on `Create pull request`.

Note that the diffs on this screenshot will be different - I took the screenshot while trying something else out. The actual changes I made to the file don't matter, I'm just trying to show you what the windows that'll pop up will look like.

![](https://hackmd.io/_uploads/S10FO1Ddh.png)

4. Click on `Merge pull request` and `Confirm merge`.

![](https://hackmd.io/_uploads/H1RsOywuh.png)

5. If you want, delete the branch by clicking on `Delete branch`

![](https://hackmd.io/_uploads/SJmTuJwO2.png)

#### On GitHub

Although it's technically possible to start a pull request from the command line, it requires software we haven't installed. See this [StackOverflow question](https://stackoverflow.com/questions/4037928/can-you-issue-pull-requests-from-the-command-line-on-github) for some options if you're interested in doing that.

For this workshop, I'd recommend switching to GitHub.com and starting the pull request from there.

![](https://hackmd.io/_uploads/Hyv5j1w_3.png)

You can then follow along with the steps above, starting at 3.

