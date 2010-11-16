Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 1/7] taskstats: Add new taskstats command
 TASKSTATS_CMD_ATTR_PIDS
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1289909779.1940.26.camel@holzheu-laptop>
References: <20101111170352.732381138@linux.vnet.ibm.com>
	 <20101111170813.527389224@linux.vnet.ibm.com>
	 <1289676005.2109.148.camel@laptop>
	 <1289836380.1916.41.camel@holzheu-laptop>
	 <1289837178.2109.504.camel@laptop>
	 <1289840968.1916.85.camel@holzheu-laptop>
	 <1289841705.2109.513.camel@laptop>
	 <1289909779.1940.26.camel@holzheu-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date: Tue, 16 Nov 2010 13:36:12 +0100
Message-ID: <1289910972.2109.598.camel@laptop>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: holzheu@linux.vnet.ibm.com
Cc: Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Venkatesh Pallipadi <venki@google.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@redhat.com>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 2010-11-16 at 13:16 +0100, Michael Holzheu wrote:

> Ok, thanks. So sched_clock() seems to be a bad idea for our purposes.
> 
> An alternative approach could be to have a global counter for the task
> snapshots, which is increased each time a snapshot is created for
> userspace. In addition to that we had to add a snapshot counter field to
> the task_struct that is set to the current value of the global counter
> each time a task leaves a CPU. Then userspace could ask for all tasks
> that have been active after snapshot number x. In the response userspace
> gets all tasks that have a snapshot number bigger than x together with
> the new snapshot number y that can be used for the next query.
> 
> Still it would be useful to add a timestamp of the creation of the
> taskstats data in the response to userspace for calculating the interval
> time between two snapshots. Would the usage of ktime_get() be valid for
> that purpose?

ktime_get() can be insanely slow, but yes that's an option. Another
option is using local_clock() and living with the fact that it may be
out of sync (up to a jiffy or so) between CPUs.

The advantage of using ktime_get() as opposed to any other clock is that
userspace has access to it as well through:
clock_gettime(CLOCK_MONOTONIC), although that's arguably not too
relevant when all you're interested in is deltas.
