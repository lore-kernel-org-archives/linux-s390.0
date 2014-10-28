Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <544FFAA7.1060705@de.ibm.com>
Date: Tue, 28 Oct 2014 21:20:55 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
Subject: Re: blk-mq vs cpu hotplug performance (due to percpu_ref_put performance)
References: <544FF00B.8050403@de.ibm.com> <20141028200055.GA8205@htj.dyndns.org>
In-Reply-To: <20141028200055.GA8205@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Kent Overstreet <kmo@daterainc.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 28.10.2014 21:00, schrieb Tejun Heo:
> Hello,
> 
> On Tue, Oct 28, 2014 at 08:35:39PM +0100, Christian Borntraeger wrote:
>> when going from 3.17 to 3.18-rc2 cpu hotplug become horrible slow on some KVM guests on s390
>>
>> I was able to bisect this to
>>
>> commit 9eca80461a45177e456219a9cd944c27675d6512
>> ("Revert "blk-mq, percpu_ref: implement a kludge for SCSI blk-mq stall during probe")
> 
> That removes the earlier kludge to avoid the RCU delay so RCU
> latencies are expected to show up right after; however, the following
> patches implement proper fix for the problem and the latencies
> shouldn't be visible afterwards.
> 
> So, 17497acbdce9 ("blk-mq, percpu_ref: start q->mq_usage_counter in
> atomic mode") should remove the latencies again.  It doesn't?

I have not verified this, but I guess what happens is:
hotplug
-> notify
-> blk_mq_queue_reinit_notify
-> blk_mq_queue_reinit
-> blk_mq_freeze_queue
-> percpu_ref_kill
-> percpu_ref_kill_and_confirm
-> __percpu_ref_switch_to_atomic
-> call_rcu_sched  

for every request queue.
Christian
