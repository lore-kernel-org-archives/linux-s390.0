Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <544FFC9C.60908@de.ibm.com>
Date: Tue, 28 Oct 2014 21:29:16 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
Subject: Re: blk-mq vs cpu hotplug performance (due to percpu_ref_put performance)
References: <544FF00B.8050403@de.ibm.com> <20141028200055.GA8205@htj.dyndns.org> <544FFAA7.1060705@de.ibm.com> <20141028202255.GB8205@htj.dyndns.org>
In-Reply-To: <20141028202255.GB8205@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Kent Overstreet <kmo@daterainc.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Am 28.10.2014 21:22, schrieb Tejun Heo:
> On Tue, Oct 28, 2014 at 09:20:55PM +0100, Christian Borntraeger wrote:
>> I have not verified this, but I guess what happens is:
>> hotplug
>> -> notify
>> -> blk_mq_queue_reinit_notify
>> -> blk_mq_queue_reinit
>> -> blk_mq_freeze_queue
>> -> percpu_ref_kill
>> -> percpu_ref_kill_and_confirm
>> -> __percpu_ref_switch_to_atomic
>> -> call_rcu_sched  
> 
> But call_rcu_sched() wouldn't show up as latency.  It's an async call
> unlike synchronize_*().

Right, but

blk_mq_freeze_queue

also contains

wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->mq_usage_counter));

Isnt that wait_event woken up at the end of the call_rcu_sched?
