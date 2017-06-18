# vulcan-scaffolding

*Caution* This is beta software. You will break things by using it in existing projects.

## Requisites

* A Vulcan install
* Bash

## Crash course

```
# Clone a new vulcan instance and go into it
cd mycoolvulcanproject/packages
# Clone the project 
git clone https://github.com/albancrommer/vulcan-scaffolding _scaffolding && cd _scaffolding
# Now, create the "my-awesome-project" package 
./scaffolding.sh package 
# Add to the package an "Ideas" module
./scaffolding.sh --package my-awesome-project module
# Start adding components
./scaffolding.sh --package my-awesome-project component
```
