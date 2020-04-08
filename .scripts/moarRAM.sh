case $1 in
    "loop") loop=true ;;
    *) loop=false ;;
esac
while :; do 
    sync
    echo 3 |sudo tee /proc/sys/vm/drop_caches 
    [ ${loop} = false ] && break
    sleep 30
done>/dev/null
