Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669801;
	b=ocmldmI59vFl9n+5q3jFs4MFiOSLNHYvgPHD9aQVRZemu3K23imRcIDShafqMCDtiova
	 4qjGeKLp4PYXEBzLXM8vIpjMTDrGIdkiwvZOTszxoXvD1rEhnQs+nSISgY82KdfuQZhyC
	 tMsgpdEEx2ocXvGd23UMDzgREuTFAw3H5gjeVLX0QilN1TrNuE8ST8KWtbelIZ0T2S0/N
	 CoM90eRW4bM4AsKuMadrOSSy56Vs87uneskGdCwtXEZZaruKaF4iZWgZ0+GaAqOLRhbcG
	 BicWY046qBfjL1CJPKiqiZSnDkEgaf4o57TaXmVTX9aKRypjsBVV0q0p0o+URoPOdUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669801;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mck/RF8Xp1EUI+lc70rJLA425IA+Q5YsBElxrF/ZUUw=;
	b=R5sBoyTdDjeOz0Y7umqzNW7aUtw0eRBH9D/4ja1A38LPLlchbVsIy8MUp96FJTk0AVAX
	 /2PxZ5cbu/71U0n6ZAw31Od8RbJSvzr0y6+7pEZbFSzrmSt/Yxltg2TLqEC4d3TiuRhfY
	 DBrZn8myv1PEbG/GXfLVr0COEsZxhf6rK97qSTeCemle6qyUz81HVh8Mu+PeRkt9FOcv1
	 ujIacR0qsD4cmBBkTCLDposl6i6/FP0J4pQzAQoE90nP8pTRO2LpoL4lsUUhzbI8g3Hqk
	 DyMo0uv+BAZFNjRivcSIeXpU37CWosKnxg87SwHB5S8uS5eggXqySm687lNfUFbGqVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PmRZoknx;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38134606A31B
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38134606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PmRZoknx
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MAEHiS2671197
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mck/RF
	8Xp1EUI+lc70rJLA425IA+Q5YsBElxrF/ZUUw=; b=PmRZoknxH1AlT2qxi0rts0
	6M31omgssMkJcHiYtgvAuWtuvAiuEtAH4CgYClLZ2SB7DbWwtc4v8Y9ciB4zHnjm
	CGCTj6R8B6MZ9B2MdYlafkePv7F/c3VlvTaAaMJhfO39fUJm5ihPPriJwkdL5wef
	lk2s+aVJivXPg5tCQAF4Fz8cGk+Z2N5lK2hSlD7LTPm/QfmKlMnGrJjPM/rwu54b
	heXSwtNhn9vJ97LPcrItMXNbfeX/rC5IMgAf4ajKa820EtcV0WsC8U9x4SKwAI5q
	egP498TnPsbfYh8p4WohmNjxoZKLmFwWPSuSDoYk5brdTNR5ydiZQaT/O7PLoaFA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58ec06-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:49:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA4tBr3331671
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:49:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hefss7jsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:49:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MBnsjN31523548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 11:49:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B632120040;
	Thu, 22 Oct 2026 11:49:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89C972004B;
	Thu, 22 Oct 2026 11:49:54 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 11:49:54 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Thu, 22 Oct 2026 13:49:45 +0200
Subject: [PATCH v2 1/3] s390/diag204: Introduce diag204 rework
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-diag204ioctl-v2-1-7e5a9d1cd21a@linux.ibm.com>
References: <20261022-diag204ioctl-v2-0-7e5a9d1cd21a@linux.ibm.com>
In-Reply-To: <20261022-diag204ioctl-v2-0-7e5a9d1cd21a@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0NiBTYWx0ZWRfX20sKgEu6vOwJ
 54FX/e/jdqe07Nq3UGWLCH4lLznX/5ddEOS97bybPeXQK2+SCcjbwdlj5j5Fjd4VL56EKR6snvp
 kMKh00ig6gqG+hz+1+wtN1Eyn6JYMQ4=
X-Proofpoint-GUID: yS91jWuoofxpLvjKsmvzP5UM7wTaxriU
X-Proofpoint-ORIG-GUID: yS91jWuoofxpLvjKsmvzP5UM7wTaxriU
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6ad9f867 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=WIgZ-4RvoILAnoz7hd0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0NiBTYWx0ZWRfX7LDpKkBCQfYJ
 tLVnXC9rH3fr9RMzZK4kSna+6PqHWAnnJ0tNgQevZsrNwBZSozg1ezMKXguEUtRBVXy9ISQTG8T
 AzWeLUiPIqwVQbNurJRfrRb6fCBAt4XQUCgDJ2M5VjH9iQr7JZC4A8X3ZpAVG7Eww0BbaQEc4Af
 uiaVaENOaRNDAjqCum2AMfIiTrEIMJl35Q3Nr59mNWbyGzNKoY+ne0ePnF+iEcf0fTGE00b/nv6
 hcudlJ0qR9Kq0eKokO9EVKQfeCIPaIhgDoYZZJnCzjMvj9rd1E75HHBuBRNY39DBQ52dSEfmdfv
 XlSK1jl2yPD02hCmyZvHEnUosdwOM8XVx06kk1BbKywNBiPycnlJ9Gu4Mu/PMUBilKQk4wU7YJb
 pTivREteUNCQmi1S5YkmBH7bEGlixXYO6kapC92rY93gHI+28fJgihlCbj+RApVSz7pbwygh5FT
 Jj/4Ihs3b959DseYTWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220046

diag204 is an expensive call, limit its invocation to once per
second at most for all users. Use a caching mechanism to provide diag204
data at demand. Cache buffer gets freed by a delayed work function if
diag204 data is not fetched after a certain amount of time.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/include/asm/diag.h    |   7 +
 arch/s390/kernel/diag/diag204.c | 290 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 297 insertions(+)

diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index 1416ee1ad323..8669cfa039d3 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -336,6 +336,13 @@ static inline bool diag204_has_bif(void)
 	return sclp.has_diag204_bif;
 }
 
+int diag204_store(void *buf, int allow_busy, int allow_busy_wait);
+enum diag204_format diag204_get_info_type(void);
+enum diag204_sc diag204_get_subcode(void);
+void *diag204_allocate_buffer(void);
+void diag204_free_buffer(void *buf);
+bool diag204_is_available(void);
+int diag204_get_buf_size(void);
 int diag204(unsigned long subcode, unsigned long size, void *addr);
 int diag224(void *ptr);
 int diag26c(void *req, void *resp, enum diag26c_sc subcode);
diff --git a/arch/s390/kernel/diag/diag204.c b/arch/s390/kernel/diag/diag204.c
new file mode 100644
index 000000000000..7f366ea12a67
--- /dev/null
+++ b/arch/s390/kernel/diag/diag204.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Request CPU utilization information from underlying diag 0x204
+ * facility. Diag 0x204 provides a variety of utilization values.
+ *
+ * Copyright IBM Corp. 2026
+ */
+
+#define pr_fmt(fmt) "diag204: " fmt
+
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/timer.h>
+#include <linux/vmalloc.h>
+
+#include <asm/diag.h>
+
+struct diag204_info {
+	int pages;			/* number of pages for diag204 data */
+	enum diag204_format type;	/* used diag204 data format */
+	enum diag204_sc subcode;	/* used diag204 subcode for store */
+	bool has_bif;
+};
+
+struct diag204_cache {
+	ktime_t timestamp;
+	void *buf;			/* page aligned diag204 buffer */
+	bool updating;			/* ongoing cache update indicator */
+};
+
+static struct diag204_cache g_cache;
+static struct diag204_info g_info;
+static DEFINE_MUTEX(diag204_mutex);
+
+#define DIAG204_CACHE_EXPIRY (NSEC_PER_SEC)
+#define DIAG204_WORK_DELAY (HZ * 10)
+#define DIAG204_BUSY_WAIT (HZ / 10)
+
+static void diag204_work_fn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(diag204_work, diag204_work_fn);
+
+bool diag204_is_available(void)
+{
+	return g_info.pages > 0;
+}
+
+enum diag204_format diag204_get_info_type(void)
+{
+	return g_info.type;
+}
+
+enum diag204_sc diag204_get_subcode(void)
+{
+	return g_info.subcode;
+}
+
+int diag204_get_buf_size(void)
+{
+	return g_info.pages * PAGE_SIZE;
+}
+
+void diag204_free_buffer(void *buf)
+{
+	if (!buf)
+		return;
+	vfree(buf);
+}
+
+/*
+ * If we use subcode 6 or 7 with extended data format, we can (and should) use
+ * vmalloc, since we need a lot of memory in that case. Currently
+ * up to 423 pages!
+ */
+static void *__diag204_allocate_buffer(int pages)
+{
+	void *buf;
+
+	buf = __vmalloc_node(array_size(pages, PAGE_SIZE), PAGE_SIZE,
+			     GFP_KERNEL | __GFP_ZERO, NUMA_NO_NODE,
+			     __builtin_return_address(0));
+	return buf;
+}
+
+void *diag204_allocate_buffer(void)
+{
+	return __diag204_allocate_buffer(g_info.pages);
+}
+
+static void diag204_schedule_work(void)
+{
+	mod_delayed_work(system_dfl_wq, &diag204_work, DIAG204_WORK_DELAY);
+}
+
+static int diag204_is_cache_valid(unsigned long duration_ns)
+{
+	ktime_t expire;
+
+	lockdep_assert_held(&diag204_mutex);
+	if (!READ_ONCE(g_cache.buf))
+		return 0;
+	expire = ktime_add_ns(READ_ONCE(g_cache.timestamp), duration_ns);
+	if (ktime_after(ktime_get(), expire))
+		return 0;
+	return 1;
+}
+
+static void diag204_set_cache(void *buf)
+{
+	diag204_free_buffer(READ_ONCE(g_cache.buf));
+	WRITE_ONCE(g_cache.buf, buf);
+	if (!buf)
+		WRITE_ONCE(g_cache.timestamp, 0);
+	else
+		WRITE_ONCE(g_cache.timestamp, ktime_get());
+}
+
+static void diag204_work_fn(struct work_struct *work)
+{
+	mutex_lock(&diag204_mutex);
+	if (!READ_ONCE(g_cache.buf))
+		goto unlock;
+	if (diag204_is_cache_valid(DIAG204_CACHE_EXPIRY))
+		goto rearm;
+	if (READ_ONCE(g_cache.updating))
+		goto rearm;
+	diag204_set_cache(NULL);
+	goto unlock;
+rearm:
+	diag204_schedule_work();
+unlock:
+	mutex_unlock(&diag204_mutex);
+}
+
+static int diag204_update_cache(int allow_busy, int allow_busy_wait)
+{
+	unsigned long subcode;
+	void *buf;
+	int rc;
+
+	lockdep_assert_held(&diag204_mutex);
+	buf = diag204_allocate_buffer();
+	if (!buf)
+		return -ENOMEM;
+	subcode = g_info.type | g_info.subcode;
+	if (g_info.has_bif && allow_busy)
+		subcode |= DIAG204_BIF_BIT;
+	WRITE_ONCE(g_cache.updating, true);
+	mutex_unlock(&diag204_mutex);
+	do {
+		rc = diag204(subcode, g_info.pages, buf);
+		if (rc != -EBUSY || !allow_busy_wait)
+			break;
+		if (signal_pending(current)) {
+			rc = -ERESTARTSYS;
+			break;
+		}
+		schedule_timeout_interruptible(DIAG204_BUSY_WAIT);
+	} while (allow_busy_wait);
+	mutex_lock(&diag204_mutex);
+	if (rc >= 0) {
+		diag204_set_cache(buf);
+		diag204_schedule_work();
+	} else {
+		diag204_free_buffer(buf);
+	}
+	WRITE_ONCE(g_cache.updating, false);
+	return rc;
+}
+
+/*
+ * diag204_store() provides users data retrieved from the diag204 facility.
+ * Since diag204 is an expensive call to make, it is limited to a call per
+ * second for now. To circumvent this limitation a caching mechanism is used.
+ *
+ * diag204_store() first checks if diag204 cache is present and valid. If the
+ * cache is valid, it copies the contents to the users buffer.
+ * If the cache is expired, it first updates the cache and then proceeds with
+ * the same copy operation.
+ *
+ * @buf: Users have to manage their own buffers by using
+ * diag204_allocate_buffer() and diag204_free_buffer().
+ *
+ * @allow_busy: If diag204 supports busy indication facility(bif), users can
+ * specify diag204 to utilize it and return BUSY instead of blocking until
+ * data becomes ready.
+ *
+ * @allow_busy_wait: If users allow diag204 to use bif, they would also get
+ * the option to specify an interruptible wait behavior by allowing busy wait.
+ * This is useful since it gives users to interrupt diag204 waiting period
+ * via signals.
+ */
+int diag204_store(void *buf, int allow_busy, int allow_busy_wait)
+{
+	int rc;
+
+	if (!diag204_is_available())
+		return -EOPNOTSUPP;
+	if (!allow_busy && allow_busy_wait)
+		return -EOPNOTSUPP;
+	if (!buf)
+		return -ENOMEM;
+	rc = 0;
+	do {
+		mutex_lock(&diag204_mutex);
+		/* Exit loop with lock taken if there is no concurrent update */
+		if (!READ_ONCE(g_cache.updating))
+			break;
+		mutex_unlock(&diag204_mutex);
+		if (allow_busy && !allow_busy_wait)
+			return -EBUSY;
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		schedule_timeout_interruptible(DIAG204_BUSY_WAIT);
+	} while (allow_busy_wait);
+	if (!diag204_is_cache_valid(DIAG204_CACHE_EXPIRY))
+		rc = diag204_update_cache(allow_busy, allow_busy_wait);
+	if (rc >= 0)
+		memcpy(buf, READ_ONCE(g_cache.buf), diag204_get_buf_size());
+	mutex_unlock(&diag204_mutex);
+	return rc;
+}
+
+/*
+ * diag204_probe() has to find out, which type of diagnose 204 implementation
+ * we have on our machine. Currently there are three possible scanarios:
+ *   - subcode 4   + simple data format (only one page)
+ *   - subcode 4-6 + extended data format
+ *   - subcode 4-7 + extended data format
+ *
+ * Subcode 5 is used to retrieve the size of the data, provided by subcodes
+ * 6 and 7. Subcode 7 basically has the same function as subcode 6. In addition
+ * to subcode 6 it provides also information about secondary cpus.
+ * In order to get as much information as possible, we first try
+ * subcode 7, then 6 and if both fail, we use subcode 4.
+ */
+static int diag204_probe(void)
+{
+	unsigned long subcode, type;
+	int pages, rc;
+	void *buf;
+
+	pages = diag204((unsigned long)DIAG204_INFO_EXT |
+			(unsigned long)DIAG204_SUBC_RSI, 0, NULL);
+	if (pages > 0) {
+		buf = __diag204_allocate_buffer(pages);
+		if (!buf) {
+			rc = -ENOMEM;
+			goto fail_alloc;
+		}
+		type = DIAG204_INFO_EXT;
+		if (diag204(DIAG204_SUBC_STIB7 | type, pages, buf) >= 0) {
+			subcode = DIAG204_SUBC_STIB7;
+			goto out;
+		}
+		if (diag204(DIAG204_SUBC_STIB6 | type, pages, buf) >= 0) {
+			subcode = DIAG204_SUBC_STIB6;
+			goto out;
+		}
+	}
+	/* extended data format is not available, fallback to simple */
+	pages = 1;
+	buf = __diag204_allocate_buffer(pages);
+	if (!buf) {
+		rc = -ENOMEM;
+		goto fail_alloc;
+	}
+	type = DIAG204_INFO_SIMPLE;
+	if (diag204(DIAG204_SUBC_STIB4 | type, pages, buf) >= 0) {
+		subcode = DIAG204_SUBC_STIB4;
+		goto out;
+	}
+	rc = -EOPNOTSUPP;
+	goto fail_store;
+out:
+	rc = 0;
+	g_info.pages = pages;
+	g_info.subcode = subcode;
+	g_info.type = type;
+	g_info.has_bif = diag204_has_bif();
+fail_store:
+	vfree(buf);
+fail_alloc:
+	return rc;
+}
+
+static int __init diag204_init(void)
+{
+	return diag204_probe();
+}
+device_initcall(diag204_init);

-- 
2.56.0

