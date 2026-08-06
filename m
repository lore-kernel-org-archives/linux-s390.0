Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1333A83B1;
	Thu,  6 Aug 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028325; cv=none; b=UaV0dExHvnK7uq4JhhNGWDbhm4Zj3YBxvA2tZHqQY2KPmANYF9KYxETe1ILFWDmFV6Xe6xs643HJJ2y5FesBMqCLP65LHD8Lx/UryGhHSs2fbFj6KiBb4FHrwIHS/r3v1yuOvRKLkUgkw9//EJmgjZTSi+g1+Upku73erzUe9fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028325; c=relaxed/simple;
	bh=gSthjE0XukK7pCeJp3D3pZ4bI5+3ufEHoKqgemeESPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TClShRSvcC5aEP/rCmBQC/Whw+YKdL7woVJ7PBO+SJA/ag4syNaQtH6R4o9WhlplBWBjLZ1fLzWjtG/GDHRq4cAcURRW9E9C0hd8lddhFD6sSyaZWXXQxMvKXEP+2aHcffFdDxqQTpMDKwr1jE8agGEsphPG0Jk1RbLcBOvbUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T7WQXojL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T7WQXojL"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EnvlK2867500;
	Thu, 6 Aug 2026 14:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1YzAvVFsl8fwxzuBr6WYYJDA/zCx1s6oYeY28kgGU
	UU=; b=T7WQXojL8ddx8EdHpGp1hqSucuuIV5HswlqJYe4G2rOAvfv1zggMna5Uv
	tZWPiy/vjBz3WUOHHvF6TPkPgLX8mjYhqGFpZxxDK5TFHqo1Y7+mjwCm9uLjXznk
	D2sOAB8yZC8ewruTPixOp/nbPKRyS2KtMyE2jtLiTt80j9mDBGaQMdRY5wgQE6BS
	VXWvOx9KB2cnba4R60ajWHiLBqPpb7IctZNMuXXhvAD/AU0mRP7lX9oB3iv3Xiir
	93JiuR32SD0ySqsb+4SrjjArBYoOiFVA/H4VM30lNIV2UEhvpw23BP/ZRJejfrml
	umeVKVyGV7Obiw0A1I4QfxIKiphSg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77ggbks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:58:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676Eugwp003358;
	Thu, 6 Aug 2026 14:58:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhkj5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 14:58:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676EwcUn15205090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 14:58:39 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B590958067;
	Thu,  6 Aug 2026 14:58:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C929258059;
	Thu,  6 Aug 2026 14:58:36 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 14:58:36 +0000 (GMT)
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
Subject: [PATCH v2] KVM: s390: Fix memory corruption by not reinjecting CK machine checks
Date: Thu,  6 Aug 2026 16:58:35 +0200
Message-ID: <20260806145835.31818-1-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfXxReh3cA5b6DI
 gOei49iQH32hw60dnf1Afk40dX2ApmnNlFCZUlEMdqqsy8ucd41ugeBIu5v9mpfu2u8PaNpKygn
 QdYpabskSFxieKO1WkI/r5wweAr3KhBQzpn60InH1dBJ+E8b6Xr6/SVvSoQKfY7ByQ17gQ3Kbm/
 g+bcQaZ4qY1p4493YPA0SVhSfhpoIHNsKIcLj0AWfX7KqI+49/grB/wDjzMFgzxjwWxUBpCkISJ
 6+JeYrVCrEnd5b6VrBGnAJFjYEJ18GxPgMtL9uxgeqEuM1vnxRfbpsGlSdED+Ob6SHkojFZjQnG
 4HA+O1t+g6k9b5phLNR+VeFPe3ueisBQKRUJtkJ72XAoXLFDhCZRFSki3B9PiC4Oys2STvTVNrc
 foKqo8yCOM+P76MHXwze1SeJlrQCRr2aMYobW/A0uAkr7Bd5iwI2meJpP2H8+oDPBrh6ujDREPt
 Lq3VNfsmIS/F0WZq7Rw==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a74a120 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=wvZ6b-M3Fnr1N7NqwM0A:9
X-Proofpoint-GUID: Snev5Wq0SsnMBPwF-PQiXmivY2XajRhm
X-Proofpoint-ORIG-GUID: Snev5Wq0SsnMBPwF-PQiXmivY2XajRhm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExNSBTYWx0ZWRfXy1tHV252i4aJ
 3mMBvqmw1Ue+YkAbnF/5pUVUFOeZV6M8M+McosjMjIh4XDyMDD5EFm/r5Cdrw5VcyK688lyLzUh
 usy5Bc59zAukChmq/MWaxF75JFyfw3Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060115

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
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
v1->v2: move MCCK_CODE_NO_GUEST into nmi.h and reuse that

 arch/s390/include/asm/nmi.h |  3 +++
 arch/s390/kernel/nmi.c      |  5 +----
 arch/s390/kvm/interrupt.c   | 26 +++++++++-----------------
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
index 6454c1531854..7919b2b9ac9c 100644
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
@@ -33,6 +34,8 @@
 #define MCCK_CODE_FC_VALID		BIT(63 - 43)
 #define MCCK_CODE_CPU_TIMER_VALID	BIT(63 - 46)
 
+#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE | MCCK_CODE_CK)
+
 #ifndef __ASSEMBLER__
 
 union mci {
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index e17a59d4d5a4..17297a8b63d9 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -344,8 +344,7 @@ static void notrace s390_backup_mcck_info(struct pt_regs *regs)
 
 	sie_page = container_of(sie_block, struct sie_page, sie_block);
 	mcck_backup = &sie_page->mcck_info;
-	mcck_backup->mcic = get_lowcore()->mcck_interruption_code &
-				~(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE);
+	mcck_backup->mcic = get_lowcore()->mcck_interruption_code & ~MCCK_CODE_NO_GUEST;
 	mcck_backup->ext_damage_code = get_lowcore()->external_damage_code;
 	mcck_backup->failing_storage_address = get_lowcore()->failing_storage_address;
 }
@@ -357,8 +356,6 @@ NOKPROBE_SYMBOL(s390_backup_mcck_info);
 #define ED_STP_ISLAND	6	/* External damage STP island check */
 #define ED_STP_SYNC	7	/* External damage STP sync check */
 
-#define MCCK_CODE_NO_GUEST	(MCCK_CODE_CP | MCCK_CODE_EXT_DAMAGE)
-
 /*
  * machine check handler.
  */
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 7514d9e2403c..3375a956637b 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3099,9 +3099,7 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
 void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
 				     struct mcck_volatile_info *mcck_info)
 {
-	struct kvm_s390_interrupt_info inti;
-	struct kvm_s390_irq irq;
-	struct kvm_s390_mchk_info *mchk;
+	struct kvm_s390_irq irq = {};
 	union mci mci;
 	__u64 cr14 = 0;         /* upper bits are not used */
 	int rc;
@@ -3120,20 +3118,14 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
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

