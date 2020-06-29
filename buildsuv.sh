##buildsuv.sh

## open firewall
ufw allow ssh
ufw allow http
ufw allow https
ufw allow 17171/tcp
ufw allow 8091/tcp
ufw enable


## update the os
apt update -y
apt upgrade -y

##setup second disk

## auto config disk and add to FStab
#!/bin/bash
# scan_add_fstab.sh
for i in /sys/class/scsi_device/*
do
  # must be a directory
  [ -d "$i" ] &&  echo "- - -" > "$i/device/rescan"
done
for b in $(lsblk -d | awk '$4=="6G" {print $1}')
do
  # jump to next loop cycle if /dev/$b is in fstab
  grep -q "^[^#]*/dev/$b\>" /etc/fstab && continue
  uuid=$(blkid -s UUID -o value /dev/$b)
  # jump to next loop cycle if its UUID is present and in fstab
  [ -n "$uuid" ] && grep -q "^[^#]*$uuid" /etc/fstab && continue
  # echo -e is discouraged, the echo options can differ between shells
  printf "o\nn\np\n1\n\n\nw\n" | fdisk /dev/$b
  partx -a /dev/$b
  mkfs.ext4 /dev/$b1
  uuid=$(blkid -s UUID -o value /dev/$b)
  echo "UUID=$uuid  /root/abcd  ext4 defaults 0 0" >> /etc/fstab
done

