Return-Path: <linux-kernel-owner+w=401wt.eu-S1752961AbZCSEZH@vger.kernel.org>
Subject: Re: PROBLEM: relay - stale data copied to user space
From: Tom Zanussi <tzanussi@gmail.com>
In-Reply-To: <1237388848.4084.64.camel@kitka.ibm.com>
References: <1237388848.4084.64.camel@kitka.ibm.com>
Content-Type: text/plain
Date: Wed, 18 Mar 2009 23:19:07 -0500
Message-Id: <1237436347.7834.13.camel@charm-linux>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Peschke <mpeschke@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

On Wed, 2009-03-18 at 16:07 +0100, Martin Peschke wrote:

> 
> This is my theory:
> Timing matters. It's a race caused by improper protection of critical
> sections in a producer-consumer scenario. A bug in the bookkeeping
> allows a reader to read at a position that is just being written to.
> 

It does look consistent with a reader reading an event that's been
reserved but not yet written, or partially written e.g. if an event
being written on one cpu was read by another before the first one
finished.  Can you see if the below patch to blktrace userspace helps?

Or failing that, explicitly using gettid() in place of getpid() in
sched_setaffinity().  Or, failing that, you had mentioned previously
that you would try to reproduce the problem on your laptop - were you
able to do that?  If so, it would help in debugging it further...

Tom

diff --git a/blktrace.c b/blktrace.c
index 26b3afd..656ab7a 100644
--- a/blktrace.c
+++ b/blktrace.c
@@ -610,7 +610,7 @@ static int lock_on_cpu(int cpu)
 
 	CPU_ZERO(&cpu_mask);
 	CPU_SET(cpu, &cpu_mask);
-	if (sched_setaffinity(getpid(), sizeof(cpu_mask), &cpu_mask) < 0)
+	if (sched_setaffinity(0, sizeof(cpu_mask), &cpu_mask) < 0)
 		return errno;
 
 	return 0;
