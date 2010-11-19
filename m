Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20101119201108.269346583@linux.vnet.ibm.com>
Date: Fri, 19 Nov 2010 21:11:08 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch 0/4] taskstats: Improve cumulative time accounting
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Due to POSIX POSIX.1-2001, the CPU time of processes is not accounted
to the cumulative time of the parents, if the parents ignore SIGCHLD
or have set SA_NOCLDWAIT. This behaviour has the major drawback that
it is not possible to calculate all consumed CPU time of a system by
looking at the current tasks. CPU time can be lost.

To solve this problem, this patch set duplicates the cumulative accounting
data in the signal_struct. In the second set (cdata_acct) the complete
cumulative resource counters are stored. The new cumulative CPU time (utime
and stime) is then exported via the taskstats interface.

PATCH SET OVERVIEW
------------------
Patches apply on:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

[1] Introduce "struct cdata"
[2] Introduce __account_cdata() function
[3] Introduce cdata_acct for complete cumulative accounting
[4] Export "cdata_acct" with taskstats
