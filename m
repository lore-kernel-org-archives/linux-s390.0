Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC202D7DCF;
	Thu,  6 Aug 2026 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020772; cv=none; b=RPqF38aSyCJCP9LIVkOgJc9RboHeET4W3mWfmHFSOxmBxNwT6e44xbeluVTzD+ExoaDEGx3nHJE8OaimqM2wc69bRmxvcWdqyZeJT+ocYv0+5TpvVgN32i1DrJn5/lifaub5maUamo2ksTf8QB35zxdOxZdlp9KE61JRHNXfl24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020772; c=relaxed/simple;
	bh=hjjnI1MXEXI09Y1b7ykTecuCiHDdkGp5cFhgfmkUcvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DmSRIrFkhvNX27rCBcEbRdoRu0FpOQjIkkf6c35zLGmm8mpLYbrJZmxaiKJcZBOTut9mdoFJs9Iff5K9OlX6s2t2nQPUk7y5yZ06rPvsM4P4QVKBo44J72o9HPgxg0ZWoD5+mV/+7xdQtIcD9t30B7S3Jhlos7Hfd2/lrN/1+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MfL1Am8x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MfL1Am8x"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Nm8hh994563;
	Thu, 6 Aug 2026 12:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ySk0FzCfC3tsHDqGJ
	ZguY7EGlrGUwwQsm+sLbBejnhs=; b=MfL1Am8xs3g6DNQDjxcqjIgd3cY1szi1s
	kVUHPfq3j9BLhkvJBxW3WEOXj9ojraQnfJ7zNytTDzW+nWCCUFmJMYRan5oM0Gt2
	zDQnEChTtcml8W6ID6c+Ofz/PAWOJ87Q/yuLahOa45/z7/JW3jBeEdhjhZzWJ/Mn
	Ppe8WvjaXjn5d4pm6aY0IwTnAysfocyzdHGcz86PLOX8Rbt2C3ojAAiAN270ge6p
	t5n6U7UJHGZf5LUj8QFfdR4qAaZVCIUe/mh0GFX9v2WvLDWc/Na5Vm0m4tTaY26f
	U9lzHFqQTJOvggT/crfZ7PKKxTJpNUd2P93fvgLdUIv3yBbV15dmQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hywne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 12:52:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676CfHtN027502;
	Thu, 6 Aug 2026 12:52:47 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwb9e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 12:52:47 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676Cqkbx30671386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 12:52:46 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BBD458057;
	Thu,  6 Aug 2026 12:52:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 935D458059;
	Thu,  6 Aug 2026 12:52:44 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 12:52:44 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 1/1] KVM: s390: Fix memory corruption by not reinjecting CK machine checks
Date: Thu,  6 Aug 2026 14:52:41 +0200
Message-ID: <20260806125241.210170-2-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806125241.210170-1-borntraeger@linux.ibm.com>
References: <20260806125241.210170-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfX1O40zegIeIF+
 2pGakgO1QIFjtJhEeyHk5WiprT0Njx+xyScrRO0SmtG7h3okudEun3w0znmsvnw5h5zk+pighmo
 vlBv1R+DyRJ1lZ2Nsb6JmQG2M1R6kqs=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a7483a0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Ij1Uxg02dGBQ0jy1ERMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfX6ehZ6qlOtFmG
 EQuwkZ5BDC4JhhgjZ+QRS0j6QQ8Cer7dLJkpD8jWXMzit7k+IplaUWBF7xqiblZmw83W3gbrYKF
 n/rwBjwSBwlbZh5Mwxa78ETsWX/hAU2w/0A73oFIfGSjmABXA3xaTvnimhM82yYWAkbJyzBKMHL
 uplFWQdHrVJ9cLvM5XMBgKyn+K5erV7k8FCD1EjOEaCaNhqSHuCtjM/UlKly2xX0UCPo9OQCsfH
 QmlhOUEX+GGaDTId6OwEe+rxhfi3pEVk/qzzMsaDJms2H2UB+mFPfy99uvI9g0RXhVqGpDH1WDP
 QF6WL+v9wVQwTuu4ISLYr83IZZ+2mZ+Z1M7BzP8OniUbW484iUpKH6vmm1g2WWDyroCpAPhSHyI
 LYNuGrQAcgFZ9G6OOXHvtqKjCxzkjc6OIGsuF/wDXQ+JQmi3GisXPNHdBH9XHnkdbXM7/SWYvZF
 pxHjjRL8G+RrmA9b1+w==
X-Proofpoint-ORIG-GUID: 3WQ_odPRyt6b1G1Tnvmgk0wc8lTCkABJ
X-Proofpoint-GUID: 3WQ_odPRyt6b1G1Tnvmgk0wc8lTCkABJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060101

Channel-subsystem damage machine checks are for the host channel
subsystem. The guest channel subsystem is emulated in the userspace VMM.
There is no point in forwarding such machine checks into the guest.

This also simplifies the machine check reinjection and avoids kfree of a
stack variable as reported by sashiko.  There might be still machine
checks that have the ck bit set with another bit (like instruction
damage), mask out the CK bit in s390_backup_mcck_info(), like the CP and
ED bits already are.

Fixes: 4d62fcc0b692 ("KVM: s390: Inject machine check into the guest")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/include/asm/nmi.h |  1 +
 arch/s390/kernel/nmi.c      |  4 ++--
 arch/s390/kvm/interrupt.c   | 24 ++++++++----------------
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
index 6454c1531854..dd26c20bd231 100644
--- a/arch/s390/include/asm/nmi.h
+++ b/arch/s390/include/asm/nmi.h
@@ -22,6 +22,7 @@
 #define MCCK_CODE_SYSTEM_DAMAGE		BIT(63)
 #define MCCK_CODE_EXT_DAMAGE		BIT(63 - 5)
 #define MCCK_CODE_CP			BIT(63 - 9)
+#define MCCK_CODE_CK			BIT(63 - 11)
 #define MCCK_CODE_STG_ERROR		BIT(63 - 16)
 #define MCCK_CODE_STG_KEY_ERROR		BIT(63 - 18)
 #define MCCK_CODE_STG_DEGRAD		BIT(63 - 19)
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index e17a59d4d5a4..652b98795243 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -345,7 +345,7 @@ static void notrace s390_backup_mcck_info(struct pt_regs *regs)
 	sie_page = container_of(sie_block, struct sie_page, sie_block);
 	mcck_backup = &sie_page->mcck_info;
 	mcck_backup->mcic = get_lowcore()->mcck_interruption_code &
-				~(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE);
+			~(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE | MCCK_CODE_CK);
 	mcck_backup->ext_damage_code = get_lowcore()->external_damage_code;
 	mcck_backup->failing_storage_address = get_lowcore()->failing_storage_address;
 }
@@ -357,7 +357,7 @@ NOKPROBE_SYMBOL(s390_backup_mcck_info);
 #define ED_STP_ISLAND	6	/* External damage STP island check */
 #define ED_STP_SYNC	7	/* External damage STP sync check */
 
-#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE)
+#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE | MCCK_CODE_CK)
 
 /*
  * machine check handler.
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 009d6a845d59..0d9fbe75dc66 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3108,9 +3108,7 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
 void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 				     struct mcck_volatile_info *mcck_info)
 {
-	struct kvm_s390_interrupt_info inti;
 	struct kvm_s390_irq irq = {};
-	struct kvm_s390_mchk_info *mchk;
 	union mci mci;
 	__u64 cr14 = 0;         /* upper bits are not used */
 	int rc;
@@ -3129,20 +3127,14 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 	if (mci.w)
 		cr14 |= CR14_WARNING_SUBMASK;
 
-	mchk = mci.ck ? &inti.mchk : &irq.u.mchk;
-	mchk->cr14 = cr14;
-	mchk->mcic = mcck_info->mcic;
-	mchk->ext_damage_code = mcck_info->ext_damage_code;
-	mchk->failing_storage_address = mcck_info->failing_storage_address;
-	if (mci.ck) {
-		/* Inject the floating machine check */
-		inti.type = KVM_S390_MCHK;
-		rc = __inject_vm(vcpu->kvm, &inti);
-	} else {
-		/* Inject the machine check to specified vcpu */
-		irq.type = KVM_S390_MCHK;
-		rc = kvm_s390_inject_vcpu(vcpu, &irq);
-	}
+	irq.u.mchk.cr14 = cr14;
+	irq.u.mchk.mcic = mcck_info->mcic;
+	irq.u.mchk.ext_damage_code = mcck_info->ext_damage_code;
+	irq.u.mchk.failing_storage_address = mcck_info->failing_storage_address;
+
+	/* Inject the machine check to specified vcpu */
+	irq.type = KVM_S390_MCHK;
+	rc = kvm_s390_inject_vcpu(vcpu, &irq);
 	WARN_ON_ONCE(rc);
 }
 
-- 
2.53.0

