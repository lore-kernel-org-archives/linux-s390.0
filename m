Return-Path: <borntraeger@de.ibm.com>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk (also 4.12 stable)
From: Christian Borntraeger <borntraeger@de.ibm.com>
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
 <2257859e-dad6-3356-93a7-e87f02104969@de.ibm.com>
Date: Thu, 14 Dec 2017 18:32:20 +0100
MIME-Version: 1.0
In-Reply-To: <2257859e-dad6-3356-93a7-e87f02104969@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <dbfecfa6-8979-3554-556b-15a1602defa8@de.ibm.com>
List-Archive: <https://lore.kernel.org/linux-block/>
List-Post: <mailto:linux-block@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <Bart.VanAssche@wdc.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Stefan Haberland <sth@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Independent from the issues with the dasd disks, this also seem to not enable
additional hardware queues.

with cpus 0,1 (and 248 cpus max)
I get cpus 0 and 2-247 attached to hardware contect 0 and I get
cpu 1 for hardware context 1. 

If I now add a cpu this does not change anything. hardware context 2,3,4
etc all have no CPU and hardware context 0 keeps sitting on all cpus (except 1).




On 12/07/2017 10:20 AM, Christian Borntraeger wrote:
> 
> 
> On 12/07/2017 12:29 AM, Christoph Hellwig wrote:
>> On Wed, Dec 06, 2017 at 01:25:11PM +0100, Christian Borntraeger wrote:
>> t > commit 11b2025c3326f7096ceb588c3117c7883850c068    -> bad
>>>     blk-mq: create a blk_mq_ctx for each possible CPU
>>> does not boot on DASD and 
>>> commit 9c6ae239e01ae9a9f8657f05c55c4372e9fc8bcc    -> good
>>>    genirq/affinity: assign vectors to all possible CPUs
>>> does boot with DASD disks.
>>>
>>> Also adding Stefan Haberland if he has an idea why this fails on DASD and adding Martin (for the
>>> s390 irq handling code).
>>
>> That is interesting as it really isn't related to interrupts at all,
>> it just ensures that possible CPUs are set in ->cpumask.
>>
>> I guess we'd really want:
>>
>> e005655c389e3d25bf3e43f71611ec12f3012de0
>> "blk-mq: only select online CPUs in blk_mq_hctx_next_cpu"
>>
>> before this commit, but it seems like the whole stack didn't work for
>> your either.
>>
>> I wonder if there is some weird thing about nr_cpu_ids in s390?
> 
> The problem starts as soon as NR_CPUS is larger than the number
> of real CPUs.
> 
> Aquestions Wouldnt your change in blk_mq_hctx_next_cpu fail if there is more than 1 non-online cpu:
> 
> e.g. dont we need something like (whitespace and indent damaged)
> 
> @@ -1241,11 +1241,11 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
>         if (--hctx->next_cpu_batch <= 0) {
>                 int next_cpu;
>  
> +               do  {
>                 next_cpu = cpumask_next(hctx->next_cpu, hctx->cpumask);
> -               if (!cpu_online(next_cpu))
> -                       next_cpu = cpumask_next(next_cpu, hctx->cpumask);
>                 if (next_cpu >= nr_cpu_ids)
>                         next_cpu = cpumask_first(hctx->cpumask);
> +               } while (!cpu_online(next_cpu));
>  
>                 hctx->next_cpu = next_cpu;
>                 hctx->next_cpu_batch = BLK_MQ_CPU_WORK_BATCH;
> 
> it does not fix the issue, though (and it would be pretty inefficient for large NR_CPUS)
> 
> 
