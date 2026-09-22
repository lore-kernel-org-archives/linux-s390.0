Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524B3F9264
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059392; cv=none; b=CiH+rNFg81rbDKurdEtgT43fiK1M8tVSmJVXGjDoRgcmUeLeGGlI7RUoDiHWO/3bkOql/MW8AYn+EVKFOrH57hzt440yMGfPuFgSLJS9bWck/+OjL8z7GH/d0json0LocljGems6BAS8TTDE7zNnHSvnku6nNFv5ELW4o0F/Ye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059392; c=relaxed/simple;
	bh=jkM38InhHKHNA6pX5VHjMIajS/yUwUSFaOUEEwiMZXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBMgPrk980be8Qbdik0hSlQd7Yd+M+qn8nmCZb3o4RR6L6mTsOSFyp0dpaQ7c4ku0WQq25GnDcuTzCPQq8HtOqOREgxHnRquxeqxoNrqV61RNx9lqFHJ+zcq3seHn8AvMBE6sm56gL8PlNeNmzJqmYdYZ+lc6FoYcp29qrUU/fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hsvbidX9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hsvbidX9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M05VuW2948544
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5pGaJ1ZbF12suQoo7
	l4VpQY1U/1I/YQJN4KjQUr7g60=; b=hsvbidX96/+/KW9m2/c3lMMjOYjDVgYtp
	mHOJag0ZwT2X24/ZYxjyhG2KHylC9sf4t6HdzzkcIHHfJljP++ZNpEN5mGb4WWZx
	q4YPZ5EfMyThNKbvOj8/W6nVSh5787ge+Z6E44gwqhy2pCBxo8OhEC/zEYx6uY3Q
	h/wQ5g8GSWE8SWVfGbAnDfsGti7v+gq40Wh51TZrRHLpFraDEXcFVym+X6oM0gNi
	oom661TRu5po9oppS8pJxep4nUPVBj/q/ftWCgLen3ZewvcXUrJgJOX9CNfo/OEo
	hwACN37edyN6Iyk61ua+w+iOvHl0k0DfSWOM3Gx8ypaMEpo/BYsiA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs4b47-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68M5j0Fp2024880
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vgrjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 06:43:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68M6h4lM50069860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 06:43:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39FC02004B;
	Tue, 22 Sep 2026 06:43:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D51220049;
	Tue, 22 Sep 2026 06:43:04 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 06:43:04 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH v6 5/5] s390/sclp: Ensure no callback gets called after sclp_unregister() returns
Date: Tue, 22 Sep 2026 08:43:03 +0200
Message-ID: <20260922064303.524293-6-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922064303.524293-1-egorenar@linux.ibm.com>
References: <20260922064303.524293-1-egorenar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab2237e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Op0lFPL3nzr5eK-xEWoA:9
X-Proofpoint-ORIG-GUID: BMcbAXIvZrLvhwHXvl2cXrpUoxSjw0ME
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA5MyBTYWx0ZWRfX+vF4+kShkqHo
 XX1H2ELy7c2gXEly/r50f4Bzcvir9GAKotIrveDmJgw6VbT3aV27rnGafsRbdhqm8ZZ0TX+19JG
 UGzd+gNUXyteJ46DDVIDvyJf7Bj+0VUeYmxULu9v7Wu02wN0YtZ6vVhkY48tpVFpQ2edZdhnana
 KmxUwO+dYTPlfMyCDBXVWp6y7xJsxxjNOhRssjbJOSWMv10ziJbwwe6w44F3h/TVw7ewnTn/nnP
 sSnwCt1IKH4PWWg0e5rW3+zDya1sozj/6jZwgK/Mt4L0YO6yTEzWWxsDwFkMhLeXvOpl58/gP4s
 qhHPbrMw+yebnk6d6cfvz/XgK9ymBo3dflDz07YLKTjMKaN323Xiy8YqiIY6OH5n2QLQpQ2ybtR
 GmIUtB58grhD1euBexdM/k7n8BQnpWacw1mOfQu2WajY1/fNc3ZNaDIuzY9rJG4t1bg5PPbfu9f
 EbhKsmv2ild689rho5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA5MyBTYWx0ZWRfXw7qS43/tvIVj
 qPL3EWIZYlWN62eB2N7qWLmvj63DNUzdfrtOCT017Rd2XqjZWE6spji8efTOyqT0GgGTQzHWBFA
 1gvONjP4yY7iMtp6vSnHxJYzQY2AMgI=
X-Proofpoint-GUID: BMcbAXIvZrLvhwHXvl2cXrpUoxSjw0ME
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220093

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
index 7be4acec9d6e..eccc3f2fb491 100644
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
@@ -589,6 +592,7 @@ sclp_read_cb(struct sclp_req *req, void *data)
 		sclp_dispatch_evbufs(sccb);
 	spin_lock_irqsave(&sclp_lock, flags);
 	sclp_reading_state = sclp_reading_state_idle;
+	wake_up_all(&sclp_state_wq);
 	spin_unlock_irqrestore(&sclp_lock, flags);
 }
 
@@ -899,19 +903,26 @@ sclp_register(struct sclp_register *reg)
 
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
@@ -1037,6 +1048,7 @@ sclp_init_mask(int calculate)
 		}
 	}
 	sclp_mask_state = sclp_mask_state_idle;
+	wake_up_all(&sclp_state_wq);
 	spin_unlock_irqrestore(&sclp_lock, flags);
 	return rc;
 }
-- 
2.53.0

