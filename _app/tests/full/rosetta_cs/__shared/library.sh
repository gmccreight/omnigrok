# To use these functions from the scripts, just do:
# source __shared/library.sh
# In the script you want to use it in.

load_var() {
    eval `grep "^$1=" __generated_config.txt`
}

#User-defined stuff goes below here...
