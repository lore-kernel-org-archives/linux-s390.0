Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 18 Nov 2010 17:34:35 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC][PATCH v2 5/7] taskstats: Improve cumulative CPU time
	accounting
Message-ID: <20101118163435.GA3249@redhat.com>
References: <20101111170352.732381138@linux.vnet.ibm.com> <20101111170815.404670062@linux.vnet.ibm.com> <20101113183810.GA9021@redhat.com> <1289928880.1940.116.camel@holzheu-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1289928880.1940.116.camel@holzheu-laptop>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Venkatesh Pallipadi <venki@google.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/16, Michael Holzheu wrote:
>
> On Sat, 2010-11-13 at 19:38 +0100, Oleg Nesterov wrote:
> > I already asked you to split these changes, perhaps you can do this?
> > Say, bacct_add_tsk() looks overcomplicated, the change in copy_process()
> > shouldn't introduce the new CLONE_THREAD check, not sure I understand
> > why release_task() was chosen for reparenting, other nits...
>
> I want to establish the new hierarchy when a new process is forked and
> not for new threads, therefore the check for CLONE_THREAD in
> copy_process().

Yes, but copy_process() already checks CLONE_THREAD many times. No
need to introduce the new check.

> I do the reparenting with reparent_acct() when a process
> dies, therefore the check for "group_dead" in exit_signal().

And it is not clear to me why release_task() is better than
exit_notify().


That said, perhaps I'll understand this reading the next version.
That is why I asked to split.

Oleg.
