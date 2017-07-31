[![Build Status](https://www.bitrise.io/app/71b355657125a0fa/status.svg?token=DxdrO43Yc72aIi7DshIvEg&branch=master)](https://www.bitrise.io/app/71b355657125a0fa) [![Codecov](https://img.shields.io/codecov/c/gl/ronanrodrigo/pop-games/master.svg)](https://codecov.io/gl/ronanrodrigo/pop-games) [![codebeat badge](https://codebeat.co/badges/e1368cd4-5e4c-4b54-99e2-00fd8a843741)](https://codebeat.co/projects/gitlab-com-ronanrodrigo-pop-games-master)

# Dependencies
I chose not to use any third-party library to expose how I see the architecture of a software in the big picture. The only third-party dependecy to run local tests.

# Run tests
#### 1. Run bundle install
`bundle install`
#### 2. Execute fastlane
`bundle exec fastlane test`
#### 3. To generate and open coverage report
`bundle exec fastlane test show_coverage:true`
