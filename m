Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 1/2] perf: return ENOENT instead of ENOTSUPP
Date: Thu, 11 Jun 2015 11:59:04 +0200
Message-Id: <1434016745-17608-1-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Vince Weaver <vincent.weaver@maine.edu>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The ENOTSUPP (which actually should be EOPNOTSUPP for user space) does not
trigger a fallback event selection, for example, by perf record.
If hardware support for the cycles perf event is available, but the hardware
does not provide interrupts, returning ENOTSUPP causes perf to end.  Returning
ENOENT causes the perf tool to fallback to a software-based cycle PMU that
supports interrupts.

The commit 53b25335dd ("perf: Disable sampled events if no PMU interrupt")
introduced that incompatible change.

Reported-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 kernel/events/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index eddf1ed..4c66465 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7964,7 +7964,7 @@ SYSCALL_DEFINE5(perf_event_open,
 
 	if (is_sampling_event(event)) {
 		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
-			err = -ENOTSUPP;
+			err = -ENOENT;
 			goto err_alloc;
 		}
 	}
-- 
1.7.1
