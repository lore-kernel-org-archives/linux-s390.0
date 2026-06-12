Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B93A8723;
	Fri, 12 Jun 2026 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781266999; cv=none; b=Vmp6yZqqjhNiK3pImdplWp2gUlPBCMynZKXn/p9yQEozcNMPbTN+dgmm0Sga9Fhfbj9QeosKoOrBaZAvOxIU4Paat1gxv5Esl6MpwTUa0bH6dWtnLv5tQ+mc++OFo+JOvgG4XefeveVZ4wZXYSywgJUqq2FRtjF0d8Pv8dLRRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781266999; c=relaxed/simple;
	bh=yAL9VKBJZnFpEKjQYJ+ntstnobdBBLjst1Isyid1/3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DiP61af+Vq1UFj75uQeB2haScjcueCA7jVZhI7ZufFQbo2ZO2YZBYvNTfYL3/HyDeXlwF79QoO1+mhIYb8VGYDpyygiSouaAVH8d0LxFhEqkHVxjKuTZVjfgjiaiYhY7oB43ZUzdeCbIPJBAoOSt1W6pbj81h+b5GOCbvfnQKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jrB07jLk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jrB07jLk"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C1dw1R722246;
	Fri, 12 Jun 2026 12:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O8GMmi
	pXLv7rMtNeu1046PVXR9HvImqf5cbACbSx+jw=; b=jrB07jLk3AO8wTCPwZIsf9
	73D12AECP99T8xL2OLsVQBxs/aMUAFIFJ4yhTDuk2rBAkcKURzU223Sq7uFUAOuy
	aa/RffXBC/G3EbVnpHUjRpPEjvdXO60Wyti3eP+9YJy0Ovdvxb47a4ef2HUG2rrL
	ExKrkIOTG7jH9D5ZYMByRow0v1UAAJR/4XorwKnlHnrmB3doxHPq0mKgJs4Gonin
	VM+XJA8jg2vZWwQijHZgGWFiiqJ/g33+jq2do7MAz7TN+KsJkdt9xKneews4uF5S
	EkGrOMFCN7Z+FmtrVtK6RIiiTnvi1aiNADPEam6xvnDyHvdsUe8vf4l/DOj7Cjxg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8dgx06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 12:23:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CCJbME026493;
	Fri, 12 Jun 2026 12:23:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09yrs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 12:23:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CCNDYk48759092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 12:23:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 437A220049;
	Fri, 12 Jun 2026 12:23:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75D4920040;
	Fri, 12 Jun 2026 12:23:12 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.8.71])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 12:23:12 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 12 Jun 2026 14:23:01 +0200
Subject: [PATCH v4 1/4] KVM: s390: Minor refactor of base/ext facility
 lists
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-vsie-alter-stfle-fac-v4-1-74f0e1559929@linux.ibm.com>
References: <20260612-vsie-alter-stfle-fac-v4-0-74f0e1559929@linux.ibm.com>
In-Reply-To: <20260612-vsie-alter-stfle-fac-v4-0-74f0e1559929@linux.ibm.com>
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
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnav/T/n9cy2rHnxiZFt5zd6345n/cRYpbnZHrDebv+e
 LbArWKWjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACbyNoPhnzWLqkZBn7DmpY3c
 bBLZDEscBfmz3j/zS1/wskV8tqXRVUaGWxkZNS+F997VX903eeHeFdNmdp3iLQ4xMDR9eXfTo+s
 VTAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDExMSBTYWx0ZWRfXwVtSEv/2Db6d
 qb8YcsnbDyPH7vBq0JihyZpOZtE7e42LY/4LQ9HWWr27/yADItpwHydJnd/HxCYyxmwkUTR9xXC
 x+IDXfUZH6OfEixm/Z8K1jq6uE860Vc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDExMSBTYWx0ZWRfXyBc2c4JfP/TV
 SwxpNv7gEDT77Yolju/eyRWPoBOvRdgzNKsAE34dltO+Jow9kDsbVAxIzOQ22AqhuUzz9gOyqUk
 rhV2w8LlWOk4umtlsetGHW4ezfV3U+akp8G2xQBPhvRrkLGVaFwOUEdRbiDE7BaLGwPnFR7cwGP
 o5R2jy0Mzvo3yduGsLJpveoKbCWh2ui3EqoFEPjO48jF3wYyCaz3dUvEjolqukN8sxIs5/InPhu
 iiwQq0lNALzp8JRKSCmA2nUS6dGrFBKRQ2iIw02C5rX7rUr5ZUlrpaOTgTQjrIAmyuuU/khcOLJ
 btLtbK2cFid0/qrnJJqBnpAvOccWEI6c8zuXQX7vsMvZIqZAfYRcmKRdyF4LJNfKPnh7cioBbzp
 4XigL4MiME72yuYWvZKsg1J1NHu5yoLCYAbSvZfSQdVMTuAKc72ucK69ZslrRuRkziBN3Jty9jS
 Lbbv3E6Je8bAQdt+sXQ==
X-Proofpoint-ORIG-GUID: BVzg1qXCT0fLv_UaxubKSYfCte5g10Qw
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=6a2bfa35 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=V1mMjla59gyM6mHp8IcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BVzg1qXCT0fLv_UaxubKSYfCte5g10Qw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120111

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

