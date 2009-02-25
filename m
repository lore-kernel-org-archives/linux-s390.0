Return-Path: <linux-kernel-owner+w=401wt.eu-S1759402AbZBYPQp@vger.kernel.org>
Message-Id: <20090225150837.398862645@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:59 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 37/46] qdio: proper kill of qdio tasklets
Content-Disposition: inline; filename=136-qdio-kill-tasklet.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Glauber <jang@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

The queue tasklets were stopped with tasklet_disable. Although tasklet_disable
prevents the tasklet from beeing executed it is still possible that a tasklet
is scheduled on a CPU at that point. A following qdio_establish calls
tasklet_init which clears the tasklet count and the tasklet state leading to
the following Oops:

    <2>kernel BUG at kernel/softirq.c:392!
    <4>illegal operation: 0001 [#1] SMP
    <4>Modules linked in: iptable_filter ip_tables x_tables dm_round_robin dm_multipath scsi_dh sg sd_mod crc_t10dif nfs lockd nfs
_acl sunrpc fuse loop dm_mod qeth_l3 ipv6 zfcp qeth scsi_transport_fc qdio scsi_tgt scsi_mod chsc_sch ccwgroup dasd_eckd_mod dasdm
od ext3 mbcache jbd
    <4>Supported: Yes
    <4>CPU: 0 Not tainted 2.6.27.13-1.1.mz13-default #1
    <4>Process blast.LzS_64 (pid: 16445, task: 000000006cc02538, ksp: 000000006cb67998)
    <4>Krnl PSW : 0704c00180000000 00000000001399f4 (tasklet_action+0xc8/0x1d4)
    <4>           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 EA:3
    <4>Krnl GPRS: ffffffff00000030 0000000000000002 0000000000000002 fffffffffffffffe
    <4>           000000000013aabe 00000000003b6a18 fffffffffffffffd 0000000000000000
    <4>           00000000006705a8 000000007d0914a8 000000007d0914b0 000000007fecfd30
    <4>           0000000000000000 00000000003b63e8 000000007fecfd90 000000007fecfd30
    <4>Krnl Code: 00000000001399e8: b9200021            cgr     %r2,%r1
    <4>           00000000001399ec: a7740004            brc     7,1399f4
    <4>           00000000001399f0: a7f40001            brc     15,1399f2
    <4>          >00000000001399f4: c0100027e8ee        larl    %r1,636bd0
    <4>           00000000001399fa: bf1f1008            icm     %r1,15,8(%r1)
    <4>           00000000001399fe: a7840019            brc     8,139a30
    <4>           0000000000139a02: c0300027e8ef        larl    %r3,636be0
    <4>           0000000000139a08: e3c030000004        lg      %r12,0(%r3)
    <4>Call Trace:
    <4>([<0000000000139c12>] tasklet_hi_action+0x112/0x1d4)
    <4> [<000000000013aabe>] __do_softirq+0xde/0x1c4
    <4> [<000000000010fa2e>] do_softirq+0x96/0xb0
    <4> [<000000000013a8d8>] irq_exit+0x70/0xcc
    <4> [<000000000010d1d8>] do_extint+0xf0/0x110
    <4> [<0000000000113b10>] ext_no_vtime+0x16/0x1a
    <4> [<000003e0000a3662>] ext3_dirty_inode+0xe6/0xe8 [ext3]
    <4>([<00000000001f6cf2>] __mark_inode_dirty+0x52/0x1d4)
    <4> [<000003e0000a44f0>] ext3_ordered_write_end+0x138/0x190 [ext3]
    <4> [<000000000018d5ec>] generic_perform_write+0x174/0x230
    <4> [<0000000000190144>] generic_file_buffered_write+0xb4/0x194
    <4> [<0000000000190864>] __generic_file_aio_write_nolock+0x418/0x454
    <4> [<0000000000190ee2>] generic_file_aio_write+0x76/0xe4
    <4> [<000003e0000a05c2>] ext3_file_write+0x3e/0xc8 [ext3]
    <4> [<00000000001cc2fe>] do_sync_write+0xd6/0x120
    <4> [<00000000001ccfc8>] vfs_write+0xac/0x184
    <4> [<00000000001cd218>] SyS_write+0x68/0xe0
    <4> [<0000000000113402>] sysc_noemu+0x10/0x16
    <4> [<0000020000043188>] 0x20000043188
    <4>Last Breaking-Event-Address:
    <4> [<00000000001399f0>] tasklet_action+0xc4/0x1d4
    <6>qdio: 0.0.c61b ZFCP on SC f67 using AI:1 QEBSM:0 PCI:1 TDD:1 SIGA: W AOP
    <4> <0>Kernel panic - not syncing: Fatal exception in interrupt

Use tasklet_kill instead of tasklet_disbale. Since tasklet_schedule must not be
called after tasklet_kill use the QDIO_IRQ_STATE_STOPPED to inidicate that a
queue is going down and prevent further tasklet schedules in that case.

Remove superflous tasklet_schedule from input queue setup, at that time
the queues are not ready so the schedule results in a NOP.

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio_main.c    |   35 ++++++++++++++++++++++++-----------
 drivers/s390/cio/qdio_thinint.c |    8 ++++----
 2 files changed, 28 insertions(+), 15 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_main.c
+++ quilt-2.6/drivers/s390/cio/qdio_main.c
@@ -778,21 +778,17 @@ static void __qdio_outbound_processing(s
 
 	spin_unlock_irqrestore(&q->lock, flags);
 
-	if (queue_type(q) == QDIO_ZFCP_QFMT) {
+	if (queue_type(q) == QDIO_ZFCP_QFMT)
 		if (!pci_out_supported(q) && !qdio_outbound_q_done(q))
-			tasklet_schedule(&q->tasklet);
-		return;
-	}
+			goto sched;
 
 	/* bail out for HiperSockets unicast queues */
 	if (queue_type(q) == QDIO_IQDIO_QFMT && !multicast_outbound(q))
 		return;
 
 	if ((queue_type(q) == QDIO_IQDIO_QFMT) &&
-	    (atomic_read(&q->nr_buf_used)) > QDIO_IQDIO_POLL_LVL) {
-		tasklet_schedule(&q->tasklet);
-		return;
-	}
+	    (atomic_read(&q->nr_buf_used)) > QDIO_IQDIO_POLL_LVL)
+		goto sched;
 
 	if (q->u.out.pci_out_enabled)
 		return;
@@ -810,6 +806,12 @@ static void __qdio_outbound_processing(s
 			qdio_perf_stat_inc(&perf_stats.debug_tl_out_timer);
 		}
 	}
+	return;
+
+sched:
+	if (unlikely(q->irq_ptr->state == QDIO_IRQ_STATE_STOPPED))
+		return;
+	tasklet_schedule(&q->tasklet);
 }
 
 /* outbound tasklet */
@@ -822,6 +824,9 @@ void qdio_outbound_processing(unsigned l
 void qdio_outbound_timer(unsigned long data)
 {
 	struct qdio_q *q = (struct qdio_q *)data;
+
+	if (unlikely(q->irq_ptr->state == QDIO_IRQ_STATE_STOPPED))
+		return;
 	tasklet_schedule(&q->tasklet);
 }
 
@@ -863,6 +868,9 @@ static void qdio_int_handler_pci(struct 
 	int i;
 	struct qdio_q *q;
 
+	if (unlikely(irq_ptr->state == QDIO_IRQ_STATE_STOPPED))
+		return;
+
 	qdio_perf_stat_inc(&perf_stats.pci_int);
 
 	for_each_input_queue(irq_ptr, q, i)
@@ -1090,11 +1098,11 @@ static void qdio_shutdown_queues(struct 
 	int i;
 
 	for_each_input_queue(irq_ptr, q, i)
-		tasklet_disable(&q->tasklet);
+		tasklet_kill(&q->tasklet);
 
 	for_each_output_queue(irq_ptr, q, i) {
-		tasklet_disable(&q->tasklet);
 		del_timer(&q->u.out.timer);
+		tasklet_kill(&q->tasklet);
 	}
 }
 
@@ -1125,6 +1133,12 @@ int qdio_shutdown(struct ccw_device *cde
 		return 0;
 	}
 
+	/*
+	 * Indicate that the device is going down. Scheduling the queue
+	 * tasklets is forbidden from here on.
+	 */
+	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_STOPPED);
+
 	tiqdio_remove_input_queues(irq_ptr);
 	qdio_shutdown_queues(cdev);
 	qdio_shutdown_debug_entries(irq_ptr, cdev);
@@ -1556,7 +1570,6 @@ static void handle_outbound(struct qdio_
 		qdio_perf_stat_inc(&perf_stats.fast_requeue);
 	}
 out:
-	/* Fixme: could wait forever if called from process context */
 	tasklet_schedule(&q->tasklet);
 }
 
Index: quilt-2.6/drivers/s390/cio/qdio_thinint.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_thinint.c
+++ quilt-2.6/drivers/s390/cio/qdio_thinint.c
@@ -101,7 +101,6 @@ void tiqdio_add_input_queues(struct qdio
 		list_add_rcu(&q->entry, &tiq_list);
 	mutex_unlock(&tiq_list_lock);
 	xchg(irq_ptr->dsci, 1);
-	tasklet_schedule(&tiqdio_tasklet);
 }
 
 /*
@@ -159,7 +158,6 @@ static void __tiqdio_inbound_processing(
 	 */
 	qdio_check_outbound_after_thinint(q);
 
-again:
 	if (!qdio_inbound_q_moved(q))
 		return;
 
@@ -167,7 +165,8 @@ again:
 
 	if (!tiqdio_inbound_q_done(q)) {
 		qdio_perf_stat_inc(&perf_stats.thinint_inbound_loop);
-		goto again;
+		if (likely(q->irq_ptr->state != QDIO_IRQ_STATE_STOPPED))
+			tasklet_schedule(&q->tasklet);
 	}
 
 	qdio_stop_polling(q);
@@ -177,7 +176,8 @@ again:
 	 */
 	if (!tiqdio_inbound_q_done(q)) {
 		qdio_perf_stat_inc(&perf_stats.thinint_inbound_loop2);
-		goto again;
+		if (likely(q->irq_ptr->state != QDIO_IRQ_STATE_STOPPED))
+			tasklet_schedule(&q->tasklet);
 	}
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
