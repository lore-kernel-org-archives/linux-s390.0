Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAC8456291
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149218; cv=none; b=UgmrOKImienQHe6RzmBwyjolakOPX7DQSIBegnxCz5734PECFMt7p6ekx1lnCxN6WxTTwV/LgD7KncDtAN3Wp0rfM0z1dtncC/UGnPHm6RoiGMC0MWbMTgSJuMCKRNNT8EfwARl3UZuDTGRud/qVcm3wpvLzdBj/9+6ukrQNxTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149218; c=relaxed/simple;
	bh=/CCmjUxW2mYaByrh5k0MOIrQ96O73ON9MAqIUb6FfJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hch0r1cR8R40K6wYk+MnN3tLKVNqV6e98E7+edhzUI8xp8kVmkIP0cyAyY8REyktyUfRdZZVB19PmlYhjO4Vpr0cCRW8vZWd10NPL1amR7EdxtqiGl+V1PU7mPw80QubQrCqebKvXmL/Kf3UHcoWwPgBAyeEmQ7sQWOBKnWIlgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aLB0VwCV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aLB0VwCV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N78rjI2567411
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=b+9bRs/4MuZsdgSrn
	MfJj6ljDmJvYhiXZBwiVzW7Zk0=; b=aLB0VwCVkHPoY5FgSe4wbAOh4Y1Z1IPxe
	TqcJf2Ccg5uJiUMCYn99T75IbMfDtNpbysr0y3zyTKD/GwrZ+1mPCjoD38UnhJkx
	Svb8R8njuTzJaaP6eG/R/XJrcNZPq8IV8zpMhRv+6JfiXPlSXkFy07zUvaClYcKY
	hMk/0YdvfTQ41xqTWYlPaaDALDQeSxEascnlX8GbgEFtZzbiGXOiHyclgmcyh0BL
	qk9caV2VD7ylkp6wxpqBkY0Lprj9/lWELCiWDvdc2YivZbveJhUglmKsJ+elzXvT
	7HO1oo1kEXYyYbOCQ38OTvVzsje0eyRtC/zlK29teGXeaULwH11KA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1hgcr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N7HWkg4052715
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjw9xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 07:40:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N7e7Mm52429238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 07:40:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF6242004D;
	Wed, 23 Sep 2026 07:40:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E0032004B;
	Wed, 23 Sep 2026 07:40:07 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 07:40:07 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v7 5/5] s390/sclp: Ensure no callback gets called after sclp_unregister() returns
Date: Wed, 23 Sep 2026 09:40:06 +0200
Message-ID: <20260923074006.3962077-6-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923074006.3962077-1-egorenar@linux.ibm.com>
References: <20260923074006.3962077-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UintWroQnIOjhCDTDu6wMsFVP8IdudPB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzMCBTYWx0ZWRfXwtvL1In2ULC2
 8eXvI97jK0pGhXGhuyN4tQr7a9AUDxZlI2LnxCXa+5+aGuOvcAdtW9BFGvrHar7K6nttP0E9RNp
 frVtZLBgFCbLvqmj9iCyuIYvObtqTyydpu0t1c9kfPa3MzYZTb6QDt2ffifKiiZG+oeMU5UOofz
 R+WO3ZXEG+35l6dHZ5DVS1Y44q4ftrdqNs7TXyhbpyaggtz9IIgdQhd53MxUnPHP7LXCGC0wwi/
 J6CSAxTohTioJK1cPRgesx/PJ/d7hoemKNdMjR7mFUM86xtGPm773qs9DeM+fEpdY0tVF9EamnN
 5YiHoFGEhQXCJxmbriLY4SgAGSPxyEPm4bOy6ypdXyKQnTKOlHlF0FUId1f+UODd/o9ioB4lg6S
 UKhkDyuaEJVNAxVNOta+DhJ+KRHItcyC3+zEZYaRn5E7ZiJ1Skmt1F0yvcncZxdOiqpXpisssK/
 QSYSi98udLjDjH8A7EA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab3825e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Op0lFPL3nzr5eK-xEWoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzMCBTYWx0ZWRfX4VBUjebWOe/t
 TDrsycLS9RAkdLdFrLSKO3qUAA2WfNmpwabtNOu/SRWD7OYftp7uNhsYNl8ojOPHo8VuT0WNJ4J
 6K/y4tltzTn9EfQAx9SZd65uAHoOKL8=
X-Proofpoint-GUID: UintWroQnIOjhCDTDu6wMsFVP8IdudPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230030

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
index 5a4e4001dfa8..55b928a68593 100644
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
@@ -598,6 +601,7 @@ sclp_read_cb(struct sclp_req *req, void *data)
 		sclp_dispatch_evbufs(sccb);
 	spin_lock_irqsave(&sclp_lock, flags);
 	sclp_reading_state = sclp_reading_state_idle;
+	wake_up_all(&sclp_state_wq);
 	spin_unlock_irqrestore(&sclp_lock, flags);
 }
 
@@ -908,19 +912,26 @@ sclp_register(struct sclp_register *reg)
 
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
@@ -1046,6 +1057,7 @@ sclp_init_mask(int calculate)
 		}
 	}
 	sclp_mask_state = sclp_mask_state_idle;
+	wake_up_all(&sclp_state_wq);
 	spin_unlock_irqrestore(&sclp_lock, flags);
 	return rc;
 }
-- 
2.53.0

