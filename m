Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3711624C0;
	Thu, 11 Jun 2026 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193297; cv=none; b=ocs69TNJJL7WCmTCU1PvMr82QQfWZC3jVgizYgZ5WQbPq65dSn9CVWUp48rWD3maxtoX8i8H73Zcz8Csi3dMnHcogICMfKSUziZziuLKaaXiXuZJvq8envWIGpcccd87KNQtuxpRH1eqUKeR1cgsqHVp49E16daphxVZh1w3CkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193297; c=relaxed/simple;
	bh=yAL9VKBJZnFpEKjQYJ+ntstnobdBBLjst1Isyid1/3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CjGvG3Mrr7//bcFK+chNnjT2EDXtq7GWY1UrXv1CMhipM3VPETSd7cKIt7Dguky2luEvSEZD8LieG0j2xmCUEMZDaPq3ckh0PUSo7dK555HSFZdPXX+xoBT/l1Xg5LDkYr1pY5L86D3Lfn90/EFxvCSAS4yYai/NktPTzyWMisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OGuF7xmL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OGuF7xmL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BBAOJR722217;
	Thu, 11 Jun 2026 15:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O8GMmi
	pXLv7rMtNeu1046PVXR9HvImqf5cbACbSx+jw=; b=OGuF7xmLxGRrC56WyWICIV
	st+plU0v1zVeaPixLYoCf6ei65NuBz6PWJzLNtaDseBEefGicOCqjXIWvIEh58+x
	zYj7/6D1UbsHB2RR/yovx5Pah8j4BW99UCDklYPB2rALqSk/PHOCog7UTMJer/0t
	cO0F3+KZcbzbnpVZ+vKzf88av0Oqib0hdSimtCiTP2aRImKzUL+0QBE5YUsCVZ8f
	CJ+eRuksXDiFMjdDS09OP6ZeqwSWkn9qD86d6fjR2JSmGsDmM0gcZKe/hHjGkRjZ
	msG4asyAU0Ud7eUYef9nsGfC0pzRJOz8Nq1UWFtG9EgTFfGpCJPQyD7i4mbuCeUQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8dcprx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:54:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BFncmk018000;
	Thu, 11 Jun 2026 15:54:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe0a3v6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 15:54:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BFspUp49676600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 15:54:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06F9420043;
	Thu, 11 Jun 2026 15:54:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77A0D20040;
	Thu, 11 Jun 2026 15:54:50 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.87.150.222])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 15:54:50 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 11 Jun 2026 17:54:31 +0200
Subject: [PATCH v3 1/4] KVM: s390: Minor refactor of base/ext facility
 lists
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-vsie-alter-stfle-fac-v3-1-b1a35efedaba@linux.ibm.com>
References: <20260611-vsie-alter-stfle-fac-v3-0-b1a35efedaba@linux.ibm.com>
In-Reply-To: <20260611-vsie-alter-stfle-fac-v3-0-b1a35efedaba@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>, kvm@vger.kernel.org,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4058;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=qlRkQjZsP+83b+0DePHnbv78bt3pmVHnALjg6EIslMk=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlatzwbVx+WC7AvXdWULpv0+kx2YrF/XYb6XNf5r8/vT
 p5vZvO3o5SFQYyLQVZMkaVa3Dqvqq916ZyDltdg5rAygQxh4OIUgIns6mZkOMjjdYxzcm/Y/+V+
 K9RMM59klXVMZtyjb/v6WOO/xXE7PjAyPNgip7nm9pne8xkZedPvZCnmHi/yWuR+4/PjhqsnioJ
 c+AA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE1NyBTYWx0ZWRfXzh1iKZjmrKZ3
 480yRKF5elQqriwagOVvQzrJQHSvyfYvEvGx5cNtdGFhLlcI8dGHTUM6r4qYQn0ng2wNLQblgbO
 Xp8kOXPMw3CyZ5+zzqnANJ7E4UU94i8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE1NyBTYWx0ZWRfXwaw+aO5YX712
 4Rbp1UlX8Hd3pv9RSUvZDQ9W6QVfmUImPZ/J6ypIWvanaH3E67fIlODYd3hFXHDpVJwWfWwmpEC
 GSar5pRP6Ple+FmDFXH0qfsGXpGfXluBIKrPCcaiBE9AzVHpNsuck3b5+bw+hqyhjnppWzaunWQ
 pzvXImBPYbwC9ZZArLJM/LMN8/8otzR4cc67+kz+T7wLhBLDK/9dFR6kSZEK2ooxZ9crP1+o56s
 hI9bLomvjEzLsoVie9EPsgd8nqBmLUGuiHz0ZF5b34knkbhXQBS9ewyJKESWso2S+r6XLU97Q2F
 0k7O1GnkK5Qq76d5fTPGXsw3sq8gUqWtgy2nxa1UZ7DGeXb/jZADjQpyEuIcwzeMaG9MuSWHO17
 AsWoldqxXN2Gf/UiY5Y4n942/8Mo02mGSIMuLa7+ONtNKZ33ZE0085wtLv1YDoKRR8MLTaw8sB3
 3cI3PzwdGR2Z6MymT6g==
X-Proofpoint-ORIG-GUID: kBb-DlSKqr74MlWfm6gNiNXL9IYyRMiN
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=6a2ada50 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=V1mMjla59gyM6mHp8IcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kBb-DlSKqr74MlWfm6gNiNXL9IYyRMiN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110157

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Directly use the size of the arrays instead of going through the
indirection of kvm_s390_fac_size().
Don't use magic number for the number of entries in the non hypervisor
managed facility bit mask list.
Make the constraint of that number on kvm_s390_fac_base obvious.
Get rid of implicit double anding of stfle_fac_list.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ffb20a64d328..2a57ea095b48 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -232,33 +232,25 @@ static int async_destroy = 1;
 module_param(async_destroy, int, 0444);
 MODULE_PARM_DESC(async_destroy, "Asynchronous destroy for protected guests");
 
-/*
- * For now we handle at most 16 double words as this is what the s390 base
- * kernel handles and stores in the prefix page. If we ever need to go beyond
- * this, this requires changes to code, but the external uapi can stay.
- */
-#define SIZE_INTERNAL 16
-
+#define HMFAI_DWORDS 16
 /*
  * Base feature mask that defines default mask for facilities. Consists of the
  * defines in FACILITIES_KVM and the non-hypervisor managed bits.
  */
-static unsigned long kvm_s390_fac_base[SIZE_INTERNAL] = { FACILITIES_KVM };
+static unsigned long kvm_s390_fac_base[HMFAI_DWORDS] = { FACILITIES_KVM };
+static_assert(ARRAY_SIZE(((long[]){ FACILITIES_KVM })) <= HMFAI_DWORDS);
+static_assert(ARRAY_SIZE(kvm_s390_fac_base) <= S390_ARCH_FAC_MASK_SIZE_U64);
+static_assert(ARRAY_SIZE(kvm_s390_fac_base) <= S390_ARCH_FAC_LIST_SIZE_U64);
+static_assert(ARRAY_SIZE(kvm_s390_fac_base) <= ARRAY_SIZE(stfle_fac_list));
+
 /*
  * Extended feature mask. Consists of the defines in FACILITIES_KVM_CPUMODEL
  * and defines the facilities that can be enabled via a cpu model.
  */
-static unsigned long kvm_s390_fac_ext[SIZE_INTERNAL] = { FACILITIES_KVM_CPUMODEL };
-
-static unsigned long kvm_s390_fac_size(void)
-{
-	BUILD_BUG_ON(SIZE_INTERNAL > S390_ARCH_FAC_MASK_SIZE_U64);
-	BUILD_BUG_ON(SIZE_INTERNAL > S390_ARCH_FAC_LIST_SIZE_U64);
-	BUILD_BUG_ON(SIZE_INTERNAL * sizeof(unsigned long) >
-		sizeof(stfle_fac_list));
-
-	return SIZE_INTERNAL;
-}
+static const unsigned long kvm_s390_fac_ext[] = { FACILITIES_KVM_CPUMODEL };
+static_assert(ARRAY_SIZE(kvm_s390_fac_ext) <= S390_ARCH_FAC_MASK_SIZE_U64);
+static_assert(ARRAY_SIZE(kvm_s390_fac_ext) <= S390_ARCH_FAC_LIST_SIZE_U64);
+static_assert(ARRAY_SIZE(kvm_s390_fac_ext) <= ARRAY_SIZE(stfle_fac_list));
 
 /* available cpu features supported by kvm */
 static DECLARE_BITMAP(kvm_s390_available_cpu_feat, KVM_S390_VM_CPU_FEAT_NR_BITS);
@@ -3238,13 +3230,16 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.sie_page2->kvm = kvm;
 	kvm->arch.model.fac_list = kvm->arch.sie_page2->fac_list;
 
-	for (i = 0; i < kvm_s390_fac_size(); i++) {
+	for (i = 0; i < ARRAY_SIZE(kvm_s390_fac_base); i++) {
 		kvm->arch.model.fac_mask[i] = stfle_fac_list[i] &
-					      (kvm_s390_fac_base[i] |
-					       kvm_s390_fac_ext[i]);
+					      kvm_s390_fac_base[i];
 		kvm->arch.model.fac_list[i] = stfle_fac_list[i] &
 					      kvm_s390_fac_base[i];
 	}
+	for (i = 0; i < ARRAY_SIZE(kvm_s390_fac_ext); i++) {
+		kvm->arch.model.fac_mask[i] |= stfle_fac_list[i] &
+					       kvm_s390_fac_ext[i];
+	}
 	kvm->arch.model.subfuncs = kvm_s390_available_subfunc;
 
 	/* we are always in czam mode - even on pre z14 machines */
@@ -5820,9 +5815,8 @@ static int __init kvm_s390_init(void)
 		return -ENODEV;
 	}
 
-	for (i = 0; i < 16; i++)
-		kvm_s390_fac_base[i] |=
-			stfle_fac_list[i] & nonhyp_mask(i);
+	for (i = 0; i < HMFAI_DWORDS; i++)
+		kvm_s390_fac_base[i] |= nonhyp_mask(i);
 
 	r = __kvm_s390_init();
 	if (r)

-- 
2.54.0

