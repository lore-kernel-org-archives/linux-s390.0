Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F22495AE8;
	Mon, 21 Sep 2026 12:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992990; cv=none; b=WGg+KSiaqBGI1xdExwAeZ4qEDiH6QXasXSywD6mIeGOvWOYL4Aw706FLmjX2mZsAOE89sLibuykZSi6MbH9WvwVbzaKimYKv3wD0uGIJ6186hZzt+1EnAFAdynScwc1HXL4b4zmC5IMGl++p8WX/4fGgNuSFV+cdftXGypnqCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992990; c=relaxed/simple;
	bh=JU8YY98aGkz8ATu8+7/s5O34cFyoupEFA0oAllr+jMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaqY6d0MVzDRU+OADY1BcrfES2JeiJ/kIzjyCUei5XpD1V9dJkhqviZapXFnj/G9IeGg09C4jg9LNwm8ECcw+0HGsGPUlL3dGFqAW7PtDJWta7uE+MhRm0FRiF+iYQhYW0KG17bKjYYXfrgbw/08yAoQ4EsGV8N+f6WtG8SRnFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GwLSziKZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GwLSziKZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LB5PfE1316554;
	Mon, 21 Sep 2026 12:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qdwj+pUoe13xtVBsS
	Bay68eGqcdZeUmHkLnbP0Ud1ek=; b=GwLSziKZ0jC6TwahntmCB12wr4iR1EbbE
	4/G0YgkppWbqo1HurLPMT1CjArdr6jC1+aGV9x7BMiAAb9Nsw8g0Dfu+rQCI1YT3
	Zfp5fZbMWmte8QyzhpXIteMSFxiXNVHQtHaEJlvclmDl7O9OU0Ih1dLR907ahzc1
	UAqZT+FpwR3opvXBkGgtosFpItN5cvV0abGK9ZtozfQE/Ej0llxyU6roi1jSVvBN
	7J9qnNTfo7fxntB5xcxpr8jfzc2NnMplSWtyb6EEokuGfY5o+jZFXE1nyxXhDLmq
	X9FrFVcXqIOTw9dps/u/GccC9AHSU24fUJ0wNXGp08vneXmUjds4Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg28ea8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:16:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAlmvW2063837;
	Mon, 21 Sep 2026 12:16:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy4xfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 12:16:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LCGLIa40436038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 12:16:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E2152004B;
	Mon, 21 Sep 2026 12:16:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43F9720043;
	Mon, 21 Sep 2026 12:16:21 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ehn-de.ibm.com (unknown [9.224.79.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 12:16:21 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        brueckner@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
        maximilian.immanuel.brandtner@protonmail.com
Subject: [PATCH 2/2] s390/sclp: Implement resize for sclp-vt220 console
Date: Mon, 21 Sep 2026 14:16:19 +0200
Message-ID: <20260921121619.1354611-3-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921121619.1354611-1-maxbr@linux.ibm.com>
References: <20260921121619.1354611-1-maxbr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Xaf_6PgsR69DByhhCSS86j6czd5ZGbJj
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab1201a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=ckP8Zc6KB2J5pO4mnlEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX12TIsW9wugg9
 1z8V7TZf4Dl9Je0ERjgCP+iAozDSqW4jDiZBWJZmyIajgtK9tmrs465nSBBgl45/gBu1IXIeXtO
 FpevWMxaZjQmTEQWECJ+qK3ptRKA4kVTH83xkcAWQXEOLGVA0jmVwXSvZqYRNaUOpKxJK02kLxP
 VbU67vAfbJLMM+zfuSkvUX3so+1BK2+Y9zMqPjTuIgd+Orwm1IxEY2eiD3OzT3/Bw4DWYbpXZn0
 17MYrMhC7Gy9tdmbr9p1gMwJh75MwMcB54MRhBhQIqkKtk/Coen7RiNwgBWkzcZmjfeN+lGsXbX
 TA6HB5z9icC9oi6uD1G74uCzyH+PdRZblpUJ1ZuiD0rMrgHBpxPSRRQwpa8S9iWl9ZNKNNvDA2v
 3t14fjS2pscY4Ieoy2PR2Od4/fgjAce5qY19ptvnD5thYP6+aQq3OolsYbSM89mts5uLXZrGvNy
 2bG1h9+FIrBN0EDag9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE3NSBTYWx0ZWRfX8vP5PEbM+Q0K
 HPnxlsJN4125Dy2REFkPLr+vpNSj+vq9UUO1vZfWhvnhdkHG3bvRcEGbn0uOfdVGVcYkexiqaDs
 ++AGuhi2N4vd+w3PsXxK3a7ws2t0rcc=
X-Proofpoint-GUID: HWpwyZ6m6ttyc4huIwL0fGNJrOYwTfEY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210175

Add support for sclp vt220 resize events to enable host-initiated
terminal resizing when using the sclp-vt220 console.

This allows QEMU to dynamically resize the console. On older kernel
versions, these events are safely ignored as the kernel drops events
with undefined tty codes.

Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 drivers/s390/char/sclp_vt220.c | 56 ++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 6dd176049..42b96b343 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
+#include <linux/workqueue.h>
 
 #include <linux/uaccess.h>
 #include "sclp.h"
@@ -58,6 +59,11 @@ struct sclp_vt220_evbuf {
 	char data[];
 } __packed;
 
+struct sclp_vt220_resize_data_t {
+	u16 rows;
+	u16 cols;
+} __packed;
+
 #define SCLP_VT220_MAX_CHARS_PER_BUFFER	(PAGE_SIZE - \
 					 sizeof(struct sclp_vt220_request) - \
 					 sizeof(struct sclp_vt220_sccb))
@@ -98,6 +104,15 @@ static int __initdata sclp_vt220_init_count;
  * another buffer */
 static int sclp_vt220_flush_later;
 
+/* Work struct required for scheduling resize */
+static struct work_struct sclp_vt220_resize_work;
+
+/* Current vt220 terminal winsize */
+static struct winsize sclp_vt220_winsize = {
+	.ws_row = 24,
+	.ws_col = 80,
+};
+
 static void sclp_vt220_receiver_fn(struct evbuf_header *evbuf);
 static int __sclp_vt220_emit(struct sclp_vt220_request *request);
 static void sclp_vt220_emit_current(void);
@@ -477,6 +492,7 @@ sclp_vt220_write(struct tty_struct *tty, const u8 *buf, size_t count)
 #define SCLP_VT220_SESSION_ENDED	0x01
 #define	SCLP_VT220_SESSION_STARTED	0x80
 #define SCLP_VT220_SESSION_DATA		0x00
+#define SCLP_VT220_SESSION_RESIZE	0x08
 
 #ifdef CONFIG_MAGIC_SYSRQ
 
@@ -525,6 +541,35 @@ static void sclp_vt220_handle_input(const char *buffer, unsigned int count)
 
 #endif
 
+static void sclp_vt220_resize(struct work_struct *work)
+{
+	struct tty_struct *tty;
+	struct winsize ws;
+
+	spin_lock_irq(&sclp_vt220_lock);
+	ws = sclp_vt220_winsize;
+	spin_unlock_irq(&sclp_vt220_lock);
+
+	tty = tty_port_tty_get(&sclp_vt220_port);
+	if (!tty)
+		return;
+
+	tty_do_resize(tty, &ws);
+	tty_kref_put(tty);
+}
+
+static void sclp_vt220_resize_sched(void *buffer)
+{
+	struct sclp_vt220_resize_data_t *data = buffer;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sclp_vt220_lock, flags);
+	sclp_vt220_winsize.ws_row = data->rows;
+	sclp_vt220_winsize.ws_col = data->cols;
+	schedule_work(&sclp_vt220_resize_work);
+	spin_unlock_irqrestore(&sclp_vt220_lock, flags);
+}
+
 /*
  * Called by the SCLP to report incoming event buffers.
  */
@@ -546,6 +591,9 @@ static void sclp_vt220_receiver_fn(struct evbuf_header *evbuf)
 		sclp_vt220_handle_input(buffer->data, count);
 		tty_flip_buffer_push(&sclp_vt220_port);
 		break;
+	case SCLP_VT220_SESSION_RESIZE:
+		sclp_vt220_resize_sched(buffer->data);
+		break;
 	}
 }
 
@@ -557,9 +605,9 @@ sclp_vt220_open(struct tty_struct *tty, struct file *filp)
 {
 	if (tty->count == 1) {
 		tty_port_tty_set(&sclp_vt220_port, tty);
-		if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
-			tty->winsize.ws_row = 24;
-			tty->winsize.ws_col = 80;
+		if (tty->winsize.ws_row != sclp_vt220_winsize.ws_row ||
+		    tty->winsize.ws_col != sclp_vt220_winsize.ws_col) {
+			schedule_work(&sclp_vt220_resize_work);
 		}
 	}
 	return 0;
@@ -754,6 +802,8 @@ static int __init sclp_vt220_tty_init(void)
 	rc = tty_register_driver(driver);
 	if (rc)
 		goto out_init;
+
+	INIT_WORK(&sclp_vt220_resize_work, sclp_vt220_resize);
 	rc = sclp_register(&sclp_vt220_register_input);
 	if (rc)
 		goto out_reg;
-- 
2.54.0

