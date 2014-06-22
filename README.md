This small app does one thing, it connects Pivotal Tracker and GitHub to
synchronize your Pull Requests with the state of each story. It is particularly
helpful if your use the [GitHub flow](https://guides.github.com/introduction/flow/index.html)
and consider `master` as always deployable.

If [you have the story id in the branch name](https://github.com/stevenharman/git_tracker), the app will:

- Add a label `pull-request` to the story
- Add a note to the story when the Pull Request is updated (someone pushes on the branch)
- Mark the story as "Finished" when the Pull Request is merged, removing the label.
- Remove the label if the Pull Request is merged

That's it! You can use it right now with the [hosted app](https://mergehook.herokuapp.com)