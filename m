Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AABF43F0A7
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628314; cv=none; b=BA3DSKru7Js0uknKbbKJc/Lwc0ukcVr0jaOWZ2yImI9l3yxhlZOS/qYp+KqvZ7Qpz5lMqMKCOqo2pMSXJu7AvbGiVXn9a04EA/i2OWauE8I0hzyXifzPL+t1riNeYUcTjZBUIbQyfKA992Nx3j3ETs0LCnS8yg94i736NzynYNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628314; c=relaxed/simple;
	bh=61bvNdcvXinCm8jhs+jhia6ea0hwZnredJt39lVf7aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=no/cC4TzldTkOjOLz/pUumrcO35+cLr0DRufMiB9qjH7NYPGmOAKEZUfo/adJSdTuqx9H2ZLE6sVqGFcWpqZCOxKNJ7A4/neGQEHJ30Av68Sbb9wxnK5dXOJetM0wADZ+ZyyNIPJ7gWEh8bOW9DY7T9tL/bDeSdbJbJJDiDRLfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dwoojQ04; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dwoojQ04"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H62URZ543251
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8ZyYusOc+aXMt0p7/
	iiv5wcEKyzRiybj/KBD4/vJBDA=; b=dwoojQ04Zi3Y1inOh2qkB0oyithqKY0GF
	arJOgFQ0IblDPChDgz9pNct58kwyw6dFVMuvnDFzeyjpLA8SqpqV1Z7NPkU1rEzf
	VgrRMatzsxq0iV3rCRwMimxPFHtK6IgNc8uqlBGRpEec5ISucxEoB0uzcu33e1TF
	SOXaSReWpdfeluxe8jU8Qh0C43dMJD9obqfkpjC/1/4rv3ScE04oxJfFjjDzD9Q+
	hHbX3xFpDEfx+BCQiMeU1bZyGRHvTpRmsXKUjT5rneE/rPigsGxghU1LPmkKj4mB
	7umG6WGa7MA6mG4enYO6me70OE4uu5rAnnYwnqUXd/C01JU4CBp8Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e8grn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H652hL2723228
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yr8th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 06:58:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H6wP1g28836216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 06:58:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB99320043;
	Thu, 17 Sep 2026 06:58:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE8DD2004D;
	Thu, 17 Sep 2026 06:58:24 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 06:58:24 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v5 4/4] s390/sclp: Ensure no callback gets called after sclp_unregister() returns
Date: Thu, 17 Sep 2026 08:58:24 +0200
Message-ID: <20260917065824.2858737-5-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917065824.2858737-1-egorenar@linux.ibm.com>
References: <20260917065824.2858737-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA4NiBTYWx0ZWRfXxO9oBEQ+W/ic
 Qx0wGT0E6uD0+zkQFZ/syz9HH6jyQ7CS70yA+ixpQoqY4yzaTisENdob1WpjPL9CezJf1R0fWwh
 zEuvCV6/xDbROZe2LFzRtQfHkgIWYjn9f0Wdj4Jg06blsMyHRXhFC9A0/b2DYNeY+uq5MGhgLZI
 8n8/SOJdVeZObnnoYMYHYq76HBWrM2lPAmk+buED5q8rKH19KqvEtB4QrVGrA1m2IPJdOvznPW4
 q9A3gc1eEyh4wHyhsNw7ykOB1ZWco0i2o7+0Vvi1gOfQdw26gRvFBBzDJTxrjdD4WXgyrWlEgVC
 6BOZYGpGI43fl8/TXTZjg9gX89CXVHYtXv3+bPbuAYB/Pro/pB39YjQZv1ruG7FD/cXSDMlMWDN
 Dkkb6xDAmQ0H0ErG/ItE+l/mcKwSCCrZRIY5spgsCx/6qt56L18gC8G/HbI6XTfutWQ8I3i3cmQ
 xp1yl9+RLuE2SD+BOyA==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aab8f96 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Op0lFPL3nzr5eK-xEWoA:9
X-Proofpoint-ORIG-GUID: 13Lh4SLi9HMCq_6iGvxd8SiIlV7yjg7D
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA4NiBTYWx0ZWRfX9E47jKB0RHld
 4SAhyxA9As+slp/7j9oU/zrzpG/nictm/h5LI6VQ1Bq8DaN4U8HnHwxUU4I0eCMvdEyHdOt2N3w
 FCKWYQ/SGaNW+qZ5R63QrTG7Mb4CiBM=
X-Proofpoint-GUID: 13Lh4SLi9HMCq_6iGvxd8SiIlV7yjg7D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170086

There is a potential race condition between sclp_unregister()
and sclp_dispatch_evbufs()/sclp_dispatch_state_change(). As a result,
it is not guaranteed that the callbacks registered with sclp_register()
will not get called one more time (and no more than one) after
sclp_unregister() returns.

The basic idea is to use a single global wait queue which is woken up
when no SCLP WRITE_EVENT_MASK and no SCLP READ_EVENT_DATA request is
outstanding. If both are true then it is guaranteed that no sclp_register
callback could be in-flight. Once the struct sclp_register given to
sclp_unregister() is removed from the list sclp_reg_list, no further
callbacks can be scheduled for the given struct sclp_register and it only
remains to wait until the SCLP driver becomes idle.

With this change sclp_unregister() may no longer be invoked from atomic
context or registered callbacks. But this represents no problem because
this is no regular use case and no driver using sclp_unregister() requires
this at the moment and likely should not require it in the future.

Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Suggested-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 drivers/s390/char/sclp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 98e334724a62..c064234314bf 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -20,6 +20,7 @@
 #include <linux/jiffies.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/wait.h>
 #include <asm/types.h>
 #include <asm/irq.h>
 #include <asm/debug.h>
@@ -67,6 +68,8 @@ static struct sclp_req sclp_init_req;
 static void *sclp_read_sccb;
 static struct init_sccb *sclp_init_sccb;
 
+static DECLARE_WAIT_QUEUE_HEAD(sclp_state_wq);
+
 /* Number of console pages to allocate, used by sclp_con.c and sclp_vt220.c */
 int sclp_console_pages = SCLP_CONSOLE_PAGES;
 /* Flag to indicate if buffer pages are dropped on buffer full condition */
@@ -588,6 +591,7 @@ sclp_read_cb(struct sclp_req *req, void *data)
 		sclp_dispatch_evbufs(sccb);
 	spin_lock_irqsave(&sclp_lock, flags);
 	sclp_reading_state = sclp_reading_state_idle;
+	wake_up_all(&sclp_state_wq);
 	spin_unlock_irqrestore(&sclp_lock, flags);
 }
 
@@ -898,19 +902,26 @@ sclp_register(struct sclp_register *reg)
 
 EXPORT_SYMBOL(sclp_register);
 
-/* Unregister event listener. */
-void
-sclp_unregister(struct sclp_register *reg)
+/* Unregister event listener.
+ * This function may sleep. Do not call it from atomic context or
+ * sclp_register.receive_fn(). */
+void sclp_unregister(struct sclp_register *reg)
 {
-	unsigned long flags;
+	might_sleep();
 
 	/* UREG: Event listener unregistered (b=caller) */
 	sclp_trace_register(2, "UREG", 0, _RET_IP_, reg);
 
-	spin_lock_irqsave(&sclp_lock, flags);
+	spin_lock_irq(&sclp_lock);
 	list_del(&reg->list);
-	spin_unlock_irqrestore(&sclp_lock, flags);
+	spin_unlock_irq(&sclp_lock);
 	sclp_init_mask(1);
+	spin_lock_irq(&sclp_lock);
+	wait_event_lock_irq(sclp_state_wq,
+			    (sclp_mask_state == sclp_mask_state_idle) &&
+			    (sclp_reading_state == sclp_reading_state_idle),
+			    sclp_lock);
+	spin_unlock_irq(&sclp_lock);
 }
 
 EXPORT_SYMBOL(sclp_unregister);
@@ -1036,6 +1047,7 @@ sclp_init_mask(int calculate)
 		}
 	}
 	sclp_mask_state = sclp_mask_state_idle;
+	wake_up_all(&sclp_state_wq);
 	spin_unlock_irqrestore(&sclp_lock, flags);
 	return rc;
 }
-- 
2.53.0

