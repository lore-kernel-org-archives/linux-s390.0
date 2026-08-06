Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3B03033EB;
	Thu,  6 Aug 2026 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021460; cv=none; b=g3oeWfGNt0kzC6mU8scGMGeBbAJ1NRLGs9oRGMbyytqk4r8aDxQwJUYK+BVsg7nrowE3auYWG7u6tBwmc+3IBLcoBPD7GF2MWbi3Slvvp6+beycXnCiELpS5IeBmMlsgYZ7h92l1RrpigYFZ/FPw/drULVAYsRdqkC2q7+OaQe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021460; c=relaxed/simple;
	bh=G9vrilfhC2ujlYlXXCHpnOaJ5QBE0QERAVg7cVYBUZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dp4bW76keE+nifBVSRTTnV0FZ3ubOSLSlVAAfGa42KEbbFL8QE5gerlbT1ki00CRj8PnIYvemXxZ+jEylM1txi5oo5LKL2QpK93tcnpTZTk6SgyY5fPhC3+Lnn5JdZiL2n6E4R2Q3b2Ft8w4EMayPy3jV3D+ruLKN9k1m83nh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FMKrKiI0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FMKrKiI0"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NmcFL995581;
	Thu, 6 Aug 2026 13:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cGZTLqLtoj7XyJy0X
	rNYhoChjhfW0ILZ/Cu5+DqvwdM=; b=FMKrKiI03/vvtFvL4pI8/LdOcgXeZDlX5
	jt1t6MniykhRmkmmq29CokrSnssSxFrmC/MAjhCD6e15leMdnQ4HF4UA8gQ0piGb
	3UMXbKYQruqm261c9PIhLsd0nOXe93Vxud0czAn0Na6KJzvBMB3se4om8tQHQDMc
	fKkIe3PCl5umx8beyTrDeSNk2KHd0kQBWAdf3YIYd8WSDtcqINxp38ltchUS1nSS
	LUzaGDcYmjmHPTYvKKoJcfecE4Z7C8cJkNPJ23rbkZg+51AnOoOeV7TWS9J7CFVA
	ra7xIO3cVXEJ8InqQmkMynWohh2oyJHsZ7z0MlMm+qboo+Ixqx5aw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gft7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 13:04:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676CuKBf022034;
	Thu, 6 Aug 2026 13:04:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhk5cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 13:04:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676D4Cqu27394768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 13:04:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5DD15805A;
	Thu,  6 Aug 2026 13:04:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 208D358068;
	Thu,  6 Aug 2026 13:04:11 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 13:04:10 +0000 (GMT)
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
Subject: [PATCH on master] KVM: s390: Fix memory corruption by not reinjecting CK machine checks
Date: Thu,  6 Aug 2026 15:04:10 +0200
Message-ID: <20260806130410.14254-1-borntraeger@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfX4n2T6kyYjeMx
 UK7kIwkaY2WOSJDWvg32kWJCJKPo8KgIl5rr8+2G06sjNT2+U5DXyqcc3EVodstivHhERen4uAb
 UmTKXZHkxa04SQ7+ddL7E+KEMm3OgyrAeYxWEBZqrIpU0jHO5tWd6i9DsxMeNso1kgc0XUDQlL1
 /SMkiVjHHO4CLw1KrLJfzPZrCtVTvTYulRiSvZwZfepZXlFBVJUNr+fuFFmO38Pq2DPqovATK86
 M6DVzYqvbs8TvBmQnuOsqOfVfuOU3Tte/5NVrZDC5+xwba9cwwkJnV9AnvbJTvl+2GkqjMZU39n
 37jybecDnQSdgA09+YzsR6ZknPMmTisDvtfl5pdZRzPX+Mg6mS6adQuAHWPMVHivctLGHy8RhQ0
 uSdJrXYR+eDvFw8j2Hh+rW8jen008xQvaOpMz0cy8GtSrF32x3egZBEVTM0cFTqK8ia/Sc0S8Gg
 w12fp8Ulq9YdSDvMVQw==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a74864e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Ij1Uxg02dGBQ0jy1ERMA:9
X-Proofpoint-GUID: XVz5xv27CkcS6t0drRVd1gpROOUqoJFr
X-Proofpoint-ORIG-GUID: XVz5xv27CkcS6t0drRVd1gpROOUqoJFr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfX10deD56E6LSD
 1JP2gJASt/MzyHA+jzHwEs5TrIuj+OkzXnk1CGowL82Xwoo2dC9yjr9p9ERcECbkUjB0G0rQpd2
 W+KbDiKyiMmqOo2iGk4sPT4WkRuVx3Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
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
 arch/s390/kvm/interrupt.c   | 26 +++++++++-----------------
 3 files changed, 12 insertions(+), 19 deletions(-)

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

