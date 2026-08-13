Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA0D48382C;
	Thu, 13 Aug 2026 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632073; cv=none; b=rlr99TFgnIovCXLqUSkLmPDpHEXNT2Y7h0ft3s3iLWPwlo0/nwonfN/1p4kUBUVB35vWxxMC5Aa7rNgvt/bfksxV3I682Z0zgiFHdATyxfjPEj+QH8TSgaL4W7NNtI7+LP/eUIU6zC621N8cdAVnyfmmNvP8Cgms+tuKsFNpzHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632073; c=relaxed/simple;
	bh=Iyk2JV95tSq4ztD+KS78ajphudPkKBACk0JGzx7D1jY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpZdDPgtRm1hlIPl5KvAqGsyV8rVD/gepuXGvMCMJ4AkXjGcO4gcAVaPipk9VQxPc9wp36h3qgcY2y3pb7tcvxmXIlHm3b1VyeIVFcuxVoPLQzxdst5IIgp9HxhjXdru1VDuXABsnpEvbaUMGJTs0AU9fuw6WalDpCu5kWojY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LzZs7v1y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LzZs7v1y"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCVvkq2343830;
	Thu, 13 Aug 2026 14:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=408NWkW1yitQng7Zn2YpK4z/fWkNhTcM5jgsJXtkn
	o8=; b=LzZs7v1y87UuQKCXQ/mHv/57plRRKlD1AaPEQ20df/Hlsyt22XP+e0qqI
	DvL1rtYq2JQyJCfiHYPGCLYPFP+2HqWGcSLv7Qi+gQX4jhJu159q2D//CGPuyiKe
	YrMYcZiVeXLKfitUAht6V1V4HGr8ocPk8s2tsOTEaAmaVa1GzMoGB60rcr34iFb6
	YWwSUm5DkveE7cytcJLOoF3b4b3IzcS9WvrdwP8x9bcucg5Rzvg/gt4H2MF8YIn1
	QUZEctv1MsneoYZICNVaRpOgj/bQVgYq81D/hZcj+2XqlWSkc6zMN9JwVQPGHyp/
	UXjLaxUCnuXA+bEDyrDLapdz7XUYw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvma0f0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:41:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DEQQw3000996;
	Thu, 13 Aug 2026 14:41:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesqbh53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 14:41:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DEf6C030540396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 14:41:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AF3320043;
	Thu, 13 Aug 2026 14:41:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C2FF20040;
	Thu, 13 Aug 2026 14:41:06 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 14:41:06 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com
Subject: [kvm-unit-tests PATCH] s390x: firq: Trigger KVM flic injection bug
Date: Thu, 13 Aug 2026 14:40:15 +0000
Message-ID: <20260813144058.7125-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEwNCBTYWx0ZWRfX98DyL2eWWqjD
 EpqVIxPprKS2t9jDrl/eGbC879X+IopunkhJ4cp2RBTW+6R2jkiY6toJW8D8/roIyGU9WgserUn
 mXYi9mUNBHze88E0JFyDJNZtFArsBDMISD3JMW2MkdVEUTc0LSgftv08nPstYK7NzJhmKrC0ugL
 dzZzL1xbxW/DotCj4zqL5TdfpUkpuqpUucMk7qqg0sxpy8yDVP9Ga2fAIhxw2k0VkCEPPCZ9IlQ
 QOgR9J0TYG+IMZ/ZXgBNWl+9oRmPcICdchmT/3T8TuFVFWm3B24WiwZKid1VwS+3j3pJXhpMTT+
 kkseNAuEhuboZVwxNBidln042Bf/ImIR5zMxPVFI3W9EwtVf+ygza5pZURkDPZ/GL3IpmBy02DG
 TleWMxNbtPy8k9vMFQy0/Lb/FrNFYDDiks/WSN5vMNOBsS9Kxutwy5sj6W2Tx2Sgv7OYYnRqIRT
 hKgWAls8NSG8EjL4kNA==
X-Proofpoint-ORIG-GUID: NZ1ZczN1yhw5XCRSYjPAoS51Ej-d1_5v
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEwNCBTYWx0ZWRfX4p7qau5hNhhY
 nWNZ+pRibJQaLME2woHzPkMY1Z3rdoIypmTTnJmm63ZWMBeQ7CvWU2GUYuOj+8ygkjmSTcYKTLb
 G0ACsyM6Kpu5/4YIdyqyvKFZgkNilKs=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7dd787 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=_3riuKPKY6kcDDI9-FkA:9
X-Proofpoint-GUID: NZ1ZczN1yhw5XCRSYjPAoS51Ej-d1_5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130104

The flic will try to wakeup the last cpu that went to sleep since it
might still be in halt poll and therefore fast to take up work
again. Problem is that there's no check if that vcpu is even enabled
for the specific IRQ that's being injected or any other pending
floating IRQ.

To trigger this bug we setup a third cpu which enables its masks for
external calls and goes into enabled wait AFTER the second cpu went
into enabled wait. This will set KVM's tracking of the last sleeping
cpu to the third cpu. Once the service IRQ is injected KVM will wakeup
cpu #3 which will promptly go back to sleep and the test hangs.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 s390x/firq.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/s390x/firq.c b/s390x/firq.c
index 0d65d87f..03638a14 100644
--- a/s390x/firq.c
+++ b/s390x/firq.c
@@ -17,6 +17,12 @@
 #include <smp.h>
 #include <alloc_page.h>
 
+static void wait_for_ext_call(void)
+{
+	ctl_set_bit(0, CTL0_EXTERNAL_CALL);
+	wait_for_interrupt(PSW_MASK_EXT);
+}
+
 static void wait_for_sclp_int(void)
 {
 	/* Enable SCLP interrupts on this CPU only. */
@@ -57,6 +63,16 @@ static void test_wait_state_delivery(void)
 	ret = smp_cpu_setup(1, PSW_WITH_CUR_MASK(wait_for_sclp_int));
 	/* This must not fail because we have at least 3 CPUs */
 	assert(!ret);
+	while(smp_sense_running_status(2));
+
+	/*
+	 * Move CPU #2 into wait so it's the last that entered sleep
+	 * and therefore KVM will try to wake it up first since it
+	 * might still be polling. But since its masks are not open
+	 * for a service IRQ it's not a valid wakeup target.
+	 */
+	ret = smp_cpu_setup(2, PSW_WITH_CUR_MASK(wait_for_ext_call));
+	assert(!ret);
 
 	/*
 	 * We'd have to jump trough some hoops to sense e.g., via SIGP
@@ -90,6 +106,7 @@ static void test_wait_state_delivery(void)
 out_destroy:
 	free_page(h);
 	smp_cpu_destroy(1);
+	smp_cpu_destroy(2);
 out:
 	report_prefix_pop();
 }
-- 
2.53.0

