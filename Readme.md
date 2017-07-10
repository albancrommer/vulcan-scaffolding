The Yeoman version is **FAR** better, please use https://github.com/mechanical-turk/generator-vulcanjs 

Yeoman will give you nice & efficient console manipulation methods for everything Vulcan. 

Go there now ;)

# vulcan-scaffolding

*Caution* This is legacy unmaintained, code: please disregard.

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
./scaffolding.sh --package my-awesome-project --module Ideas component
```
