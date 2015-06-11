Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 2/2] perf: correct event accounting imbalance on error path
Date: Thu, 11 Jun 2015 11:59:05 +0200
Message-Id: <1434016745-17608-2-git-send-email-brueckner@linux.vnet.ibm.com>
In-Reply-To: <1434016745-17608-1-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1434016745-17608-1-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Vince Weaver <vincent.weaver@maine.edu>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

If the perf_event_open() syscall is called for sampling (perf record), but
the selected PMU does not support the sampling, the event is freed.  This
particular free includes a decrement of the perf_sched_events jump label.

However, the accounting which actually increase perf_sched_events is not
yet called and, therefore, triggers a warning in the jump_label code.

On s390, this ends in this warning:

    [ 16.633195] ------------[ cut here ]------------
    [ 16.633196] WARNING: at ../kernel/jump_label.c:82
    [ 16.633197] Modules linked in: eadm_sch nfsd auth_rpcgss oid_registry nfs_acl lockd dm_multipath grace dm_mod sunrpc scsi_dh autofs4
    [ 16.633204] CPU: 0 PID: 539 Comm: perf Not tainted 3.18.3-20150126.0.fdf02cc.31d6da9.fc20.s390xperformance #1
    [ 16.633206] task: 000000000afecec0 ti: 0000000004a94000 task.ti: 0000000004a94000
    [ 16.633207] Krnl PSW : 0704e00180000000 000000000024c6c2 (__static_key_slow_dec+0xfa/0x100)
    [ 16.633214] R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 EA:3
    Krnl GPRS: 0000000000000086 0000000000e39e14 000000000000001b 0000000000000000
    [ 16.633216] 000000000024c6be 0000000000000000 0000000000000000 0000000000000000
    [ 16.633218] 0000000000000000 0000000005d13480 fffffffffffffdf4 0000000000ccac18
    [ 16.633219] 0000000000000064 0000000000ccabf8 000000000024c6be 0000000004a97d58
    [ 16.633227] Krnl Code: 000000000024c6b2: c0200041fd3e larl %r2,a8c12e
    000000000024c6b8: c0e5003292c4 brasl %r14,89ec40
    #000000000024c6be: a7f40001 brc 15,24c6c0
    >000000000024c6c2: a7f4ffb2 brc 15,24c626
    000000000024c6c6: 0707 bcr 0,%r7
    000000000024c6c8: c0f40000000c brcl 15,24c6e0
    000000000024c6ce: c0100055c8ed larl %r1,d058a8
    000000000024c6d4: c0e50033065c brasl %r14,8ad38c
    [ 16.633236] Call Trace:
    [ 16.633238] ([<000000000024c6be>] __static_key_slow_dec+0xf6/0x100)
    [ 16.633240] [<000000000024087c>] _free_event+0x15c/0x198
    [ 16.633241] [<0000000000246e7a>] SyS_perf_event_open+0x432/0xa70
    [ 16.633245] [<00000000008ac5f2>] system_call+0xd6/0x258
    [ 16.633246] [<000003ffaaa784e2>] 0x3ffaaa784e2
    [ 16.633247] Last Breaking-Event-Address:
    [ 16.633249] [<000000000024c6be>] __static_key_slow_dec+0xf6/0x100
    [ 16.633250] ---[ end trace cd0b0e85985e8baa ]---

To solve this problem, just free the event without taking care of the
accounting.

Reported-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 kernel/events/core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4c66465..d9051e0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7965,7 +7965,8 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (is_sampling_event(event)) {
 		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
 			err = -ENOENT;
-			goto err_alloc;
+			__free_event(event);
+			goto err_cpus;
 		}
 	}
 
-- 
1.7.1
