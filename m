Return-Path: <linux-kernel-owner+w=401wt.eu-S965483AbXDNKJv@vger.kernel.org>
Subject: [RFC] [Patch 0/4] timer_stats slimmed down
From: Martin Peschke <mp3@de.ibm.com>
Content-Type: text/plain
Date: Sat, 14 Apr 2007 12:09:47 +0200
Message-Id: <1176545387.5462.108.camel@dix>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-s390@vger.kernel.org, tglx@timesys.com, d.pensator@gmail.com, mingo@redhat.com
List-ID: <linux-s390.vger.kernel.org>

2.6.21-rc* kernels come with a feature that adds timer statistics
to /proc/timer_stats (CONFIG_TIMER_STATS). This patch set makes it use
the proposed statistics infrastructure (-mm tree), and adds prequisite
functions to the statistics code.

The result are noticeable lines of code savings.
kernel/time/timer_stats.c which comes with several functions which can
be made redundant by using corresponding functions of lib/statistic.c,
that is:

- accounting
- printing output in sequential files
- user interface for switching accounting on/off, reset etc.
- measuring the accounting time
- per-cpu optimisations

Function that were missing in lib/statistics, and which are added by
this patch set, are:

- allow arbitrary keys for statistics entries (e.g. structures)
- allow client to label output of statistics entries (e.g. using keys)

A secondary effect of the patch set is that we won't add another entry
to good old /proc. The statistics infrastructure uses debugfs.

This patch set is a prototype that works for me, but which might allow
for optimisations. Suggestions are welcome.

[Patch 1/4] timer_stats slimmed down: statistics prereq, cleanup
[Patch 2/4] timer_stats slimmed down: statistics prereq, labels
[Patch 3/4] timer_stats slimmed down: statistics prereq, keys
[Patch 4/4] timer_stats slimmed down: using statistics infrastucture

Patch set is against 2.6.21-rc6-mm1 and additionaly requires
"[Patch] statistics: fix sorted list" posted this morning.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
