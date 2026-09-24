Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDFB47CA60;
	Thu, 24 Sep 2026 10:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246864; cv=none; b=DYF296jsLfDc4tlMuKfYN/RuXEzFtu0mQcz7VXnndDc21ljGcpwNG3G44qfhZ+aIeTAOpV0U5Ien7I7sa5YEzSpT+OuoIzJ1Zr3QJDN8H6sukS9w55qrpPB5E/iBbT/Ryy/g03XISUPoiYJlJVWlshW+A8XSKlS3TSE7cGGUxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246864; c=relaxed/simple;
	bh=JuHXFLUN0Y5ZrnfNLC3lXo/zflo/57c71ghqvNcCmhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0qclia1F5is65g6r1gxe+W8Yk6HebpM/Qt9NgZCPsexXRb+Ku6rjojCH9L89Z5ybde/hyLu39TCwyXyvYE2NW9j1kdBcPE03v+jDdh4idiGSYKVzyxj7toQ1L4Rc1Zv0bO+qXIf1n8yhVVpFqL0rauQddZZ71Yw1QdlV55PtR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ivg+leGM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ivg+leGM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5bflJ160355;
	Thu, 24 Sep 2026 10:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3p52eCX5U9tdYrh9/
	0euk1Ay6kDwdm41BKvR/ZGCHgw=; b=ivg+leGMCyllI2i9qvhbOqDfcZtSdwHy5
	qMQQtOjhCB+CsrnlG34WgXC5wUJuoUFyscvRSVVOl7ZmRobFYCLoZG1Q8BI/DnZt
	MVr7Qmtk74OAxlyQosZL6hvFKPzRktIIM4IKndYUFYXLHNGTHi4cTfGnCugMosP/
	VLBZEv4ShXb/yOpu3LigunoqtyD/IsRGqftOYWeUdwO+Dt5ITTj5nQ78ah+jIwZY
	CQSbtS7WzlzPA9gIy7gSDalY6mhisQWMn0PMADjL08Ls75Dpppd7AelLfmeQl3oK
	CYfkRWtIItzk0PZKxzv9TkTFSqlrmyxSnKFmi+Wa95Nq1jhzRK5fA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqqqcx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 10:47:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OA7ecT212312;
	Thu, 24 Sep 2026 10:47:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7e9g0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 10:47:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OAlZB447710612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 10:47:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0298920040;
	Thu, 24 Sep 2026 10:47:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C891820043;
	Thu, 24 Sep 2026 10:47:34 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ehn-de.ibm.com (unknown [9.224.79.183])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 10:47:34 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        brueckner@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
        maximilian.immanuel.brandtner@protonmail.com
Subject: [PATCH v3 2/2] s390/sclp: Implement resize for sclp-vt220 console
Date: Thu, 24 Sep 2026 12:47:32 +0200
Message-ID: <20260924104732.1978942-3-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924104732.1978942-1-maxbr@linux.ibm.com>
References: <20260924104732.1978942-1-maxbr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab4ffcb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ckP8Zc6KB2J5pO4mnlEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NCBTYWx0ZWRfXyMP2dDyhbfC+
 Cpsx99zWo7NSRzHSKRIsHuZEPkPd2JzkO3QMnnGFky/dDvq0QYF9fzc2AVslLPCwr0VdxyTZ7va
 Aw9wFb26WP1WGvhkeLp+A7o4701OI/2o73inNmlE/3Ojy07kYqbGi6BBpO7bKa+eOHMzsWJxSqP
 MTVWc++nVFlh5Wd6bcqQXZG/rIgf4qNz4rlmM0T/0CQ30McpMbv5ez2ocaufvKmMp7lsTTeChsG
 u1uWrIjzwH7KGy+eAQj8MugY20yf2bhbz2HqyrPEVmrqInj/QMgTH5xzSPUJhJH0U0rqQ1Mru99
 Ktls6x7FwuX0kdpqRAZFthEnzFe+yvcYSFBsDRb1DGJ80XyLhUJpOcz4l4mJtCeRThBJVMZZARW
 4nBO69nbdOAXBMwH+Ra8L+NmsREBxlaHDFyK18/UsuDT0LKwB5FQ4G/Lg1vJyYaw4TmfY3jRdIE
 Ep+D7n//GdCuHSF9tNg==
X-Proofpoint-ORIG-GUID: TDQkMohnZfeq_fn6d-PreLUeY0JYW6o1
X-Proofpoint-GUID: GB8KNl74s7gfZaZcWzSZPkFQiP1U1-tX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NCBTYWx0ZWRfX3Iv8KV6acfpx
 MzSwSUnYNfls4NuwGzg6lCxrNx0j+fYchxW/BNtzwNOTj/0koc69q8dd0hI9LFuQKrh3hJZujyH
 Fo1mmsDU3hsy/oxpFDReB9bGS7FIXwc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240044

Add support for sclp vt220 resize events to enable host-initiated
terminal resizing when using the sclp-vt220 console.

This allows QEMU to dynamically resize the console. On older kernel
versions, these events are safely ignored as the kernel drops events
with undefined tty codes.

Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
---
 drivers/s390/char/sclp_vt220.c | 63 +++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 6de4e2e41..b9162f36d 100644
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
 
@@ -525,6 +541,38 @@ static void sclp_vt220_handle_input(const char *buffer, unsigned int count)
 
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
+static void sclp_vt220_resize_sched(void *buffer, unsigned int count)
+{
+	struct sclp_vt220_resize_data_t *data = buffer;
+	unsigned long flags;
+
+	if (count < sizeof(*data))
+		return;
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
@@ -549,6 +597,9 @@ static void sclp_vt220_receiver_fn(struct evbuf_header *evbuf)
 		sclp_vt220_handle_input(buffer->data, count);
 		tty_flip_buffer_push(&sclp_vt220_port);
 		break;
+	case SCLP_VT220_SESSION_RESIZE:
+		sclp_vt220_resize_sched(buffer->data, count);
+		break;
 	}
 }
 
@@ -560,10 +611,12 @@ sclp_vt220_open(struct tty_struct *tty, struct file *filp)
 {
 	if (tty->count == 1) {
 		tty_port_tty_set(&sclp_vt220_port, tty);
-		if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
-			tty->winsize.ws_row = 24;
-			tty->winsize.ws_col = 80;
-		}
+
+		mutex_lock(&tty->winsize_mutex);
+		spin_lock_irq(&sclp_vt220_lock);
+		tty->winsize = sclp_vt220_winsize;
+		spin_unlock_irq(&sclp_vt220_lock);
+		mutex_unlock(&tty->winsize_mutex);
 	}
 	return 0;
 }
@@ -757,6 +810,8 @@ static int __init sclp_vt220_tty_init(void)
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

