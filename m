Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 5/7] taskstats: Improve cumulative CPU time
 accounting
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Reply-To: holzheu@linux.vnet.ibm.com
In-Reply-To: <20101113183810.GA9021@redhat.com>
References: <20101111170352.732381138@linux.vnet.ibm.com>
	 <20101111170815.404670062@linux.vnet.ibm.com>
	 <20101113183810.GA9021@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 16 Nov 2010 18:34:40 +0100
Message-ID: <1289928880.1940.116.camel@holzheu-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Venkatesh Pallipadi <venki@google.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hello Oleg,

On Sat, 2010-11-13 at 19:38 +0100, Oleg Nesterov wrote:
> I already asked you to split these changes, perhaps you can do this?
> Say, bacct_add_tsk() looks overcomplicated, the change in copy_process()
> shouldn't introduce the new CLONE_THREAD check, not sure I understand
> why release_task() was chosen for reparenting, other nits...

I want to establish the new hierarchy when a new process is forked and
not for new threads, therefore the check for CLONE_THREAD in
copy_process(). I do the reparenting with reparent_acct() when a process
dies, therefore the check for "group_dead" in exit_signal().

> But it is not easy to discuss these completely different things
> looking at the single patch.
> 
> Imho, it would be much better if you make a separate patch which
> adds acct_parent/etc and implements the parallel hierarchy. This
> also makes sense because it touches the core kernel.
> 
> Personally I think that even "struct cdata" + __account_ctime() helper
> needs a separate patch, and perhaps this change makes sense by itself
> as cleanup. And this way the "trivial" changes (like the changes in
> k_getrusage) won't distract from the functional changes.
>
> The final change should introduce cdata_acct and actually implement
> the complete cumulative accounting.

So you want to have the following three patches:
* Introduce "struct cdata" + __account_ctime() (no functional change)
* Add cdata_acct accounting + parallel accounting hierarchy
* Add taskstats interface to export the data to userspace

Correct?

Michael
