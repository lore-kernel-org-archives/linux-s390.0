Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728327AbgJ1WBK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Oct 2020 18:01:10 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 1/5] zfcp: lift Input Queue tasklet from qdio
Date: Wed, 28 Oct 2020 19:30:48 +0100
Message-Id: <94a765211c48b74a7b91c5e60b158de01db98d43.1603908167.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1603908167.git.bblock@linux.ibm.com>
References: <cover.1603908167.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Benjamin Block <bblock@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

Shift the IRQ tasklet processing from the qdio layer into zfcp.
This will allow for a good amount of cleanups in qdio, and provides
future opportunity to improve the IRQ processing inside zfcp.

We continue to use the qdio layer's internal tasklet/timer mechanism
(ie. scan_threshold etc) to check for Request Queue completions.
Initially we planned to check for such completions after inspecting
the Response Queue - this should typically work, but there's a
theoretical race where the device only presents the Request Queue
completions _after_ all Response Queue processing has finished.
If the Request Queue is then also _completely_ full, we could send no
further IOs and thus get no interrupt that would trigger an inspection
of the Request Queue.
So for now stick to the old model, where we can trust that such a race
would be recovered by qdio's internal timer.

Code-flow wise, this establishes two levels of control:
1. the qdio layer will only deliver IRQs to the device driver if the
   QDIO_IRQ_DISABLED flag is cleared. zfcp manages this through
   qdio_start_irq() / qdio_stop_irq(). The initial state is DISABLED,
   and zfcp_qdio_open() schedules zfcp's IRQ tasklet once during startup
   to explicitly enable IRQ delivery.
2. the zfcp tasklet is initialized with tasklet_disable(), and only gets
   enabled once we open the qdio device.
   When closing the qdio device, we must disable the tasklet _before_
   disabling IRQ delivery (otherwise a concurrently running tasklet
   could re-enable IRQ delivery after we disabled it).

   A final tasklet_kill() during teardown ensures that no lingering
   tasklet_schedule() is still accessing the tasklet structure.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_qdio.c | 39 +++++++++++++++++++++++++++++++++++
 drivers/s390/scsi/zfcp_qdio.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_qdio.c b/drivers/s390/scsi/zfcp_qdio.c
index a8a514074084..9fc045ddf66d 100644
--- a/drivers/s390/scsi/zfcp_qdio.c
+++ b/drivers/s390/scsi/zfcp_qdio.c
@@ -131,6 +131,33 @@ static void zfcp_qdio_int_resp(struct ccw_device *cdev, unsigned int qdio_err,
 		zfcp_erp_adapter_reopen(qdio->adapter, 0, "qdires2");
 }
 
+static void zfcp_qdio_irq_tasklet(struct tasklet_struct *tasklet)
+{
+	struct zfcp_qdio *qdio = from_tasklet(qdio, tasklet, irq_tasklet);
+	struct ccw_device *cdev = qdio->adapter->ccw_device;
+	unsigned int start, error;
+	int completed;
+
+	/* Check the Response Queue, and kick off the Request Queue tasklet: */
+	completed = qdio_get_next_buffers(cdev, 0, &start, &error);
+	if (completed < 0)
+		return;
+	if (completed > 0)
+		zfcp_qdio_int_resp(cdev, error, 0, start, completed,
+				   (unsigned long) qdio);
+
+	if (qdio_start_irq(cdev))
+		/* More work pending: */
+		tasklet_schedule(&qdio->irq_tasklet);
+}
+
+static void zfcp_qdio_poll(struct ccw_device *cdev, unsigned long data)
+{
+	struct zfcp_qdio *qdio = (struct zfcp_qdio *) data;
+
+	tasklet_schedule(&qdio->irq_tasklet);
+}
+
 static struct qdio_buffer_element *
 zfcp_qdio_sbal_chain(struct zfcp_qdio *qdio, struct zfcp_qdio_req *q_req)
 {
@@ -332,6 +359,8 @@ void zfcp_qdio_close(struct zfcp_qdio *qdio)
 
 	wake_up(&qdio->req_q_wq);
 
+	tasklet_disable(&qdio->irq_tasklet);
+	qdio_stop_irq(adapter->ccw_device);
 	qdio_shutdown(adapter->ccw_device, QDIO_FLAG_CLEANUP_USING_CLEAR);
 
 	/* cleanup used outbound sbals */
@@ -387,6 +416,7 @@ int zfcp_qdio_open(struct zfcp_qdio *qdio)
 	init_data.no_output_qs = 1;
 	init_data.input_handler = zfcp_qdio_int_resp;
 	init_data.output_handler = zfcp_qdio_int_req;
+	init_data.irq_poll = zfcp_qdio_poll;
 	init_data.int_parm = (unsigned long) qdio;
 	init_data.input_sbal_addr_array = input_sbals;
 	init_data.output_sbal_addr_array = output_sbals;
@@ -433,6 +463,11 @@ int zfcp_qdio_open(struct zfcp_qdio *qdio)
 	atomic_set(&qdio->req_q_free, QDIO_MAX_BUFFERS_PER_Q);
 	atomic_or(ZFCP_STATUS_ADAPTER_QDIOUP, &qdio->adapter->status);
 
+	/* Enable processing for QDIO interrupts: */
+	tasklet_enable(&qdio->irq_tasklet);
+	/* This results in a qdio_start_irq(): */
+	tasklet_schedule(&qdio->irq_tasklet);
+
 	zfcp_qdio_shost_update(adapter, qdio);
 
 	return 0;
@@ -450,6 +485,8 @@ void zfcp_qdio_destroy(struct zfcp_qdio *qdio)
 	if (!qdio)
 		return;
 
+	tasklet_kill(&qdio->irq_tasklet);
+
 	if (qdio->adapter->ccw_device)
 		qdio_free(qdio->adapter->ccw_device);
 
@@ -475,6 +512,8 @@ int zfcp_qdio_setup(struct zfcp_adapter *adapter)
 
 	spin_lock_init(&qdio->req_q_lock);
 	spin_lock_init(&qdio->stat_lock);
+	tasklet_setup(&qdio->irq_tasklet, zfcp_qdio_irq_tasklet);
+	tasklet_disable(&qdio->irq_tasklet);
 
 	adapter->qdio = qdio;
 	return 0;
diff --git a/drivers/s390/scsi/zfcp_qdio.h b/drivers/s390/scsi/zfcp_qdio.h
index 6b43d6b254be..9c1f310db155 100644
--- a/drivers/s390/scsi/zfcp_qdio.h
+++ b/drivers/s390/scsi/zfcp_qdio.h
@@ -10,6 +10,7 @@
 #ifndef ZFCP_QDIO_H
 #define ZFCP_QDIO_H
 
+#include <linux/interrupt.h>
 #include <asm/qdio.h>
 
 #define ZFCP_QDIO_SBALE_LEN	PAGE_SIZE
@@ -44,6 +45,7 @@ struct zfcp_qdio {
 	u64			req_q_util;
 	atomic_t		req_q_full;
 	wait_queue_head_t	req_q_wq;
+	struct tasklet_struct	irq_tasklet;
 	struct zfcp_adapter	*adapter;
 	u16			max_sbale_per_sbal;
 	u16			max_sbale_per_req;
-- 
2.26.2
