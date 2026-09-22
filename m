Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0614F4CEB;
	Tue, 22 Sep 2026 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071153; cv=none; b=IemRgTzgujeGjJA9t6SAUPf1zw23KCVsPt+tpnclFXa5rux+uZd+Hwo+r0z5o1cc6UpewBzmgrStLnCyVeGevuAIK03rxTYidSJF2wnzRafpwLq07H7lvIjRvG4vde3pDqlGa89FCpBpBY6L+SgixJEd+Zj+unVZsuWb4tfhfFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071153; c=relaxed/simple;
	bh=RpemjaNPfnw1vxVB7F15EjZny+YWwzmuoPw9CLxLWcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9sSEgi8QO1/Vd3bxX2oIDGlxFh3q6p3JmnAzyIiZgMgXjGEhJu9SydA8/Ahv/2nMkrysu4h+ThDcyAoHFoyKCtm3NqVB4APvvcIEo7UaAcfjYd3FbhjGlN6bgQQzB/Byh50js79ZwTYfsfj/F+g3hZpAmtyfUTJpAxR7ig1sMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MPaVJOXl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MPaVJOXl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05lPS1076327;
	Tue, 22 Sep 2026 09:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vqsOS/jPaF5aImqxA
	1W/nEvKFgSLGgldje2Nit9vMVk=; b=MPaVJOXlJhQphm0LEH8sM9ZvM78XeGCF4
	hdjA/v1SaPyGOEQsDqXKizFdb03Vd+tMgN2umi6P6M5PP+6vRlJ11C3pBTNzXpfX
	vQlHh2mMR3hlHlCASEuTBYbVgKGdct/Mf19419fRmyFb5wdB/Ah/YVzrZOVifhCc
	26t9z2FRlgHLEuM7m3nTkxwI6csVemgdfqf+xui8/93gw6jqcZz0+XIs5e7Zbklf
	aVV8/m7yBs1qmPhY/cO8uaTYPlQTfpjnZ2nP2KGfAlJi4NPh8LTK0tUy7HvP7mNU
	hmSaMJ1+NEV4XyBdvEc5PgjD1N7sxNi5FCp1eqmPYVKKgpSvR8Uhg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1n36g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 09:59:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M9wFw62995396;
	Tue, 22 Sep 2026 09:59:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy92ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 09:59:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68M9x6uT38470102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 09:59:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E21720043;
	Tue, 22 Sep 2026 09:59:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D63BF2004D;
	Tue, 22 Sep 2026 09:59:05 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ehn-de.ibm.com (unknown [9.224.79.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 09:59:05 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        brueckner@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
        maximilian.immanuel.brandtner@protonmail.com
Subject: [PATCH v2 2/2] s390/sclp: Implement resize for sclp-vt220 console
Date: Tue, 22 Sep 2026 11:59:03 +0200
Message-ID: <20260922095903.1595794-3-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922095903.1595794-1-maxbr@linux.ibm.com>
References: <20260922095903.1595794-1-maxbr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Py_GigdbsBCo4a8YQU-o8Vfl65k2DUZR
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab2516f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ckP8Zc6KB2J5pO4mnlEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEzOCBTYWx0ZWRfX3yAZtmN0ghHv
 RfTMk5CWxNTxSw0eNp5I3vchjP3GDUVTLgqDch1YgPuwbHl1aLFjIJGaDeku/aou/Et/SkWBcYD
 OtNaNxGSOXtDCUpc7fcDCJYAuD7kch0=
X-Proofpoint-GUID: THsrUwAyg_nDhLTidDF1kdm-5WNCMInE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEzOCBTYWx0ZWRfX+ZXV0oUD206j
 yWu46Cuk1p/r79hTjvzV1SBJMkJ1jC4vDdWLb4yTjRtqThLGe8bfXJxBPw2tuCz89fv08F8FdvO
 iKsWzhIRoZEtTAZ7FpEBaFYwudhy4oKlcw4qzrAS46d9s6eB2avVlbp3w3XkgtEjjQ32Yk1JmeR
 MgoYQO16zVw9t7kpLwes9zEhFkL6E82ln3iNd3sNnQkoJLlAnY8iN94OlIMULAJ4fEsBwXsXHtz
 8tGzmtCc48Nq1EXQm95XXStuomWteIXEzF6PVlzvGajtmY+JfVn96ecfBR9cPj8pvoffip6sIaz
 fRT33+DsXnKVIjH8oebby/DiaHPaOQPZdeCeP7VgX4nqJibdosHWo1H9FGjT7XzK9HHgEhXa2Lu
 0ZSbSlclkES3ieVksTxhJCnX5txC3zTVTQwAp+qt6GPn6GAY5Mv2FdJMr6qL6GireNk683/Pjow
 29xZlE/9vEeFr237C8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220138

Add support for sclp vt220 resize events to enable host-initiated
terminal resizing when using the sclp-vt220 console.

This allows QEMU to dynamically resize the console. On older kernel
versions, these events are safely ignored as the kernel drops events
with undefined tty codes.

Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 drivers/s390/char/sclp_vt220.c | 64 +++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 6dd176049..f5bdca7a8 100644
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
@@ -546,6 +594,9 @@ static void sclp_vt220_receiver_fn(struct evbuf_header *evbuf)
 		sclp_vt220_handle_input(buffer->data, count);
 		tty_flip_buffer_push(&sclp_vt220_port);
 		break;
+	case SCLP_VT220_SESSION_RESIZE:
+		sclp_vt220_resize_sched(buffer->data, count);
+		break;
 	}
 }
 
@@ -555,12 +606,15 @@ static void sclp_vt220_receiver_fn(struct evbuf_header *evbuf)
 static int
 sclp_vt220_open(struct tty_struct *tty, struct file *filp)
 {
+	struct winsize ws;
+
 	if (tty->count == 1) {
+		spin_lock_irq(&sclp_vt220_lock);
+		ws = sclp_vt220_winsize;
+		spin_unlock_irq(&sclp_vt220_lock);
+
 		tty_port_tty_set(&sclp_vt220_port, tty);
-		if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
-			tty->winsize.ws_row = 24;
-			tty->winsize.ws_col = 80;
-		}
+		tty_do_resize(tty, &ws);
 	}
 	return 0;
 }
@@ -754,6 +808,8 @@ static int __init sclp_vt220_tty_init(void)
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

