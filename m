From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: regression 4.4: deadlock in with cgroup percpu_rwsem
Date: Thu, 21 Jan 2016 10:27:03 +0100
Message-ID: <20160121092703.GF6357@twins.programming.kicks-ass.net>
References: <20160118183205.GW6357@twins.programming.kicks-ass.net>
 <569D3370.6040503@de.ibm.com>
 <20160119095518.GC3528@osiris>
 <569E9032.3070903@de.ibm.com>
 <20160119193845.GT3520@mtj.duckdns.org>
 <20160120070740.GA3395@osiris>
 <569F5E29.3090107@de.ibm.com>
 <20160120103036.GJ6357@twins.programming.kicks-ass.net>
 <20160120105302.GE6373@twins.programming.kicks-ass.net>
 <56A0956D.3010002@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56A0956D.3010002@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Tejun Heo <tj@kernel.org>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 21, 2016 at 09:23:09AM +0100, Christian Borntraeger wrote:

> With Tejuns "cpuset: make mm migration asynchronous" and this hack
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c

> index cfdc0e6..0847bab 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8099,8 +8099,8 @@ void free_fair_sched_group(struct task_group *tg)
>                 if (tg->cfs_rq)
>                         kfree(tg->cfs_rq[i]);
>                 if (tg->se) {
> -                       if (tg->se[i])
> -                               remove_entity_load_avg(tg->se[i]);
> +//                     if (tg->se[i])
> +//                             remove_entity_load_avg(tg->se[i]);
>                         kfree(tg->se[i]);
>                 }
>         }
> 
> things look good now on the scheduler/cgroup front. Thank you for your
> quick responses and answers.

OK, I'll work with TJ on fixing that. Depending on the complexity of
his patch I might just delete those two lines for -stable.

Thanks!
