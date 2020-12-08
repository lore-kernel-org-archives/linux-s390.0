Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbgLHNJq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Dec 2020 08:09:46 -0500
Message-ID: <35ccbf886b1e02323eff96df480c6d5f1123023e.camel@redhat.com>
Subject: Re: store a pointer to the block_device in struct bio (again)
From: Qian Cai <qcai@redhat.com>
Date: Tue, 08 Dec 2020 08:08:10 -0500
In-Reply-To: <20201208110403.GA22179@lst.de>
References: <20201201165424.2030647-1-hch@lst.de>
         <920899710c9e8dcce16e561c6d832e4e9c03cd73.camel@redhat.com>
         <20201208110403.GA22179@lst.de>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, dm-devel@redhat.com, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-s390@vger.kernel.org, linux-block@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>

On Tue, 2020-12-08 at 12:04 +0100, Christoph Hellwig wrote:
> can you send me details of your device mapper setup, e.g. which targets
> are used, are they used on top of whole device or partitions.  Do you
> use partitions on top of the dm devices?  Are any other stacking devices
> involved?

It is a standard RHEL8 installation using "autopart", so I don't think it uses
any particular targets. It is just a plain LVM backed by ahci (sda2 and sdb1.
Some other affected systems use smartpqi/NVM). The kernel has only dm-mirror
enabled but I don't think it uses it anyway.

# grep -i _DM_ .config | grep -v ^#
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_DM_MIRROR=m
CONFIG_DM_UEVENT=y

# lvdisplay
  --- Logical volume ---
  LV Path                /dev/rhel_ibm-p9wr-10/home
  LV Name                home
  VG Name                rhel_ibm-p9wr-10
  LV UUID                ETS2PI-yedc-7AJ6-NUP2-uAYD-6api-bp9nqv
  LV Write Access        read/write
  LV Status              available
  # open                 1
  LV Size                <3.57 TiB
  Current LE             934662
  Segments               2
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           254:2
   
  --- Logical volume ---
  LV Path                /dev/rhel_ibm-p9wr-10/root
  LV Name                root
  VG Name                rhel_ibm-p9wr-10
  LV UUID                ozakb8-2DWE-YBI9-4nnc-gwk8-mMuf-s3EPsB
  LV Write Access        read/write
  LV Status              available
  # open                 1
  LV Size                70.00 GiB
  Current LE             17920
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           254:0

# pvdisplay 
  --- Physical volume ---
  PV Name               /dev/sda2
  VG Name               rhel_ibm-p9wr-10
  PV Size               <1.82 TiB / not usable 4.00 MiB
  Allocatable           yes (but full)
  PE Size               4.00 MiB
  Total PE              476675
  Free PE               0
  Allocated PE          476675
  PV UUID               0Tv2Az-vx7S-HLPd-66Ff-tH6H-dte1-tjSZ7i
   
  --- Physical volume ---
  PV Name               /dev/sdb1
  VG Name               rhel_ibm-p9wr-10
  PV Size               <1.82 TiB / not usable 4.00 MiB
  Allocatable           yes (but full)
  PE Size               4.00 MiB
  Total PE              476931
  Free PE               0
  Allocated PE          476931
  PV UUID               4LfZJN-NxbJ-39OC-VBKP-jv5P-hciK-BOdiML

# lsblk 
NAME                        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda                           8:0    1  1.8T  0 disk 
├─sda1                        8:1    1    1G  0 part /boot
└─sda2                        8:2    1  1.8T  0 part 
  ├─rhel_ibm--p9wr--10-root 254:0    0   70G  0 lvm  /
  └─rhel_ibm--p9wr--10-home 254:2    0  3.6T  0 lvm  /home
sdb                           8:16   1  1.8T  0 disk 
└─sdb1                        8:17   1  1.8T  0 part 
  └─rhel_ibm--p9wr--10-home 254:2    0  3.6T  0 lvm  /home
