Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: [RFC][PATCH 09/10] taskstats: Fix exit CPU time accounting
In-Reply-To: Oleg Nesterov's message of  Monday, 27 September 2010 18:51:33 +0200 <20100927165133.GA23535@redhat.com>
References: <1285249681.1837.28.camel@holzheu-laptop>
	<1285250541.1837.95.camel@holzheu-laptop>
	<20100923171025.GA26623@redhat.com>
	<1285330688.2179.305.camel@holzheu-laptop>
	<20100926181127.GA26985@redhat.com>
	<20100927154257.7910cda3@mschwide.boeblingen.de.ibm.com>
	<20100927165133.GA23535@redhat.com>
Message-Id: <20100929191916.21E1840038@magilla.sf.frob.com>
Date: Wed, 29 Sep 2010 12:19:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Venkatesh Pallipadi <venki@google.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Suresh Siddha <suresh.b.siddha@intel.com>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> > I would consider it to be a BUG() that the time is not accounted.
> > Independent of the fact that a parent wants to see the SIGCHLD and
> > the exit status of its child the process time of the child should be
> > accounted, no?
> 
> I do not know. It doesn't look like a BUG(), I mean it looks as if
> the code was intentionally written this way.

POSIX specifies this behavior: "If the child is never waited for (for
example, if the parent has SA_NOCLDWAIT set or sets SIGCHLD to SIG_IGN),
the resource information for the child process is discarded and not
included in the resource information provided by getrusage()."


Thanks,
Roland
