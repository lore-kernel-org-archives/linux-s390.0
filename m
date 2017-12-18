Return-Path: <sth@linux.vnet.ibm.com>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk (also 4.12 stable)
References: <cdca47a9-05cc-2676-57fe-904ce8ad5fbc@de.ibm.com>
 <20171123182542.GA2680@lst.de>
 <899f1638-cca4-28e6-3225-51505a053d45@de.ibm.com>
 <20171123183232.GA2845@lst.de>
 <92ef1aae-90b5-f14f-390e-bfab97899431@de.ibm.com>
 <419d8565-9cbe-16ac-3d5d-5945098694bc@de.ibm.com>
 <20171127155409.GA6937@lst.de>
 <d0f39408-b697-8d1a-2cce-b833cb8fa118@de.ibm.com>
 <20171204162108.GA12482@lst.de>
 <5ab91c56-b117-f4fa-3049-a4f8a5493155@de.ibm.com>
 <20171206232924.GA16584@lst.de>
From: Stefan Haberland <sth@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 14:56:04 +0100
MIME-Version: 1.0
In-Reply-To: <20171206232924.GA16584@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <0520e469-563b-486c-9ab8-00d8944ffa9d@linux.vnet.ibm.com>
List-Archive: <https://lore.kernel.org/linux-block/>
List-Post: <mailto:linux-block@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <Bart.VanAssche@wdc.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 07.12.2017 00:29, Christoph Hellwig wrote:
> On Wed, Dec 06, 2017 at 01:25:11PM +0100, Christian Borntraeger wrote:
> t > commit 11b2025c3326f7096ceb588c3117c7883850c068    -> bad
>>      blk-mq: create a blk_mq_ctx for each possible CPU
>> does not boot on DASD and
>> commit 9c6ae239e01ae9a9f8657f05c55c4372e9fc8bcc    -> good
>>     genirq/affinity: assign vectors to all possible CPUs
>> does boot with DASD disks.
>>
>> Also adding Stefan Haberland if he has an idea why this fails on DASD and adding Martin (for the
>> s390 irq handling code).
> That is interesting as it really isn't related to interrupts at all,
> it just ensures that possible CPUs are set in ->cpumask.
>
> I guess we'd really want:
>
> e005655c389e3d25bf3e43f71611ec12f3012de0
> "blk-mq: only select online CPUs in blk_mq_hctx_next_cpu"
>
> before this commit, but it seems like the whole stack didn't work for
> your either.
>
> I wonder if there is some weird thing about nr_cpu_ids in s390?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

I tried this on my system and the blk-mq-hotplug-fix branch does not 
boot for me as well.
The disks get up and running and I/O works fine. At least the partition 
detection and EXT4-fs mount works.

But at some point in time the disk do not get any requests.

I currently have no clue why.
I took a dump and had a look at the disk states and they are fine. No 
error in the logs or in our debug entrys. Just empty DASD devices 
waiting to be called for I/O requests.

Do you have anything I could have a look at?
