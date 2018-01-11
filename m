Return-Path: <borntraeger@de.ibm.com>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk (also 4.12 stable)
References: <20171123183232.GA2845@lst.de>
 <92ef1aae-90b5-f14f-390e-bfab97899431@de.ibm.com>
 <419d8565-9cbe-16ac-3d5d-5945098694bc@de.ibm.com>
 <20171127155409.GA6937@lst.de>
 <d0f39408-b697-8d1a-2cce-b833cb8fa118@de.ibm.com>
 <20171204162108.GA12482@lst.de>
 <5ab91c56-b117-f4fa-3049-a4f8a5493155@de.ibm.com>
 <20171206232924.GA16584@lst.de>
 <0520e469-563b-486c-9ab8-00d8944ffa9d@linux.vnet.ibm.com>
 <04aff6c6-5c04-a2b5-e886-b747cb51f39e@de.ibm.com>
 <20180111091318.GA13969@ming.t460p>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 11 Jan 2018 12:44:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180111091318.GA13969@ming.t460p>
Content-Type: text/plain; charset="utf-8"
Message-Id: <d2bfccc4-cce6-32d7-265c-b7db7019f378@de.ibm.com>
List-Archive: <https://lore.kernel.org/linux-block/>
List-Post: <mailto:linux-block@vger.kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Stefan Haberland <sth@linux.vnet.ibm.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Bart Van Assche <Bart.VanAssche@wdc.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
Content-Transfer-Encoding: 8bit



On 01/11/2018 10:13 AM, Ming Lei wrote:
> On Wed, Dec 20, 2017 at 04:47:21PM +0100, Christian Borntraeger wrote:
>> On 12/18/2017 02:56 PM, Stefan Haberland wrote:
>>> On 07.12.2017 00:29, Christoph Hellwig wrote:
>>>> On Wed, Dec 06, 2017 at 01:25:11PM +0100, Christian Borntraeger wrote:
>>>> t > commit 11b2025c3326f7096ceb588c3117c7883850c068    -> bad
>>>>>      blk-mq: create a blk_mq_ctx for each possible CPU
>>>>> does not boot on DASD and
>>>>> commit 9c6ae239e01ae9a9f8657f05c55c4372e9fc8bcc    -> good
>>>>>     genirq/affinity: assign vectors to all possible CPUs
>>>>> does boot with DASD disks.
>>>>>
>>>>> Also adding Stefan Haberland if he has an idea why this fails on DASD and adding Martin (for the
>>>>> s390 irq handling code).
>>>> That is interesting as it really isn't related to interrupts at all,
>>>> it just ensures that possible CPUs are set in ->cpumask.
>>>>
>>>> I guess we'd really want:
>>>>
>>>> e005655c389e3d25bf3e43f71611ec12f3012de0
>>>> "blk-mq: only select online CPUs in blk_mq_hctx_next_cpu"
>>>>
>>>> before this commit, but it seems like the whole stack didn't work for
>>>> your either.
>>>>
>>>> I wonder if there is some weird thing about nr_cpu_ids in s390?
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> I tried this on my system and the blk-mq-hotplug-fix branch does not boot for me as well.
>>> The disks get up and running and I/O works fine. At least the partition detection and EXT4-fs mount works.
>>>
>>> But at some point in time the disk do not get any requests.
>>>
>>> I currently have no clue why.
>>> I took a dump and had a look at the disk states and they are fine. No error in the logs or in our debug entrys. Just empty DASD devices waiting to be called for I/O requests.
>>>
>>> Do you have anything I could have a look at?
>>
>> Jens, Christoph, so what do we do about this?
>> To summarize:
>> - commit 4b855ad37194f7 ("blk-mq: Create hctx for each present CPU") broke CPU hotplug.
>> - Jens' quick revert did fix the issue and did not broke DASD support but has some issues
>> with interrupt affinity.
>> - Christoph patch set fixes the hotplug issue for virtio blk but causes I/O hangs on DASDs (even
>> without hotplug).
> 
> Hello,
> 
> This one is a valid use case for VM, I think we need to fix that.
> 
> Looks there is issue on the fouth patch("blk-mq: only select online
> CPUs in blk_mq_hctx_next_cpu"), I fixed it in the following tree, and
> the other 3 patches are same with Christoph's:
> 
> 	https://github.com/ming1/linux.git  v4.15-rc-block-for-next-cpuhot-fix
> 
> gitweb:
> 	https://github.com/ming1/linux/commits/v4.15-rc-block-for-next-cpuhot-fix
> 
> Could you test it and provide the feedback?
> 
> BTW, if it can't help this issue, could you boot from a normal disk first
> and dump blk-mq debugfs of DASD later?

That kernel seems to boot fine on my system with DASD disks.
