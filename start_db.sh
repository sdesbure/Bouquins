mke2fs /dev/ram0
mount /dev/ram0 db/memory
cp db/test.sqlite3 db/memory
chown -R sylvain db/memory
