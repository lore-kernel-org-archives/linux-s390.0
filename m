Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [patch 4/4] taskstats: Export "cdata_acct" with taskstats
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Reply-To: holzheu@linux.vnet.ibm.com
In-Reply-To: <20101125132639.GB25836@redhat.com>
References: <20101119201108.269346583@linux.vnet.ibm.com>
	 <20101119201144.871656307@linux.vnet.ibm.com>
	 <20101125132639.GB25836@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 25 Nov 2010 18:21:15 +0100
Message-ID: <1290705675.1941.73.camel@holzheu-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Oleg,

On Thu, 2010-11-25 at 14:26 +0100, Oleg Nesterov wrote:
> On 11/19, Michael Holzheu wrote:
> >
> > From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> >
> > With this patch the (full) cumulative CPU time is added to "struct taskstats".
> > The CPU time is only returned for the thread group leader.
> >
> > ...
> >
> > +	if (tsk->tgid == tsk->pid
> 
> thread_group_leader() ?

Yes, that's better.

> > && lock_task_sighand(tsk, &flags)) {
> 
> Do you really need ->siglock? Starting from 2.6.35 it is always
> safe to access ->signal.

Hmmm, if you say that...

I just did it like it is done in e.g. fs/proc/base.c (proc_pid_limits).
Can we remove the locking there, too?

Michael
