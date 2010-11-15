Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 15 Nov 2010 18:59:23 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC][PATCH v2 4/7] taskstats: Add per task steal time
 accounting
Message-ID: <20101115185923.1c353d07@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <1289843441.2109.520.camel@laptop>
References: <20101111170352.732381138@linux.vnet.ibm.com>
	<20101111170815.024542355@linux.vnet.ibm.com>
	<1289677083.2109.167.camel@laptop>
	<20101115155057.15f3be35@mschwide.boeblingen.de.ibm.com>
	<1289833883.2109.494.camel@laptop>
	<20101115184206.4463fd05@mschwide.boeblingen.de.ibm.com>
	<1289843441.2109.520.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Venkatesh Pallipadi <venki@google.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@redhat.com>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "jeremy.fitzhardinge" <jeremy.fitzhardinge@citrix.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 15 Nov 2010 18:50:41 +0100
Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Mon, 2010-11-15 at 18:42 +0100, Martin Schwidefsky wrote:
> > The steal time of a task tells us how much more progress a task could have
> > done if the hypervisor would not steal cpu. Now you could argue that the
> > steal time for a cpu is good enough for that purpose but steal time is not
> > necessarily uniform over all tasks. And we already do calculate this number,
> > we just do not store it right now. 
> 
> If you make the scheduler take steal time into account like Jeremy
> proposed then you schedule on serviced time and the steal time gain is
> proportional to the existing service distribution.
> 
> Still, then you know, then what are you going to do about it? Are you
> going to avoid the hypervisor from scheduling when that one task is
> running?
> 
> What good is knowing something you cannot do anything about.

Steal time per task is at least good for performance problem analysis.
Sometimes knowing what is not the cause of a performance problem can help you
tremendously. If a task is slow and has no steal time, well then the hypervisor
is likely not the culprit. On the other hand if you do see lots of steal time
for a task while the rest of the system doesn't cause any steal time can tell
you something as well. That task might hit a specific function which causes
hypervisor overhead. The usefulness depends on the situation, it is another
data point which may or may not help you.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
