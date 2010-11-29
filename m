Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20101129164237.522034198@linux.vnet.ibm.com>
Date: Mon, 29 Nov 2010 17:42:37 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v2 0/4] taskstats: Improve cumulative time accounting
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Roland McGrath <roland@redhat.com>, Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Version 2
---------
* Integrate review comments (see change log of single patches)
* Add sysctl to switch to new behavior instead of adding the
  additional cdata_acct to struct signal (see patch 3)

Due to POSIX POSIX.1-2001, the CPU time of processes is not accounted
to the cumulative time of the parents, if the parents ignore SIGCHLD
or have set SA_NOCLDWAIT. This behaviour has the major drawback that
it is not possible to calculate all consumed CPU time of a system by
looking at the current tasks. CPU time can be lost.

This patch series adds a new sysctl "full_cdata" that allows to switch
the kernel to a mode where also the missing data is accounted to the
cumulative counters.

PATCH SET OVERVIEW
------------------
Patches apply on:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

[1] Introduce "struct cdata"
[2] Introduce __account_cdata() function
[3] Introduce kernel.full_cdata sysctl
[4] Export "cdata_wait" CPU times with taskstats
