Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9672F12E1E9;
	Fri,  6 Mar 2026 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795971; cv=none; b=ucqW3uHupZuW6qxetOyFlQpA/cJWToRzmpXwMMwsLJ6vm9ADyj+YBv6qoMMSUJRV1liFL7hBLdyD+LZd3w2jIg/IwUS4OnMiIvX6PgQ0ydMIbJZJiluMvrVBTdhEFwPZiQABEZ3Qv3kb1v2fmC3eeU+fvxw/K58FK63mUc7/Aj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795971; c=relaxed/simple;
	bh=FVXgimc7hYhVZdjImMgc9xuSJdkHKf8kgQNZNe60XMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKbicet7NGgctsDIYQ/vtDY2mEVc7S9cemU7UgGD22Yt4Peq7qqq0Aql7tZK5KIOtYjtFHygOrL0rRAr0q04ZpQ2lV9Om26nq5frF/lZvQE1d1tTICIjolv+teqPfaiaM+MfkWtUxaQFZoYpb0WV2MVS/5zCYTla2Jk267KW4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DcUWBUpk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DcUWBUpk"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6263AXhI1479574;
	Fri, 6 Mar 2026 11:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+VY0NTXHbw5l0FaPEa2VoC1N8a8ZPfUEyOG1Oq3zb
	UM=; b=DcUWBUpk0ycZ4p7ICHo+SDtklUij6e5McF72pU6NMtwfpzhpKFaarZoAb
	dwi/YqB71R87RT2xyfzyu52sFZG9+f+trwGdEk93bd9n4kH16H/p/pZToR2Rdx71
	Ee7fPHEZxD20dx4xSq0fGgNiOjQNkIYVVo/eZhJR+CEvBnwpNeMQDGCaor1v8fE9
	36Bs6mtqxEWK974hWndkADwEsqHC2FhtoBxt1Q+ENHIvem4PauXojLXXIVLEQDGS
	awP89chZBehVBY0FvPXVj3TiAPtzzqPlkYIIeeOUT/9Yb8LnB0Y74MWtSBC+MiNK
	j9UI0HGuIpLUf12/hEKHxCxw066AA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk47mtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 11:19:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6268AQqB029112;
	Fri, 6 Mar 2026 11:19:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmapsfqhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 11:19:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626BJKOu51052944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 11:19:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B0EA20043;
	Fri,  6 Mar 2026 11:19:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA2E820040;
	Fri,  6 Mar 2026 11:19:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Mar 2026 11:19:19 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390: Revert "s390/irq/idle: Remove psw bits early"
Date: Fri,  6 Mar 2026 12:19:19 +0100
Message-ID: <20260306111919.362559-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5TfbbHl-YnPVOLQqoTEn0a2Ui4QNzY5G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEwNiBTYWx0ZWRfX3h1OBpqZmhtp
 Zfh2gi9JUfQIe+RvENDLgDJ/CEN4ABiwhvZSbOqSBT8g7f+UcksxJjcdUhNIqWtFOKfuGbM3j/X
 TU62A9wXsnBAx2Wq0R+XNdssbOueTsDPFTXvHhU+S1263L8PEHARWCbHIH3u9mzfkwR1cSZ/1NC
 WSIGorVPWSeseSJT67GoPEzEHIyR+qaNobcriE8cXiKjzJCsSpbIGQD17YbhYZunv5lw0IKWL65
 U29TcmfGFJBP+YXICHE/BkI4jLDDRMM1dVUfCkZ6enoZBrtJpJDC2yvSPPhA2VKxmQpD/F3q43p
 f1cX50dOe009dyS4sclDWn0VXSjUulC3r8q408zTc0cjbVVGQRnsEyoL9/FqKDO50c+DqIjIIsu
 aNcwMpREPryuA5pm9yclr4ukfGnBoQ2sJmj3oC8auAczDoZAe1cbGnGrCfF//w44KghU7UQki5A
 StYpK8gsj2Irbrd9Quw==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69aab83c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=JfrnYn6hAAAA:8
 a=kd2kxvcDy20aSqqAPpEA:9 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: 5TfbbHl-YnPVOLQqoTEn0a2Ui4QNzY5G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060106

This reverts commit d8b5cf9c63143fae54a734c41e3bb55cf3f365c7.

Mikhail Zaslonko reported that linux-next doesn't boot anymore [2]. Reason
for this is recent change [2] was supposed to slightly optimize the irq
entry/exit path by removing some psw bits early in case of an idle exit.

This however is incorrect since irqentry_exit() requires the correct old
psw state at irq entry. Otherwise the embedded regs_irqs_disabled() will
not provide the correct result.

With linux-next and HRTIMER_REARM_DEFERRED this leads to the observed boot
problems, however the commit is broken in any case.

Revert the commit which introduced this.

Thanks to Peter Zijlstra for pointing out that this is a bug in the s390
entry code.

Fixes: d8b5cf9c6314 ("s390/irq/idle: Remove psw bits early") [1]
Reported-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Closes: https://lore.kernel.org/r/af549a19-db99-4b16-8511-bf315177a13e@linux.ibm.com/ [2]
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/irq.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 7fdf960191d3..d10a17e6531d 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -147,10 +147,8 @@ void noinstr do_io_irq(struct pt_regs *regs)
 	bool from_idle;
 
 	from_idle = test_and_clear_cpu_flag(CIF_ENABLED_WAIT);
-	if (from_idle) {
+	if (from_idle)
 		update_timer_idle();
-		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
-	}
 
 	irq_enter_rcu();
 
@@ -176,6 +174,9 @@ void noinstr do_io_irq(struct pt_regs *regs)
 
 	set_irq_regs(old_regs);
 	irqentry_exit(regs, state);
+
+	if (from_idle)
+		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
 }
 
 void noinstr do_ext_irq(struct pt_regs *regs)
@@ -185,10 +186,8 @@ void noinstr do_ext_irq(struct pt_regs *regs)
 	bool from_idle;
 
 	from_idle = test_and_clear_cpu_flag(CIF_ENABLED_WAIT);
-	if (from_idle) {
+	if (from_idle)
 		update_timer_idle();
-		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
-	}
 
 	irq_enter_rcu();
 
@@ -210,6 +209,9 @@ void noinstr do_ext_irq(struct pt_regs *regs)
 	irq_exit_rcu();
 	set_irq_regs(old_regs);
 	irqentry_exit(regs, state);
+
+	if (from_idle)
+		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
 }
 
 static void show_msi_interrupt(struct seq_file *p, int irq)
-- 
2.51.0

