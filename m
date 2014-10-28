Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <544FF00B.8050403@de.ibm.com>
Date: Tue, 28 Oct 2014 20:35:39 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
Subject: blk-mq vs cpu hotplug performance (due to percpu_ref_put performance)
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Kent Overstreet <kmo@daterainc.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Tejun,

when going from 3.17 to 3.18-rc2 cpu hotplug become horrible slow on some KVM guests on s390

I was able to bisect this to

commit 9eca80461a45177e456219a9cd944c27675d6512
("Revert "blk-mq, percpu_ref: implement a kludge for SCSI blk-mq stall during probe")

Seems that this is due to all the rcu grace periods on percpu_ref_put during the cpu hotplug notifiers.

This is barely noticable on small guests (lets say 1 virtio disk), but on guests with 20 disks a hotplug takes 2 or 3 instead of around 0.1 sec.
There are three things that make this especially noticably on s390:
- s390 has 100HZ which makes grace period waiting slower
- s390 does not yet implement context tracking which would speed up RCU
- s390 systems usually have a bigger amount of disk (e.g. 20 7GB disks instead of one 140GB disks)

Any idea how to improve the situation? I think we could accept an expedited variant on cpu hotplug, since stop_machine_run will cause hickups anyway, but there are probably other callers.


Christian

PS: on the plus side, this makes CPU hotplug races less likely.... 
