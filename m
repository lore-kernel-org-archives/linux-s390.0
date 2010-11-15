Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 15 Nov 2010 16:55:21 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC][PATCH v2 5/7] taskstats: Improve cumulative CPU time
 accounting
Message-ID: <20101115165521.21baac60@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <20101113183810.GA9021@redhat.com>
References: <20101111170352.732381138@linux.vnet.ibm.com>
	<20101111170815.404670062@linux.vnet.ibm.com>
	<20101113183810.GA9021@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Venkatesh Pallipadi <venki@google.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 13 Nov 2010 19:38:10 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> First of all, let me repeat, I am not going to discuss whether we need
> these changes or not, I do not know even if I understand your motivation.

Hmm, is the motivation of whole patch series unclear or just the details
in this one? What we want is a low-overhead tool that precisely shows
where the cpu spent its time (or didn't because of steal time). The
granularity target is tenths of microseconds, something that should be
possible with decent hardware. 
What makes life hard is the corner case of a task that has been reparented
to init. That is reason for this complicated secondary accounting structure.

> My only concern is correctness, but

You review effort to improve correctness is very much appreciated. We'll
try to split the patches to make review easier.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
