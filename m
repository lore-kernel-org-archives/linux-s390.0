Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727967AbgJaShj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 31 Oct 2020 14:37:39 -0400
Date: Sat, 31 Oct 2020 19:37:25 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] s390/smp: Move rcu_cpu_starting() earlier
Message-ID: <20201031183725.GA9529@osiris>
References: <20201028182742.13773-1-cai@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028182742.13773-1-cai@redhat.com>
List-ID: <linux-s390.vger.kernel.org>
To: Qian Cai <cai@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:27:42PM -0400, Qian Cai wrote:
> The call to rcu_cpu_starting() in smp_init_secondary() is not early
> enough in the CPU-hotplug onlining process, which results in lockdep
> splats as follows:
> 
>  WARNING: suspicious RCU usage
>  -----------------------------
>  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
> 
>  other info that might help us debug this:
> 
>  RCU used illegally from offline CPU!
>  rcu_scheduler_active = 1, debug_locks = 1
>  no locks held by swapper/1/0.
> 
>  Call Trace:
>  show_stack+0x158/0x1f0
>  dump_stack+0x1f2/0x238
>  __lock_acquire+0x2640/0x4dd0
>  lock_acquire+0x3a8/0xd08
>  _raw_spin_lock_irqsave+0xc0/0xf0
>  clockevents_register_device+0xa8/0x528
>  init_cpu_timer+0x33e/0x468
>  smp_init_secondary+0x11a/0x328
>  smp_start_secondary+0x82/0x88
> 
> This is avoided by moving the call to rcu_cpu_starting up near the
> beginning of the smp_init_secondary() function. Note that the
> raw_smp_processor_id() is required in order to avoid calling into
> lockdep before RCU has declared the CPU to be watched for readers.
> 
> Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
> Signed-off-by: Qian Cai <cai@redhat.com>
> ---
>  arch/s390/kernel/smp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Could you provide the config you used? I'm wondering why I can't
reproduce this even though I have lot's of debug options enabled.

I will apply it anyway after rc2 has been released, just curious.
