Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 28 Oct 2014 16:30:40 -0400
From: Tejun Heo <tj@kernel.org>
Subject: Re: blk-mq vs cpu hotplug performance (due to percpu_ref_put
 performance)
Message-ID: <20141028203040.GD8205@htj.dyndns.org>
References: <544FF00B.8050403@de.ibm.com>
 <20141028200055.GA8205@htj.dyndns.org>
 <544FFAA7.1060705@de.ibm.com>
 <20141028202255.GB8205@htj.dyndns.org>
 <544FFC9C.60908@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <544FFC9C.60908@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Kent Overstreet <kmo@daterainc.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Oct 28, 2014 at 09:29:16PM +0100, Christian Borntraeger wrote:
> Am 28.10.2014 21:22, schrieb Tejun Heo:
> > On Tue, Oct 28, 2014 at 09:20:55PM +0100, Christian Borntraeger wrote:
> >> I have not verified this, but I guess what happens is:
> >> hotplug
> >> -> notify
> >> -> blk_mq_queue_reinit_notify
> >> -> blk_mq_queue_reinit
> >> -> blk_mq_freeze_queue
> >> -> percpu_ref_kill
> >> -> percpu_ref_kill_and_confirm
> >> -> __percpu_ref_switch_to_atomic
> >> -> call_rcu_sched  
> > 
> > But call_rcu_sched() wouldn't show up as latency.  It's an async call
> > unlike synchronize_*().
> 
> Right, but
> 
> blk_mq_freeze_queue
> 
> also contains
> 
> wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->mq_usage_counter));
> 
> Isnt that wait_event woken up at the end of the call_rcu_sched?

Yeah, yeah, I was confused.  We just need to initiate the killing for
all mqs at once and then wait for the completions.  Shouldn't be too
difficult to fix.  Will get to it soon.

Thanks.

-- 
tejun
