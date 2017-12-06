Return-Path: <linux-block-owner@vger.kernel.org>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk (also 4.12 stable)
References: <a1d51b13-c034-e0c8-9428-e360b2c898c3@kernel.dk>
 <20171123143453.GA29715@lst.de>
 <cdca47a9-05cc-2676-57fe-904ce8ad5fbc@de.ibm.com>
 <20171123182542.GA2680@lst.de>
 <899f1638-cca4-28e6-3225-51505a053d45@de.ibm.com>
 <20171123183232.GA2845@lst.de>
 <92ef1aae-90b5-f14f-390e-bfab97899431@de.ibm.com>
 <419d8565-9cbe-16ac-3d5d-5945098694bc@de.ibm.com>
 <20171127155409.GA6937@lst.de>
 <d0f39408-b697-8d1a-2cce-b833cb8fa118@de.ibm.com>
 <20171204162108.GA12482@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 6 Dec 2017 13:25:11 +0100
MIME-Version: 1.0
In-Reply-To: <20171204162108.GA12482@lst.de>
Content-Type: text/plain; charset=utf-8
Message-Id: <5ab91c56-b117-f4fa-3049-a4f8a5493155@de.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-block/>
List-Post: <mailto:linux-block@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <Bart.VanAssche@wdc.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Stefan Haberland <sth@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 12/04/2017 05:21 PM, Christoph Hellwig wrote:
> On Wed, Nov 29, 2017 at 08:18:09PM +0100, Christian Borntraeger wrote:
>> Works fine under KVM with virtio-blk, but still hangs during boot in an LPAR.
>> FWIW, the system not only has scsi disks via fcp but also DASDs as a boot disk.
>> Seems that this is the place where the system stops. (see the sysrq-t output
>> at the bottom).
> 
> Can you check which of the patches in the tree is the culprit?


From this branch

    git://git.infradead.org/users/hch/block.git blk-mq-hotplug-fix

commit 11b2025c3326f7096ceb588c3117c7883850c068    -> bad
    blk-mq: create a blk_mq_ctx for each possible CPU
does not boot on DASD and 
commit 9c6ae239e01ae9a9f8657f05c55c4372e9fc8bcc    -> good
   genirq/affinity: assign vectors to all possible CPUs
does boot with DASD disks.

Also adding Stefan Haberland if he has an idea why this fails on DASD and adding Martin (for the
s390 irq handling code).


Some history:
I got this warning
"WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with virtio-blk (also 4.12 stable)"
since 4.13 (and also in 4.12 stable)
on CPU hotplug of previously unavailable CPUs (real hotplug, no offline/online)

This was introduced with 

 blk-mq: Create hctx for each present CPU
    commit 4b855ad37194f7bdbb200ce7a1c7051fecb56a08 

And Christoph is currently working on a fix. The fixed kernel does boot with virtio-blk and
it fixes the warning but it hangs (outstanding I/O) with dasd disks.
