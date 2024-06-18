LATEST_TAG=`git tag --sort=refname |tail -n 2 |head -n 1`
NEW_TAG=`git tag --sort=refname |tail -n 1`
git log --format='%(trailers:key=Type,valueonly,separator=%x20)%x1c%s [%(trailers:key=Issue,valueonly,separator=,)]' $LATEST_TAG..$NEW_TAG | awk -F "\034" '
    {
        gsub(/\[\]$/, "", $2);
        if (length($1) == 0) $1="";
        if (!($1 in item_count)) item_count[$1]=0;
        items[$1, item_count[$1]]=$2;
        item_count[$1]++;
    }
    END {
        for (k in item_count) {
            print k;
            k2=k;
            gsub(/./, "-", k2);
            print k2
            for (i=0; i<item_count[k]; i++) print "* "items[k, i];
            print ""
        }
    }'