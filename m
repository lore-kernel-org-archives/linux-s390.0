Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 16 Nov 2010 18:50:44 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC][PATCH v2 5/7] taskstats: Improve cumulative CPU time
	accounting
Message-ID: <20101116175043.GA10693@redhat.com>
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

Hi Michael,

I can't read this discussion today, will try to do tomorrow and reply.
Just one note,

On 11/16, Michael Holzheu wrote:
>
> So you want to have the following three patches:
> * Introduce "struct cdata" + __account_ctime() (no functional change)
> * Add cdata_acct accounting + parallel accounting hierarchy
> * Add taskstats interface to export the data to userspace

Something like this (if possible).

But my main concern is parallel hierarchy itself. So, if you ask me,
I'd prefer to see a separate patch which only adds acct_parent/etc
and implements this reparenting, even without cdata_acct accounting.

Again, if you think this is possible. I understand that it is not
easy to maintain this series,

Oleg.
