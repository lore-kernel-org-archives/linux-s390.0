Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 16 Aug 2016 08:42:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.8-rc3
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20160816084227.516a5b88@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

A couple of bug fixes, minor cleanup and a change to the default config.

Christian Borntraeger (3):
      s390/crc32-vx: Fix checksum calculation for small sizes
      s390/lib: fix memcmp and strstr
      s390/config: make the vector optimized crc function builtin

Heiko Carstens (1):
      s390/pageattr: handle numpages parameter correctly

Sascha Silbe (1):
      s390: clarify compressed image code path

Sebastian Ott (6):
      s390/cio: stop using subchannel_id from ccw_device_private
      s390/qdio: obtain subchannel_id via ccw_device_get_schid()
      s390/cio: remove subchannel_id from ccw_device_private
      s390/qdio: get rid of spin_lock_irqsave usage
      s390/qdio: fix double return code evaluation
      s390/qdio: remove checks for ccw device internal state

Stefan Haberland (2):
      s390/dasd: fix hanging device after clear subchannel
      s390/dasd: fix failing CUIR assignment under LPAR

Ursula Braun (1):
      s390/qdio: avoid reschedule of outbound tasklet once killed

 arch/s390/boot/compressed/head.S        |  11 +++-
 arch/s390/configs/default_defconfig     |   2 +-
 arch/s390/configs/gcov_defconfig        |   2 +-
 arch/s390/configs/performance_defconfig |   2 +-
 arch/s390/crypto/crc32-vx.c             |   6 +-
 arch/s390/defconfig                     |   2 +-
 arch/s390/kernel/head.S                 |   4 +-
 arch/s390/lib/string.c                  |  16 ++---
 arch/s390/mm/pageattr.c                 |   2 +
 drivers/s390/block/dasd.c               |  10 ++-
 drivers/s390/block/dasd_eckd.c          |  10 +++
 drivers/s390/cio/device.c               |   2 -
 drivers/s390/cio/device_status.c        |   7 +-
 drivers/s390/cio/io_sch.h               |   1 -
 drivers/s390/cio/qdio_main.c            | 113 ++++++++++++++++----------------
 15 files changed, 107 insertions(+), 83 deletions(-)

diff --git a/arch/s390/boot/compressed/head.S b/arch/s390/boot/compressed/head.S
index f86a4ee..28c4f96 100644
--- a/arch/s390/boot/compressed/head.S
+++ b/arch/s390/boot/compressed/head.S
@@ -21,16 +21,21 @@ ENTRY(startup_continue)
 	lg	%r15,.Lstack-.LPG1(%r13)
 	aghi	%r15,-160
 	brasl	%r14,decompress_kernel
-	# setup registers for memory mover & branch to target
+	# Set up registers for memory mover. We move the decompressed image to
+	# 0x11000, starting at offset 0x11000 in the decompressed image so
+	# that code living at 0x11000 in the image will end up at 0x11000 in
+	# memory.
 	lgr	%r4,%r2
 	lg	%r2,.Loffset-.LPG1(%r13)
 	la	%r4,0(%r2,%r4)
 	lg	%r3,.Lmvsize-.LPG1(%r13)
 	lgr	%r5,%r3
-	# move the memory mover someplace safe
+	# Move the memory mover someplace safe so it doesn't overwrite itself.
 	la	%r1,0x200
 	mvc	0(mover_end-mover,%r1),mover-.LPG1(%r13)
-	# decompress image is started at 0x11000
+	# When the memory mover is done we pass control to
+	# arch/s390/kernel/head64.S:startup_continue which lives at 0x11000 in
+	# the decompressed image.
 	lgr	%r6,%r2
 	br	%r1
 mover:
diff --git a/arch/s390/configs/default_defconfig b/arch/s390/configs/default_defconfig
index 889ea34..26e0c7f 100644
--- a/arch/s390/configs/default_defconfig
+++ b/arch/s390/configs/default_defconfig
@@ -678,7 +678,7 @@ CONFIG_CRYPTO_SHA512_S390=m
 CONFIG_CRYPTO_DES_S390=m
 CONFIG_CRYPTO_AES_S390=m
 CONFIG_CRYPTO_GHASH_S390=m
-CONFIG_CRYPTO_CRC32_S390=m
+CONFIG_CRYPTO_CRC32_S390=y
 CONFIG_ASYMMETRIC_KEY_TYPE=y
 CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=m
 CONFIG_X509_CERTIFICATE_PARSER=m
diff --git a/arch/s390/configs/gcov_defconfig b/arch/s390/configs/gcov_defconfig
index 1bcfd76..24879da 100644
--- a/arch/s390/configs/gcov_defconfig
+++ b/arch/s390/configs/gcov_defconfig
@@ -616,7 +616,7 @@ CONFIG_CRYPTO_SHA512_S390=m
 CONFIG_CRYPTO_DES_S390=m
 CONFIG_CRYPTO_AES_S390=m
 CONFIG_CRYPTO_GHASH_S390=m
-CONFIG_CRYPTO_CRC32_S390=m
+CONFIG_CRYPTO_CRC32_S390=y
 CONFIG_ASYMMETRIC_KEY_TYPE=y
 CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=m
 CONFIG_X509_CERTIFICATE_PARSER=m
diff --git a/arch/s390/configs/performance_defconfig b/arch/s390/configs/performance_defconfig
index 13ff090..a5c1e5f 100644
--- a/arch/s390/configs/performance_defconfig
+++ b/arch/s390/configs/performance_defconfig
@@ -615,7 +615,7 @@ CONFIG_CRYPTO_SHA512_S390=m
 CONFIG_CRYPTO_DES_S390=m
 CONFIG_CRYPTO_AES_S390=m
 CONFIG_CRYPTO_GHASH_S390=m
-CONFIG_CRYPTO_CRC32_S390=m
+CONFIG_CRYPTO_CRC32_S390=y
 CONFIG_ASYMMETRIC_KEY_TYPE=y
 CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=m
 CONFIG_X509_CERTIFICATE_PARSER=m
diff --git a/arch/s390/crypto/crc32-vx.c b/arch/s390/crypto/crc32-vx.c
index 577ae1d..2bad9d8 100644
--- a/arch/s390/crypto/crc32-vx.c
+++ b/arch/s390/crypto/crc32-vx.c
@@ -51,6 +51,9 @@ u32 crc32c_le_vgfm_16(u32 crc, unsigned char const *buf, size_t size);
 		struct kernel_fpu vxstate;				    \
 		unsigned long prealign, aligned, remaining;		    \
 									    \
+		if (datalen < VX_MIN_LEN + VX_ALIGN_MASK)		    \
+			return ___crc32_sw(crc, data, datalen);		    \
+									    \
 		if ((unsigned long)data & VX_ALIGN_MASK) {		    \
 			prealign = VX_ALIGNMENT -			    \
 				  ((unsigned long)data & VX_ALIGN_MASK);    \
@@ -59,9 +62,6 @@ u32 crc32c_le_vgfm_16(u32 crc, unsigned char const *buf, size_t size);
 			data = (void *)((unsigned long)data + prealign);    \
 		}							    \
 									    \
-		if (datalen < VX_MIN_LEN)				    \
-			return ___crc32_sw(crc, data, datalen);		    \
-									    \
 		aligned = datalen & ~VX_ALIGN_MASK;			    \
 		remaining = datalen & VX_ALIGN_MASK;			    \
 									    \
diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index ccccebe..73610f2 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -234,7 +234,7 @@ CONFIG_CRYPTO_SHA256_S390=m
 CONFIG_CRYPTO_SHA512_S390=m
 CONFIG_CRYPTO_DES_S390=m
 CONFIG_CRYPTO_AES_S390=m
-CONFIG_CRYPTO_CRC32_S390=m
+CONFIG_CRYPTO_CRC32_S390=y
 CONFIG_CRC7=m
 # CONFIG_XZ_DEC_X86 is not set
 # CONFIG_XZ_DEC_POWERPC is not set
diff --git a/arch/s390/kernel/head.S b/arch/s390/kernel/head.S
index 56e4d82..4431905 100644
--- a/arch/s390/kernel/head.S
+++ b/arch/s390/kernel/head.S
@@ -309,7 +309,9 @@ ENTRY(startup_kdump)
 	l	%r15,.Lstack-.LPG0(%r13)
 	ahi	%r15,-STACK_FRAME_OVERHEAD
 	brasl	%r14,verify_facilities
-	/* Continue with startup code in head64.S */
+# For uncompressed images, continue in
+# arch/s390/kernel/head64.S. For compressed images, continue in
+# arch/s390/boot/compressed/head.S.
 	jg	startup_continue
 
 .Lstack:
diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
index e390bbb..48352bf 100644
--- a/arch/s390/lib/string.c
+++ b/arch/s390/lib/string.c
@@ -237,11 +237,10 @@ char * strrchr(const char * s, int c)
 EXPORT_SYMBOL(strrchr);
 
 static inline int clcle(const char *s1, unsigned long l1,
-			const char *s2, unsigned long l2,
-			int *diff)
+			const char *s2, unsigned long l2)
 {
 	register unsigned long r2 asm("2") = (unsigned long) s1;
-	register unsigned long r3 asm("3") = (unsigned long) l2;
+	register unsigned long r3 asm("3") = (unsigned long) l1;
 	register unsigned long r4 asm("4") = (unsigned long) s2;
 	register unsigned long r5 asm("5") = (unsigned long) l2;
 	int cc;
@@ -252,7 +251,6 @@ static inline int clcle(const char *s1, unsigned long l1,
 		      "   srl   %0,28"
 		      : "=&d" (cc), "+a" (r2), "+a" (r3),
 			"+a" (r4), "+a" (r5) : : "cc");
-	*diff = *(char *)r2 - *(char *)r4;
 	return cc;
 }
 
@@ -270,9 +268,9 @@ char * strstr(const char * s1,const char * s2)
 		return (char *) s1;
 	l1 = __strend(s1) - s1;
 	while (l1-- >= l2) {
-		int cc, dummy;
+		int cc;
 
-		cc = clcle(s1, l1, s2, l2, &dummy);
+		cc = clcle(s1, l2, s2, l2);
 		if (!cc)
 			return (char *) s1;
 		s1++;
@@ -313,11 +311,11 @@ EXPORT_SYMBOL(memchr);
  */
 int memcmp(const void *cs, const void *ct, size_t n)
 {
-	int ret, diff;
+	int ret;
 
-	ret = clcle(cs, n, ct, n, &diff);
+	ret = clcle(cs, n, ct, n);
 	if (ret)
-		ret = diff;
+		ret = ret == 1 ? -1 : 1;
 	return ret;
 }
 EXPORT_SYMBOL(memcmp);
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 7104ffb..af7cf28c 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -252,6 +252,8 @@ static int change_page_attr(unsigned long addr, unsigned long end,
 	int rc = -EINVAL;
 	pgd_t *pgdp;
 
+	if (addr == end)
+		return 0;
 	if (end >= MODULES_END)
 		return -EINVAL;
 	mutex_lock(&cpa_mutex);
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 8973d34..fb1b56a 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1643,9 +1643,18 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 	u8 *sense = NULL;
 	int expires;
 
+	cqr = (struct dasd_ccw_req *) intparm;
 	if (IS_ERR(irb)) {
 		switch (PTR_ERR(irb)) {
 		case -EIO:
+			if (cqr && cqr->status == DASD_CQR_CLEAR_PENDING) {
+				device = (struct dasd_device *) cqr->startdev;
+				cqr->status = DASD_CQR_CLEARED;
+				dasd_device_clear_timer(device);
+				wake_up(&dasd_flush_wq);
+				dasd_schedule_device_bh(device);
+				return;
+			}
 			break;
 		case -ETIMEDOUT:
 			DBF_EVENT_DEVID(DBF_WARNING, cdev, "%s: "
@@ -1661,7 +1670,6 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 	}
 
 	now = get_tod_clock();
-	cqr = (struct dasd_ccw_req *) intparm;
 	/* check for conditions that should be handled immediately */
 	if (!cqr ||
 	    !(scsw_dstat(&irb->scsw) == (DEV_STAT_CHN_END | DEV_STAT_DEV_END) &&
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index fd2eff4..98bbec4 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -5078,6 +5078,8 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 		return PTR_ERR(cqr);
 	}
 
+	cqr->lpm = lpum;
+retry:
 	cqr->startdev = device;
 	cqr->memdev = device;
 	cqr->block = NULL;
@@ -5122,6 +5124,14 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 			(prssdp + 1);
 		memcpy(messages, message_buf,
 		       sizeof(struct dasd_rssd_messages));
+	} else if (cqr->lpm) {
+		/*
+		 * on z/VM we might not be able to do I/O on the requested path
+		 * but instead we get the required information on any path
+		 * so retry with open path mask
+		 */
+		cqr->lpm = 0;
+		goto retry;
 	} else
 		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
 				"Reading messages failed with rc=%d\n"
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 7ada078..6a58bc8 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -762,7 +762,6 @@ static int io_subchannel_initialize_dev(struct subchannel *sch,
 	priv->state = DEV_STATE_NOT_OPER;
 	priv->dev_id.devno = sch->schib.pmcw.dev;
 	priv->dev_id.ssid = sch->schid.ssid;
-	priv->schid = sch->schid;
 
 	INIT_WORK(&priv->todo_work, ccw_device_todo);
 	INIT_LIST_HEAD(&priv->cmb_list);
@@ -1000,7 +999,6 @@ static int ccw_device_move_to_sch(struct ccw_device *cdev,
 	put_device(&old_sch->dev);
 	/* Initialize new subchannel. */
 	spin_lock_irq(sch->lock);
-	cdev->private->schid = sch->schid;
 	cdev->ccwlock = sch->lock;
 	if (!sch_is_pseudo_sch(sch))
 		sch_set_cdev(sch, cdev);
diff --git a/drivers/s390/cio/device_status.c b/drivers/s390/cio/device_status.c
index 15b56a1..9bc3512 100644
--- a/drivers/s390/cio/device_status.c
+++ b/drivers/s390/cio/device_status.c
@@ -26,6 +26,7 @@
 static void
 ccw_device_msg_control_check(struct ccw_device *cdev, struct irb *irb)
 {
+	struct subchannel *sch = to_subchannel(cdev->dev.parent);
 	char dbf_text[15];
 
 	if (!scsw_is_valid_cstat(&irb->scsw) ||
@@ -36,10 +37,10 @@ ccw_device_msg_control_check(struct ccw_device *cdev, struct irb *irb)
 		      "received"
 		      " ... device %04x on subchannel 0.%x.%04x, dev_stat "
 		      ": %02X sch_stat : %02X\n",
-		      cdev->private->dev_id.devno, cdev->private->schid.ssid,
-		      cdev->private->schid.sch_no,
+		      cdev->private->dev_id.devno, sch->schid.ssid,
+		      sch->schid.sch_no,
 		      scsw_dstat(&irb->scsw), scsw_cstat(&irb->scsw));
-	sprintf(dbf_text, "chk%x", cdev->private->schid.sch_no);
+	sprintf(dbf_text, "chk%x", sch->schid.sch_no);
 	CIO_TRACE_EVENT(0, dbf_text);
 	CIO_HEX_EVENT(0, irb, sizeof(struct irb));
 }
diff --git a/drivers/s390/cio/io_sch.h b/drivers/s390/cio/io_sch.h
index 8975060..220f491 100644
--- a/drivers/s390/cio/io_sch.h
+++ b/drivers/s390/cio/io_sch.h
@@ -120,7 +120,6 @@ struct ccw_device_private {
 	int state;		/* device state */
 	atomic_t onoff;
 	struct ccw_dev_id dev_id;	/* device id */
-	struct subchannel_id schid;	/* subchannel number */
 	struct ccw_request req;		/* internal I/O request */
 	int iretry;
 	u8 pgid_valid_mask;	/* mask of valid PGIDs */
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 4bb5262..71bf9bd 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -686,6 +686,15 @@ static void qdio_kick_handler(struct qdio_q *q)
 	q->qdio_error = 0;
 }
 
+static inline int qdio_tasklet_schedule(struct qdio_q *q)
+{
+	if (likely(q->irq_ptr->state == QDIO_IRQ_STATE_ACTIVE)) {
+		tasklet_schedule(&q->tasklet);
+		return 0;
+	}
+	return -EPERM;
+}
+
 static void __qdio_inbound_processing(struct qdio_q *q)
 {
 	qperf_inc(q, tasklet_inbound);
@@ -698,10 +707,8 @@ static void __qdio_inbound_processing(struct qdio_q *q)
 	if (!qdio_inbound_q_done(q)) {
 		/* means poll time is not yet over */
 		qperf_inc(q, tasklet_inbound_resched);
-		if (likely(q->irq_ptr->state != QDIO_IRQ_STATE_STOPPED)) {
-			tasklet_schedule(&q->tasklet);
+		if (!qdio_tasklet_schedule(q))
 			return;
-		}
 	}
 
 	qdio_stop_polling(q);
@@ -711,8 +718,7 @@ static void __qdio_inbound_processing(struct qdio_q *q)
 	 */
 	if (!qdio_inbound_q_done(q)) {
 		qperf_inc(q, tasklet_inbound_resched2);
-		if (likely(q->irq_ptr->state != QDIO_IRQ_STATE_STOPPED))
-			tasklet_schedule(&q->tasklet);
+		qdio_tasklet_schedule(q);
 	}
 }
 
@@ -869,16 +875,15 @@ static void __qdio_outbound_processing(struct qdio_q *q)
 	 * is noticed and outbound_handler is called after some time.
 	 */
 	if (qdio_outbound_q_done(q))
-		del_timer(&q->u.out.timer);
+		del_timer_sync(&q->u.out.timer);
 	else
-		if (!timer_pending(&q->u.out.timer))
+		if (!timer_pending(&q->u.out.timer) &&
+		    likely(q->irq_ptr->state == QDIO_IRQ_STATE_ACTIVE))
 			mod_timer(&q->u.out.timer, jiffies + 10 * HZ);
 	return;
 
 sched:
-	if (unlikely(q->irq_ptr->state == QDIO_IRQ_STATE_STOPPED))
-		return;
-	tasklet_schedule(&q->tasklet);
+	qdio_tasklet_schedule(q);
 }
 
 /* outbound tasklet */
@@ -892,9 +897,7 @@ void qdio_outbound_timer(unsigned long data)
 {
 	struct qdio_q *q = (struct qdio_q *)data;
 
-	if (unlikely(q->irq_ptr->state == QDIO_IRQ_STATE_STOPPED))
-		return;
-	tasklet_schedule(&q->tasklet);
+	qdio_tasklet_schedule(q);
 }
 
 static inline void qdio_check_outbound_after_thinint(struct qdio_q *q)
@@ -907,7 +910,7 @@ static inline void qdio_check_outbound_after_thinint(struct qdio_q *q)
 
 	for_each_output_queue(q->irq_ptr, out, i)
 		if (!qdio_outbound_q_done(out))
-			tasklet_schedule(&out->tasklet);
+			qdio_tasklet_schedule(out);
 }
 
 static void __tiqdio_inbound_processing(struct qdio_q *q)
@@ -929,10 +932,8 @@ static void __tiqdio_inbound_processing(struct qdio_q *q)
 
 	if (!qdio_inbound_q_done(q)) {
 		qperf_inc(q, tasklet_inbound_resched);
-		if (likely(q->irq_ptr->state != QDIO_IRQ_STATE_STOPPED)) {
-			tasklet_schedule(&q->tasklet);
+		if (!qdio_tasklet_schedule(q))
 			return;
-		}
 	}
 
 	qdio_stop_polling(q);
@@ -942,8 +943,7 @@ static void __tiqdio_inbound_processing(struct qdio_q *q)
 	 */
 	if (!qdio_inbound_q_done(q)) {
 		qperf_inc(q, tasklet_inbound_resched2);
-		if (likely(q->irq_ptr->state != QDIO_IRQ_STATE_STOPPED))
-			tasklet_schedule(&q->tasklet);
+		qdio_tasklet_schedule(q);
 	}
 }
 
@@ -977,7 +977,7 @@ static void qdio_int_handler_pci(struct qdio_irq *irq_ptr)
 	int i;
 	struct qdio_q *q;
 
-	if (unlikely(irq_ptr->state == QDIO_IRQ_STATE_STOPPED))
+	if (unlikely(irq_ptr->state != QDIO_IRQ_STATE_ACTIVE))
 		return;
 
 	for_each_input_queue(irq_ptr, q, i) {
@@ -1003,7 +1003,7 @@ static void qdio_int_handler_pci(struct qdio_irq *irq_ptr)
 			continue;
 		if (need_siga_sync(q) && need_siga_sync_out_after_pci(q))
 			qdio_siga_sync_q(q);
-		tasklet_schedule(&q->tasklet);
+		qdio_tasklet_schedule(q);
 	}
 }
 
@@ -1066,10 +1066,12 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 		      struct irb *irb)
 {
 	struct qdio_irq *irq_ptr = cdev->private->qdio_data;
+	struct subchannel_id schid;
 	int cstat, dstat;
 
 	if (!intparm || !irq_ptr) {
-		DBF_ERROR("qint:%4x", cdev->private->schid.sch_no);
+		ccw_device_get_schid(cdev, &schid);
+		DBF_ERROR("qint:%4x", schid.sch_no);
 		return;
 	}
 
@@ -1122,12 +1124,14 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 int qdio_get_ssqd_desc(struct ccw_device *cdev,
 		       struct qdio_ssqd_desc *data)
 {
+	struct subchannel_id schid;
 
 	if (!cdev || !cdev->private)
 		return -EINVAL;
 
-	DBF_EVENT("get ssqd:%4x", cdev->private->schid.sch_no);
-	return qdio_setup_get_ssqd(NULL, &cdev->private->schid, data);
+	ccw_device_get_schid(cdev, &schid);
+	DBF_EVENT("get ssqd:%4x", schid.sch_no);
+	return qdio_setup_get_ssqd(NULL, &schid, data);
 }
 EXPORT_SYMBOL_GPL(qdio_get_ssqd_desc);
 
@@ -1141,7 +1145,7 @@ static void qdio_shutdown_queues(struct ccw_device *cdev)
 		tasklet_kill(&q->tasklet);
 
 	for_each_output_queue(irq_ptr, q, i) {
-		del_timer(&q->u.out.timer);
+		del_timer_sync(&q->u.out.timer);
 		tasklet_kill(&q->tasklet);
 	}
 }
@@ -1154,14 +1158,15 @@ static void qdio_shutdown_queues(struct ccw_device *cdev)
 int qdio_shutdown(struct ccw_device *cdev, int how)
 {
 	struct qdio_irq *irq_ptr = cdev->private->qdio_data;
+	struct subchannel_id schid;
 	int rc;
-	unsigned long flags;
 
 	if (!irq_ptr)
 		return -ENODEV;
 
 	WARN_ON_ONCE(irqs_disabled());
-	DBF_EVENT("qshutdown:%4x", cdev->private->schid.sch_no);
+	ccw_device_get_schid(cdev, &schid);
+	DBF_EVENT("qshutdown:%4x", schid.sch_no);
 
 	mutex_lock(&irq_ptr->setup_mutex);
 	/*
@@ -1184,7 +1189,7 @@ int qdio_shutdown(struct ccw_device *cdev, int how)
 	qdio_shutdown_debug_entries(irq_ptr);
 
 	/* cleanup subchannel */
-	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
+	spin_lock_irq(get_ccwdev_lock(cdev));
 
 	if (how & QDIO_FLAG_CLEANUP_USING_CLEAR)
 		rc = ccw_device_clear(cdev, QDIO_DOING_CLEANUP);
@@ -1198,12 +1203,12 @@ int qdio_shutdown(struct ccw_device *cdev, int how)
 	}
 
 	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_CLEANUP);
-	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
+	spin_unlock_irq(get_ccwdev_lock(cdev));
 	wait_event_interruptible_timeout(cdev->private->wait_q,
 		irq_ptr->state == QDIO_IRQ_STATE_INACTIVE ||
 		irq_ptr->state == QDIO_IRQ_STATE_ERR,
 		10 * HZ);
-	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
+	spin_lock_irq(get_ccwdev_lock(cdev));
 
 no_cleanup:
 	qdio_shutdown_thinint(irq_ptr);
@@ -1211,7 +1216,7 @@ no_cleanup:
 	/* restore interrupt handler */
 	if ((void *)cdev->handler == (void *)qdio_int_handler)
 		cdev->handler = irq_ptr->orig_handler;
-	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
+	spin_unlock_irq(get_ccwdev_lock(cdev));
 
 	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_INACTIVE);
 	mutex_unlock(&irq_ptr->setup_mutex);
@@ -1228,11 +1233,13 @@ EXPORT_SYMBOL_GPL(qdio_shutdown);
 int qdio_free(struct ccw_device *cdev)
 {
 	struct qdio_irq *irq_ptr = cdev->private->qdio_data;
+	struct subchannel_id schid;
 
 	if (!irq_ptr)
 		return -ENODEV;
 
-	DBF_EVENT("qfree:%4x", cdev->private->schid.sch_no);
+	ccw_device_get_schid(cdev, &schid);
+	DBF_EVENT("qfree:%4x", schid.sch_no);
 	DBF_DEV_EVENT(DBF_ERR, irq_ptr, "dbf abandoned");
 	mutex_lock(&irq_ptr->setup_mutex);
 
@@ -1251,9 +1258,11 @@ EXPORT_SYMBOL_GPL(qdio_free);
  */
 int qdio_allocate(struct qdio_initialize *init_data)
 {
+	struct subchannel_id schid;
 	struct qdio_irq *irq_ptr;
 
-	DBF_EVENT("qallocate:%4x", init_data->cdev->private->schid.sch_no);
+	ccw_device_get_schid(init_data->cdev, &schid);
+	DBF_EVENT("qallocate:%4x", schid.sch_no);
 
 	if ((init_data->no_input_qs && !init_data->input_handler) ||
 	    (init_data->no_output_qs && !init_data->output_handler))
@@ -1331,20 +1340,18 @@ static void qdio_detect_hsicq(struct qdio_irq *irq_ptr)
  */
 int qdio_establish(struct qdio_initialize *init_data)
 {
-	struct qdio_irq *irq_ptr;
 	struct ccw_device *cdev = init_data->cdev;
-	unsigned long saveflags;
+	struct subchannel_id schid;
+	struct qdio_irq *irq_ptr;
 	int rc;
 
-	DBF_EVENT("qestablish:%4x", cdev->private->schid.sch_no);
+	ccw_device_get_schid(cdev, &schid);
+	DBF_EVENT("qestablish:%4x", schid.sch_no);
 
 	irq_ptr = cdev->private->qdio_data;
 	if (!irq_ptr)
 		return -ENODEV;
 
-	if (cdev->private->state != DEV_STATE_ONLINE)
-		return -EINVAL;
-
 	mutex_lock(&irq_ptr->setup_mutex);
 	qdio_setup_irq(init_data);
 
@@ -1361,17 +1368,14 @@ int qdio_establish(struct qdio_initialize *init_data)
 	irq_ptr->ccw.count = irq_ptr->equeue.count;
 	irq_ptr->ccw.cda = (u32)((addr_t)irq_ptr->qdr);
 
-	spin_lock_irqsave(get_ccwdev_lock(cdev), saveflags);
+	spin_lock_irq(get_ccwdev_lock(cdev));
 	ccw_device_set_options_mask(cdev, 0);
 
 	rc = ccw_device_start(cdev, &irq_ptr->ccw, QDIO_DOING_ESTABLISH, 0, 0);
+	spin_unlock_irq(get_ccwdev_lock(cdev));
 	if (rc) {
 		DBF_ERROR("%4x est IO ERR", irq_ptr->schid.sch_no);
 		DBF_ERROR("rc:%4x", rc);
-	}
-	spin_unlock_irqrestore(get_ccwdev_lock(cdev), saveflags);
-
-	if (rc) {
 		mutex_unlock(&irq_ptr->setup_mutex);
 		qdio_shutdown(cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
 		return rc;
@@ -1407,19 +1411,17 @@ EXPORT_SYMBOL_GPL(qdio_establish);
  */
 int qdio_activate(struct ccw_device *cdev)
 {
+	struct subchannel_id schid;
 	struct qdio_irq *irq_ptr;
 	int rc;
-	unsigned long saveflags;
 
-	DBF_EVENT("qactivate:%4x", cdev->private->schid.sch_no);
+	ccw_device_get_schid(cdev, &schid);
+	DBF_EVENT("qactivate:%4x", schid.sch_no);
 
 	irq_ptr = cdev->private->qdio_data;
 	if (!irq_ptr)
 		return -ENODEV;
 
-	if (cdev->private->state != DEV_STATE_ONLINE)
-		return -EINVAL;
-
 	mutex_lock(&irq_ptr->setup_mutex);
 	if (irq_ptr->state == QDIO_IRQ_STATE_INACTIVE) {
 		rc = -EBUSY;
@@ -1431,19 +1433,17 @@ int qdio_activate(struct ccw_device *cdev)
 	irq_ptr->ccw.count = irq_ptr->aqueue.count;
 	irq_ptr->ccw.cda = 0;
 
-	spin_lock_irqsave(get_ccwdev_lock(cdev), saveflags);
+	spin_lock_irq(get_ccwdev_lock(cdev));
 	ccw_device_set_options(cdev, CCWDEV_REPORT_ALL);
 
 	rc = ccw_device_start(cdev, &irq_ptr->ccw, QDIO_DOING_ACTIVATE,
 			      0, DOIO_DENY_PREFETCH);
+	spin_unlock_irq(get_ccwdev_lock(cdev));
 	if (rc) {
 		DBF_ERROR("%4x act IO ERR", irq_ptr->schid.sch_no);
 		DBF_ERROR("rc:%4x", rc);
-	}
-	spin_unlock_irqrestore(get_ccwdev_lock(cdev), saveflags);
-
-	if (rc)
 		goto out;
+	}
 
 	if (is_thinint_irq(irq_ptr))
 		tiqdio_add_input_queues(irq_ptr);
@@ -1585,10 +1585,11 @@ static int handle_outbound(struct qdio_q *q, unsigned int callflags,
 
 	/* in case of SIGA errors we must process the error immediately */
 	if (used >= q->u.out.scan_threshold || rc)
-		tasklet_schedule(&q->tasklet);
+		qdio_tasklet_schedule(q);
 	else
 		/* free the SBALs in case of no further traffic */
-		if (!timer_pending(&q->u.out.timer))
+		if (!timer_pending(&q->u.out.timer) &&
+		    likely(q->irq_ptr->state == QDIO_IRQ_STATE_ACTIVE))
 			mod_timer(&q->u.out.timer, jiffies + HZ);
 	return rc;
 }
