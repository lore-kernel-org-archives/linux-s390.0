Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbgJaXjA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 31 Oct 2020 19:39:00 -0400
Message-ID: <1f0ef4b832c67dcec1bcc793407e62c58a97904e.camel@redhat.com>
Subject: Re: [PATCH] s390/smp: Move rcu_cpu_starting() earlier
From: Qian Cai <cai@redhat.com>
Date: Sat, 31 Oct 2020 19:38:52 -0400
In-Reply-To: <20201031183725.GA9529@osiris>
References: <20201028182742.13773-1-cai@redhat.com>
         <20201031183725.GA9529@osiris>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 2020-10-31 at 19:37 +0100, Heiko Carstens wrote:
> On Wed, Oct 28, 2020 at 02:27:42PM -0400, Qian Cai wrote:
> > The call to rcu_cpu_starting() in smp_init_secondary() is not early
> > enough in the CPU-hotplug onlining process, which results in lockdep
> > splats as follows:
> > 
> >  WARNING: suspicious RCU usage
> >  -----------------------------
> >  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
> > 
> >  other info that might help us debug this:
> > 
> >  RCU used illegally from offline CPU!
> >  rcu_scheduler_active = 1, debug_locks = 1
> >  no locks held by swapper/1/0.
> > 
> >  Call Trace:
> >  show_stack+0x158/0x1f0
> >  dump_stack+0x1f2/0x238
> >  __lock_acquire+0x2640/0x4dd0
> >  lock_acquire+0x3a8/0xd08
> >  _raw_spin_lock_irqsave+0xc0/0xf0
> >  clockevents_register_device+0xa8/0x528
> >  init_cpu_timer+0x33e/0x468
> >  smp_init_secondary+0x11a/0x328
> >  smp_start_secondary+0x82/0x88
> > 
> > This is avoided by moving the call to rcu_cpu_starting up near the
> > beginning of the smp_init_secondary() function. Note that the
> > raw_smp_processor_id() is required in order to avoid calling into
> > lockdep before RCU has declared the CPU to be watched for readers.
> > 
> > Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
> > Signed-off-by: Qian Cai <cai@redhat.com>
> > ---
> >  arch/s390/kernel/smp.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Could you provide the config you used? I'm wondering why I can't
> reproduce this even though I have lot's of debug options enabled.
https://cailca.coding.net/public/linux/mm/git/files/master/s390.config

Essentially, I believe it requires CONFIG_PROVE_RCU_LIST=y. Also, it occurs to
me that this only starts to happen after the commit mentioned in the above link.
