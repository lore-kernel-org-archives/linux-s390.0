Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310254;
	b=QiItcoVViFnFL+EHWsSq/50CGGnpAuhp5fARyF19ghlIcMB8fM5kYnS2cYjQoGgGD/Qi
	 WEC9BI/Sy4DgJv5uBZFijNLoUkYFkE1RD1nDR/JT8xOu/9h5V/KLQp7wBFQ34/bf+Aa2W
	 /ti7MZFXfbTeLIenHd6EJiRsTAtxNw1me7NanJgFOcDB8PI1+CTQdlK5TlnE4zc19KCI8
	 cpqHqt1mlkb5nNpIhKZD7FyoyL+x/R/Lt/aTLKQMZOz7DlNf/uj8avrio0lLM9Z+uIEJo
	 gCktXg6rAUCR9GhpZWPV3mUbCT4VzQSqvnKqNt6ag7XP3xv/4USGR/RL92QNjTSU64A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310254;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3HINApeqf0nk7uQuhKlZYaSBsQPY82iM4OMet4Xu1OU=;
	b=eD7KrR7muK7EAeHu6CLmBBoXcC7HTJ0R4vqNon3CCJAWyPm4c2rGAv073vvuQWEFH52Q
	 p6dPIJOum8QiobtiFdT3zltjyO+PGKvgvzmj6F6NGo3tZK7X1tfwc0qAjdjwSrz5Izc1E
	 VpJ8eaILmWiyNy3tyrgu0FbRk7aAu0JOjcCo27SwxR/FTisKiGuzuKB+OLm4J5RF3xiCP
	 E4IpDPGdRtYwaYgOPRksUKFgRozrYuRdX9VrSBV0oIPKIIfffnNWqQUyvEmdMJ9xYjzQW
	 LCrz0u0wSr2qCH9C3JJxtBU8JEzTtgygDh8NxmMw7+WXUOvF9q88Tp20g00cHHB9viQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qj93EeTl;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28375606A326
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28375606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qj93EeTl
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABEin4963009
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3HINApeqf0nk7uQuh
	KlZYaSBsQPY82iM4OMet4Xu1OU=; b=qj93EeTlOhwzhIVQ+8LBmEYiFP8DeMysm
	bBh5oxZ/ot3OqETyZVX539pcs0XZXYYfa+xhHk5xrkxIYlTpu79QPIW/76GCiKqe
	IV1joUw19FAp2Bzi4XBqq2ty7wa82VrUoAghfrrrFdTqPvNlrLiE+FqADrMR9Lz7
	vlcmdLdH4IsEvziGz9Y7J6bd+8krw8D4ylSS31PEPilUNnNM7o0IImw2Z2w15oSM
	eSyshl0v3QEZOB1Im8ZTc/8hjfFHsto9IbEhmiTnqOIhT8VcoEwMVy9/e4LCzo7W
	6LDKDhoQoa2obt7Rju7jgFRBWN5hV7pA0RAnggRHWoZFTSBFdTuKA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg45fg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABJxEd1771060
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthp7ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 11:30:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AABUm3W37880132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 11:30:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DA3F20040;
	Tue, 10 Nov 2026 11:30:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63D852004D;
	Tue, 10 Nov 2026 11:30:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 11:30:48 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: oberpar@linux.ibm.com
Cc: gor@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH v8 5/5] s390/sclp: Ensure no callback gets called after sclp_unregister() returns
Date: Tue, 10 Nov 2026 12:30:47 +0100
Message-ID: <20261110113047.238367-6-egorenar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110113047.238367-1-egorenar@linux.ibm.com>
References: <20261110113047.238367-1-egorenar@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af3006c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Op0lFPL3nzr5eK-xEWoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfXx+/2ZhZ9gUrZ
 9aTmBtCUjDUO8lPmnxVWSvz/kVMiBsGmcdowOil0tBRZMDrG/fvtwPMlX5aOtqMF9Sn6OGnqNWN
 PYrCpW2v3jJlyKq3mPKE9xfCxS/9zHaet0beMECVKTHQUPm0IaAmcI2jpre9p6PtaDJIIZuSL+1
 yYB+g92Kniyq0mExpDzIc5GKRv53EYxIR7qI3FC8E8zmbjQUKqRX4VQ5b59GC4S8SnpY/dW87ZH
 7Rune8Ni5jQSRKtECqutc8anvFoXBRcv1w1gAKVFzatiVyTmuurxiAANMN5fGYjWcOwH4ag18Rl
 CO88VFVDHDZBHMylHR20uux/QwYBmCLmOQ1xiExRFI/LDiO/w8fv0KfTcAKe4PguscLf0ex8vFR
 QrcOd822SfudccMEAm1LjaZkIi4ci94Mb6B6Zc6fdSKqvf6cI5jm4zY2sR0msfloFQ30CuOEiaa
 1JCqJ/kfzGrxnd4DTfQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX2gEVZDAN8OtI
 RD8EYrqdAS9+fKL/TKuOGbseMTq911b9ccUK+/ejXxEUnn8HxMQnQZMvLSntq7imGYt3fTLiAka
 YDyLr3bDqn67vW7pBbFwZXrHvgS0vJA=
X-Proofpoint-GUID: PlinNGTEwOdz9yaQKcoPvuRB4Wr_8A9V
X-Proofpoint-ORIG-GUID: PlinNGTEwOdz9yaQKcoPvuRB4Wr_8A9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100044

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
 drivers/s390/char/sclp.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 5a4e4001dfa8..e075a86f6194 100644
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
 
@@ -908,19 +912,27 @@ sclp_register(struct sclp_register *reg)
 
 EXPORT_SYMBOL(sclp_register);
 
-/* Unregister event listener. */
-void
-sclp_unregister(struct sclp_register *reg)
+/* Unregister event listener.
+ * This function may sleep. Do not call it from atomic context or
+ * sclp_register.receive_fn().
+ */
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
@@ -1046,6 +1058,7 @@ sclp_init_mask(int calculate)
 		}
 	}
 	sclp_mask_state = sclp_mask_state_idle;
+	wake_up_all(&sclp_state_wq);
 	spin_unlock_irqrestore(&sclp_lock, flags);
 	return rc;
 }
-- 
2.53.0

