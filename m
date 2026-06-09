Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD52BEC2C;
	Tue,  9 Jun 2026 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011485; cv=none; b=JI8QI4++vE7yUuaxDE7lJJIGiY479YXxDZMa30YjNd6SpaxKpMrnDvIvJQUWCCg1aAmpq1dfVNKn5Tkxg9tijLmkrV4G+TPtghyL5JGEe8jPUPnnqPf6s4kDDSY0UfYY6O0A/WvW39e6i5e+/JUCBlYHtk8Ed1SRepDB1hooQVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011485; c=relaxed/simple;
	bh=xq2p7cson1B2XC4e0SH5lSosMS32+LfJfrBZbtBn190=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GNi/VZttBGwPit+ykZdacFxtNukWZu4YE3a7o2Y58JH1xRod7GXe3V09p7368YUZzrvWpTlIhWGojgvdOWtyDHJqAawvDZsP0/6zEC2jBvdduZTJpF96575Pmm93SAuqnftcwgST1pmIytgt3mIjYqFESAsu35rNz2/FJbZTxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W0TRZU+f; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W0TRZU+f"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658LikVF2487309;
	Tue, 9 Jun 2026 13:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=THNgtg
	3XFJBtRprAQGoPR1UEtOSqwzk/dgDV0OOCDXg=; b=W0TRZU+fA38X8tVfbWUOOX
	obYVa50nhyQ6cpU4SpDMmCzMmPBkf0/u4tSt0AmsAD86Q01JLpd7INaGd2622ztn
	usxy+5VF13UvGuxr1Dw+xXZXUH2UjFeCszXdOxyaND54/ytklmHt43z2mt2yhYs9
	LDFie8rXLPxkILaysZh5RAiWOoo7h0fUGBJt4nwhkbqVBVab/A3Fv0o4Z9Z53TOW
	zS/cOc2cwcLkc1UjkbUYlFZiPs5ME49GgI8acDu+q4/f4tHh7GO4jdRSqnvPsTTy
	2jfFQ/PerIT0d3T5X5/hv55Dz10yH2NWpgxsvpDbraf1LswZg6guCzH99nm6ltUQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6sv157-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:24:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659DJaAZ003794;
	Tue, 9 Jun 2026 13:24:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq29tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 13:24:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659DOSAj42140096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 13:24:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B5F220067;
	Tue,  9 Jun 2026 13:24:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 628092004B;
	Tue,  9 Jun 2026 13:24:28 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 13:24:28 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Tue, 09 Jun 2026 15:24:22 +0200
Subject: [PATCH v2 2/5] tick: Remove arch_needs_cpu
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-idledriver-v2-2-21c2f581d11f@linux.ibm.com>
References: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
In-Reply-To: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>
Cc: Mete Durlu <meted@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aMiKjf8TzD0A_IiOh2MWSD1R68ENl2Hh
X-Proofpoint-GUID: aMiKjf8TzD0A_IiOh2MWSD1R68ENl2Hh
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a281411 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=-_MXh9RRoCZl6R2akIQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyNCBTYWx0ZWRfX+n3XZNRsqxvR
 kEZ0SqD879EqKlVd34GK7F2KHjqFMUFZ8j41qP+2y7INmgAhh3Zmb+EUXbDLAysKQj+8XdmbUOn
 YG2nbnRIzphpvfeXrYqu10cdb6qK2X14DBYeRQxXuscR6pSWYJwG6fAnkDStCs2r3XeL3iaGEGp
 6fyydFbGp6DuQkmPMMe7vWPF4qeoukHUcaNAedybFomsZFIZTbqu6DcjKdHVd3x5sKuynxf1FHd
 OZkzx1Qr1bW3T+/4+KLVxqjqKE19bysHm82SqrfLt6y+5dBTFbwjcxG/OAo7/4SizliWo5YbFhf
 Gki6YzqnKkp/7AzcxFdY4TGjTMtcDCxivRsCQ+5dPS1LJh/C3OvN8bqEUy6KvR/FKAuCoUJN53l
 HrdQuwHV+FCNPovwizygq3zVObutYKWGti6R7bu95kInuqmVkjHGr2vtiNG1QbQ+qRNTAnuZI64
 HiYht4W6WvsxVp0pQVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090124

Remove unused arch_needs_cpu() hook. No architectures use it after
s390 removed its use case.

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 include/linux/tick.h     | 3 ---
 kernel/time/tick-sched.c | 7 +++----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 738007d6f577..0f6757f81839 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -44,9 +44,6 @@ static inline void tick_unfreeze(void) { }
 
 #ifdef CONFIG_TICK_ONESHOT
 extern void tick_irq_enter(void);
-#  ifndef arch_needs_cpu
-#   define arch_needs_cpu() (0)
-#  endif
 # else
 static inline void tick_irq_enter(void) { }
 #endif
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cbbb87a0c6e7..cee18999d818 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -943,8 +943,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	ts->timer_expires_base = basemono;
 
 	/*
-	 * Keep the periodic tick, when RCU, architecture or irq_work
-	 * requests it.
+	 * Keep the periodic tick, when RCU or irq_work requests it.
 	 * Aside of that, check whether the local timer softirq is
 	 * pending. If so, its a bad idea to call get_next_timer_interrupt(),
 	 * because there is an already expired timer, so it will request
@@ -952,8 +951,8 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 * minimal delta, which brings us back to this place
 	 * immediately. Lather, rinse and repeat...
 	 */
-	if (rcu_needs_cpu() || arch_needs_cpu() ||
-	    irq_work_needs_cpu() || local_timer_softirq_pending()) {
+	if (rcu_needs_cpu() || irq_work_needs_cpu() ||
+	    local_timer_softirq_pending()) {
 		next_tick = basemono + TICK_NSEC;
 	} else {
 		/*

-- 
2.54.0

