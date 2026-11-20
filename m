Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161237;
	b=GaKckmGDJOeZwxVJvd+OMd3qLQvELIt/0lRsL3a6BW/C/vqsf6IdMMkUYfg5PMCFRUlw
	 71hTl9wr42K3/tcmd3LSXTlPz2/A0ddoCzICChy5mQ71J/fMD/LocKmwK8PwxRBFxthvW
	 8wBHzC8/oTIpwMDiLnKSPhxMzJaNCMWT8qA9hK/6wME6vTt7VYWpzLCi8DW1NmKZ3TnDr
	 w6UmsSlYVgQHWwfO5agRZ81cn80PuX08gfMX95KzaMQm/6028dx73uMKV0R+jEqT65EHh
	 UynpyxwYVXlqSsVin++NBDiYV+GJphE0V0E826WUEQlO1kF7HMLlBjCvL9Ipm2svKnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161237;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gqoh9E5UoylLr9novogTvMxxvzfIFR1SGhIcki7oMnk=;
	b=5YBzYSVEb5pcwfvydTIOgmAO9w09QCty1NtKOypb++iWNbs2ykz6mDh17gLOPtfN3oum
	 FE550jgkdfPWTyebtpQ/9HBe4lcCW7P7bPmfkczOEv/qddK1ZW+hdJBYnS8x2XZLurrr1
	 QeTNELuik5Aa8/LygQ3WWB2GFzHD6/fus+48WEw50Lc0R+g0TBresW/q5F/JWVwsPiYRR
	 P6VkXzj1NDlS8KqnlskGYAcMao+/VUmc6sVoBRYR0rowdVAJbmDmSDxYyC6MNmxEQUAbU
	 Yjom5cW4e7WMbWS7tr+PSSdgsJM32TY+JaS4ZEMwQn3whdBZM30dfS/881h871v2fIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JW508CXX;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E47D60A2600;
	Fri, 20 Nov 2026 07:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E47D60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JW508CXX
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3ub1d1982102;
	Fri, 20 Nov 2026 07:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gqoh9E5UoylLr9nov
	ogTvMxxvzfIFR1SGhIcki7oMnk=; b=JW508CXXxJ5rUZn9FhTmxuX1B2l0bvv5i
	cksS3pXDbHgTe8hE/Kod9SaWPitsh1L6Rf3BLRjPX68Mx0YjMneTVxDT6BmA6O7q
	4mwj6kTkINBSrvWm6oiGxomA7IeZNe0N1MfQ+/k6/gJ//EDRZk02li69nXTZF4dk
	/j4sU8Mf67oO3c70ZeLTa596hhiM/0DILAhYzuLEnaupcXYC90nAxi9cBIqp4001
	31t1zUoViOgu+rFDY5m/ySEOhCt0QhL7Gf/e88n1oKVOE5yTIfgz4tuBZDQaZVt5
	a9Kw1K/BcFWg/+gVEnrGykfJNKD8KZbDloZ6a1kKIf4ScB0PYSLuQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105tf1ur-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:53:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7o19x2242164;
	Fri, 20 Nov 2026 07:53:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd71hjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:53:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AK7rqIA29491820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 07:53:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD87D58056;
	Fri, 20 Nov 2026 07:53:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA1275803F;
	Fri, 20 Nov 2026 07:53:50 +0000 (GMT)
Received: from b46lp13.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 07:53:50 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v1 2/2] KVM: s390: make kvm_s390_vm_stop_migration() void
Date: Fri, 20 Nov 2026 08:53:45 +0100
Message-ID: <20261120075345.116521-3-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120075345.116521-1-ggala@linux.ibm.com>
References: <20261120075345.116521-1-ggala@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afffc93 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=rddqQMZ5Lc7RoAzGgboA:9
X-Proofpoint-ORIG-GUID: L2Gw-S1kV6v3M1pjb3inyXpjcR-PhxTV
X-Proofpoint-GUID: L2Gw-S1kV6v3M1pjb3inyXpjcR-PhxTV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX8OGCrEr7LOjK
 bv1QFyFfR8gf/TamZUYxdKhKepDNMZBg4dSWQVqzIIduLZrMVhzkoETxlamF20vmFM/TP5sZzel
 GD0eTHbBJF9iqD5qh6maB0tDzJA83i1j0RQaGPwDf1yFtXd2ymHEBbNsDbnzvexlKQ3G4+igJjI
 c+8Q9Bh71jnd+uq8qEU19qLwkh8VyxHHclAayyzcnpW8i7TQPx7m+dVqoyOrNf4nMNXJ3gJ7xLY
 v+Z2Cf/cLi/NG8J7ZcaSq9SUKTC5MY59rNCJQzPXaAAZ2WOmxXF3SOb0ppnz62ZavTfS2xTbiVL
 jJWuzD9THWKESq+8NxfAt1oXQ+Axi5ak8O2kT2k7RSRu24o7YD5fgNtL/Gr8F4//QjnayvLq5J8
 JgH6WuIIUju6RKXiL6XIL7yOcL9BJY2/QJyPC2ottJLvmgwGgq8Uz6Gwo9IQe34xplqZNeztzhw
 NrN/VbkSdZcFtZrTHEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfXzzMrZOF0INMd
 xNiukBrmhjv955TOUGYh0EBWkVsAl8Ugb6Cps/iz3N+iPULfEVg4GBKpLuIzADK5ezv5XXMSWzp
 o5UoHAaO8jRsNFeou4txap+nhww6jKU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200029

kvm_s390_vm_stop_migration() returns 0 on all paths; it cannot fail.
Its caller in s390_kvm_mmu_prepare_memory_region() wraps it in
WARN(), producing a condition that is always false. The arm64 stub
returns -EINVAL but is unreachable because
kvm_s390_is_migration_mode() returns false there.

Change the return type to void and drop the dead WARN(). The
KVM_S390_VM_MIGRATION_STOP attribute handler sets its result to 0
explicitly; userspace behavior is unchanged since stopping
migration never failed.

Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.h    |  3 +--
 arch/s390/kvm/gmap/kvm_mmu.c |  3 +--
 arch/s390/kvm/s390/s390.c    | 10 +++++-----
 arch/s390/kvm/s390/s390.h    |  2 +-
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/arm64/arm.h b/arch/s390/kvm/arm64/arm.h
index 760230685ca1..e60801e4a467 100644
--- a/arch/s390/kvm/arm64/arm.h
+++ b/arch/s390/kvm/arm64/arm.h
@@ -50,9 +50,8 @@ static __always_inline void kvm_s390_update_cmma_dirty(struct kvm *kvm, const st
 }
 
 /* should never be called */
-static __always_inline int kvm_s390_vm_stop_migration(struct kvm *kvm)
+static __always_inline void kvm_s390_vm_stop_migration(struct kvm *kvm)
 {
-	return -EINVAL;
 }
 
 #endif /* ARCH_S390_KVM_ARM64_H */
diff --git a/arch/s390/kvm/gmap/kvm_mmu.c b/arch/s390/kvm/gmap/kvm_mmu.c
index 120980cf6ac6..f1d1374c92a1 100644
--- a/arch/s390/kvm/gmap/kvm_mmu.c
+++ b/arch/s390/kvm/gmap/kvm_mmu.c
@@ -99,8 +99,7 @@ int s390_kvm_mmu_prepare_memory_region(struct kvm *kvm,
 		 */
 		if (change != KVM_MR_DELETE &&
 		    !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
-			WARN(kvm_s390_vm_stop_migration(kvm),
-			     "Failed to stop migration mode");
+			kvm_s390_vm_stop_migration(kvm);
 	}
 
 	if (change == KVM_MR_FLAGS_ONLY)
diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 18fb200f854a..04e4fa7dfd1d 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -1242,11 +1242,11 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
  * Must be called with kvm->slots_arch_lock to avoid races with ourselves,
  * kvm_s390_vm_start_migration() and kvm_s390_get_cmma_bits().
  */
-int kvm_s390_vm_stop_migration(struct kvm *kvm)
+void kvm_s390_vm_stop_migration(struct kvm *kvm)
 {
 	/* migration mode already disabled */
 	if (!kvm->arch.migration_mode)
-		return 0;
+		return;
 	/*
 	 * Unset the flag and propagate to all vCPUs. From now on the cmma_d
 	 * bit will not be touched on any PGSTE.
@@ -1255,7 +1255,7 @@ int kvm_s390_vm_stop_migration(struct kvm *kvm)
 	 */
 	WRITE_ONCE(kvm->arch.migration_mode, 0);
 	if (!kvm->arch.use_cmma)
-		return 0;
+		return;
 
 	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION);
 	/* Clear cmma_d on all existing PGSTEs and set cmma_dirty_pages to 0. */
@@ -1266,7 +1266,6 @@ int kvm_s390_vm_stop_migration(struct kvm *kvm)
 	 * cmma_dirty_pages is 0, and all existing PGSTEs have their cmma_d bit
 	 * set to 0.
 	 */
-	return 0;
 }
 
 static int kvm_s390_vm_set_migration(struct kvm *kvm,
@@ -1282,7 +1281,8 @@ static int kvm_s390_vm_set_migration(struct kvm *kvm,
 		res = kvm_s390_vm_start_migration(kvm);
 		break;
 	case KVM_S390_VM_MIGRATION_STOP:
-		res = kvm_s390_vm_stop_migration(kvm);
+		kvm_s390_vm_stop_migration(kvm);
+		res = 0;
 		break;
 	default:
 		break;
diff --git a/arch/s390/kvm/s390/s390.h b/arch/s390/kvm/s390/s390.h
index 9ed1af5583e3..45f397663d5f 100644
--- a/arch/s390/kvm/s390/s390.h
+++ b/arch/s390/kvm/s390/s390.h
@@ -474,7 +474,7 @@ int __kvm_s390_mprotect_many(struct gmap *gmap, gpa_t gpa, u8 npages, unsigned i
 
 bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu);
 void kvm_s390_update_cmma_dirty(struct kvm *kvm, const struct kvm_memory_slot *old);
-int kvm_s390_vm_stop_migration(struct kvm *kvm);
+void kvm_s390_vm_stop_migration(struct kvm *kvm);
 
 
 /* implemented in diag.c */
-- 
2.56.0

