Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB293A4520;
	Thu, 18 Jun 2026 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781784068; cv=none; b=ORBipK+IIJ+zikKN6t4HPQ/gKi84bN8SeQM5CKsPGzKr7mD0ft98jSdHl5M/FkrxR4UX8uG0K23szI/c97F7/XVPx6AhLBeVLHmytIKHcp4lSHXNql9E9aHLfiKiEBDp0CpN0d5OeAoMLwb8pyy3vrN7ShQOMbIXn4wjFCxpvjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781784068; c=relaxed/simple;
	bh=Hkj2u7+67wCxY6jE7ExcSwuK/yQKA6Z3AMpRNSaPSzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evyki6AtI9I14o9F+42C+jffQUYpkbh1K/auKnVgCsTqTGWKdIVyZ9fk/zwod3vYEyX9WC4vS4J3DMxUtv3YYMepF/sB1e82+5Z9i4Xvl8YxjgePVO9XE0XHxEAY2y7yml41b+3TkDElWgYN3lx7VZ+adeyijby3IjtkuBsK0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l/VdtUo8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l/VdtUo8"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IBI8s53430548;
	Thu, 18 Jun 2026 12:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w7O+YT
	Lf2B59MRiKbdRtGhpgli0FZMdB4P6KgrgEnz8=; b=l/VdtUo8serSr5L/jGn3RF
	JNcb13pNqoM+UDwhwpjc6MW7OwOfetEEH0t5XlVyWzG/JPBRDhC/ybUfd1QA682T
	YVROUrFulVS0YX+2+lww7MjEmsL/cdJbxF7xYpzCGTsmhsAQzzsPDtaklWN/92Gf
	ZIDEKjsrggTVSUlv6pzJEoajJcjHV2cEAM/KVjbT4cL/ZMU1+Er3ICRxpALlEUGG
	0RlDuqvOD1Oh1k68A+/+x10z907LEod7bIhwGSJ2IDGh4JPEV+Pnj3lYKBCmwrKG
	g0u4E815ino8Vlw4e+cgYvx17g4JqcJJ+lBYY4p3885d5+7Zf1IRtUi0px0aDxNQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ7w3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 12:00:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IBnuWf024898;
	Thu, 18 Jun 2026 12:00:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1723je0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 12:00:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65IC0ls348562480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 12:00:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7D7120040;
	Thu, 18 Jun 2026 12:00:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B3A220043;
	Thu, 18 Jun 2026 12:00:46 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.73.152])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 12:00:46 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Thu, 18 Jun 2026 14:00:16 +0200
Subject: [PATCH v3 2/5] tick: Remove arch_needs_cpu
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-idledriver-v3-2-684061eecbcb@linux.ibm.com>
References: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
In-Reply-To: <20260618-idledriver-v3-0-684061eecbcb@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExMCBTYWx0ZWRfXxooNMOHh5kj5
 RHrCV8Soa4hsplSVklZWCkMbgdx4TjOvBKM/cOsrECnmoAMzZzfEG4o/gNCVhWLYp6ti1iutYY1
 f8n/vMb61E0BH4dBN6k/5iXu3apsRzY=
X-Proofpoint-ORIG-GUID: i9u4iA8PxP0CYv7_s5IS5AhJjSrPZC0A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExMCBTYWx0ZWRfX0wxaNi2XW+wl
 pJ9VJqDcKz1mFfq9+UeRGP5E+5K25O5qD/D3U7kswHNhkiund/OMEpmNAVP4y3rXPm8EHBwPqYB
 l2IXkp+IfS+ohwMsXiXZaJfViRftkIWktEgo2MdvXRz2bLgYMmx1ZCY0kdE8sabxe1RHKfe8HbS
 G4jA3UGxjWXIW+jnfXagNDAeYSDP2GT8fjoApne3+i/m4pC5LomOWRfOMtBnLnAHA09cYsgA+bF
 l+Hq1UpTKezG9DCn/0yfFtU1RifVrevytZCUZObSGV8TR2Xy7ckFtf/IRj7yJD4pKi0g3lqHz+N
 h7dmrgIa8yRiQzmrCdN1UVW3iR1xtJ6MUh5Cel9sqyvxziXYlxYCzjSdUgy35mxXZUzGqwkvose
 7YO7Ipbwv2DKxe6h8L12XVduK1YsdxSDjD7QeKC3gqFoHuh3bxLKoUyf/Pee5N1XaP7/2xfuGuw
 L6MH5Oc2d/WWSHhUI5g==
X-Proofpoint-GUID: i9u4iA8PxP0CYv7_s5IS5AhJjSrPZC0A
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a33ddf3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=-_MXh9RRoCZl6R2akIQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180110

Remove unused arch_needs_cpu() hook. No architectures use it after
s390 removed its use case.

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
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

