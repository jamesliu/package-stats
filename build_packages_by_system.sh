packages=$(curl -s 'https://bayjarvis.com/content.json?sql=select+group_concat(substr(nameWithOwner%2C+instr(nameWithOwner%2C+%27%2F%27)+%2B+1)%2C+%27+%27)+from+datasette_repos%0D%0Awhere+nameWithOwner+!%3D+%27jamesliu%2Fbayjarvis-app%27&_shape=arrayfirst' | jq '.[0]' -r)
mkdir -p packages-by-system
for package in $packages
do
    curl -s https://pypistats.org/api/packages/$package/system | jq "." > packages-by-system/$package.json
    head -n 17 packages-by-system/$package.json
    sleep 20
done
# And run the original script
#eval "python fetch_stats.py stats.json --verbose --sleep 20 datasette sqlite-utils $packages"
eval "python fetch_stats.py stats.json --verbose --sleep 20 $packages"
