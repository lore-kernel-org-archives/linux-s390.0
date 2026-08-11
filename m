Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8283644C1;
	Tue, 11 Aug 2026 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463814; cv=none; b=ZMJr1CjKiOmhTA8fgN3aC2/Qg4PKu6tt3dTD+c4u1sj2Glq12W4tgZvTzHJSusT7TtCbx+xY0TL5XucY7tKzOZ5mXnjXbKTJGmSGi1QoS+WztLa8b+uEwqKelRF7wimoHsH45sfZMNSRAcnONMdXQm88+gM7g2fNSThmUz3lrnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463814; c=relaxed/simple;
	bh=ZoN63DoAA+5EuxaAUzBOfeZ0nWDbRWi/6ScBHZyI5SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dClmTPv6DtzgGaHwKq9+Ud8WGjCuvxrXWn/otkYy+pif3aQaA8+w0p4EJviTWB4enHM+EidPqPSbTgLXT3dQQI2pZW3Rp6Nuif3JXAawAxQCBVmmmDagPck3PP2MUR0rnLqObMQBQ2pniMgvJrMIdOva7qp5DHEWzNih8obsnIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TtYAW0S+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TtYAW0S+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWXAh2864613;
	Tue, 11 Aug 2026 15:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=51emZvHNT/K6BJQuj
	sLxsZkzA+dd5xbBfTdXbPLWPjQ=; b=TtYAW0S+QdZNmqyg4PMzlAclv+asgABVt
	O5WBLl6zemxgTw0/LGjioPinct8O/Lo0S955CTsh5e89pPuWcQ1CbIVxlvutUhwy
	uPzmLff53l/tr1qZ4Z2H3BRENBS4Ru9ivcqXOFwdbeVhORCR3Gu+Ma6ZkUD1cukG
	JMgECF+G2Qq1gO6Q9DL0lVLQ4s/M17T/5AYuVHsG9XxxwRupUFLPLH5EG+vALCll
	FTINpEVPkdgrbQ0iJm2+MGLDFKHGMWzqn3NRg8hZqn0SDgU8nGzX3+MsPT6SM4nq
	9CoOpFW6p+w83OayFNSZGMUSJhkCfLEl1AAFyyzQVSjwkjacjQr1w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjywsjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFuMnO016183;
	Tue, 11 Aug 2026 15:56:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy1d81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:56:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFuhfH37290342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:56:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E12120040;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 591C82004E;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:56:43 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 06/11] KVM: s390: Introduce extended topup for struct kvm_s390_mmu_cache
Date: Tue, 11 Aug 2026 17:56:36 +0200
Message-ID: <20260811155641.219777-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811155641.219777-1-imbrenda@linux.ibm.com>
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX6WFa7Zz8or+j
 oqPRDDfjJHiWp6EZ8tkBQM2cm5d0+2kcSPXc0p5A9JQEl/O7E43IgVOtSnQJHCM6HaQUjCJi6sU
 cgwzMIYFtaZo8q0Xm08JAjbZQOKL2QtySLCsvGQ4cEX4vlf6rwAijB+cajy4u970+zQrTcFRC/5
 b9kpd1BrDnPejg83NHpocWTuuYtyS3GmUTyvObmKTZ4fVS9GYsTDh38OlMh5rlOB8kz0bbr4+9t
 OGkzdQ85poZKccnj7sRZ5MbsAlzj/d2oR+GG6kVZitb4k22FzBNLMdx3nuwzUlcLrJHYauq3dy8
 r/pmiSPTXtxaYsPCTROGsHYTFh5vTdaXuR6Wgq2IsSzRDk0o8mA0Rjt6nPn+44NCWgeufuGzo77
 5Kbadgo613LSpYNX8/B8sRzvuCs3kB7b7haoIiMCfeRNoctqdgxTB/YlZc6HCcxSYb9ORTmckr9
 PXgnteQ3wQusGTjOccA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfXwGGh4evghnwU
 jAOFzSSnZ+ZLNN3u/v2OI5LdWew7d/hYnxKNuakNVE/VP6B0Xe6ZFvlmdR+7tvtaHduvkK++O8V
 kjLHuIrsgfRv22f8RqTAa1fMiWG3wgU=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b4642 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=SpkQyuVxaospo0cZ0BUA:9
X-Proofpoint-GUID: QvF27nJUCMSn4yAL6BxxB7ZwOY07OChf
X-Proofpoint-ORIG-GUID: QvF27nJUCMSn4yAL6BxxB7ZwOY07OChf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110130

In most cases the mmu caches should not blow up in size unnecessarily,
since there is one for each vCPU, as it can add up to a quite big
amount of memory. In some cases, though, it is necessary to have a
particularly large mmu cache, to guarantee that specific operations can
complete without needing to refill the cache.

This patch refactors the existing kvm_s390_mmu_cache_topup() function
to allow for an extended top-up. Two wrappers are also provided, one
with the old name and old behaviour, and one that performs the extended
top-up.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 11 +++++++----
 arch/s390/kvm/dat.h | 25 +++++++++++++++++++++----
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index f4dd6f783417..47ff8af1b22f 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -28,23 +28,26 @@
 #include <asm/tlb.h>
 #include "dat.h"
 
-int kvm_s390_mmu_cache_topup(struct kvm_s390_mmu_cache *mc)
+int _kvm_s390_mmu_cache_topup(struct kvm_s390_mmu_cache *mc, bool extended)
 {
+	size_t n_crsts = extended ? KVM_S390_MMU_CACHE_N_CRSTS_MAX : KVM_S390_MMU_CACHE_N_CRSTS;
+	size_t n_pts = extended ? KVM_S390_MMU_CACHE_N_PTS_MAX : KVM_S390_MMU_CACHE_N_PTS;
+	size_t n_rmaps = extended ? KVM_S390_MMU_CACHE_N_RMAPS_MAX : KVM_S390_MMU_CACHE_N_RMAPS;
 	void *o;
 
-	for ( ; mc->n_crsts < KVM_S390_MMU_CACHE_N_CRSTS; mc->n_crsts++) {
+	for ( ; mc->n_crsts < n_crsts; mc->n_crsts++) {
 		o = (void *)__get_free_pages(GFP_KERNEL_ACCOUNT | __GFP_COMP, CRST_ALLOC_ORDER);
 		if (!o)
 			return -ENOMEM;
 		mc->crsts[mc->n_crsts] = o;
 	}
-	for ( ; mc->n_pts < KVM_S390_MMU_CACHE_N_PTS; mc->n_pts++) {
+	for ( ; mc->n_pts < n_pts; mc->n_pts++) {
 		o = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
 		if (!o)
 			return -ENOMEM;
 		mc->pts[mc->n_pts] = o;
 	}
-	for ( ; mc->n_rmaps < KVM_S390_MMU_CACHE_N_RMAPS; mc->n_rmaps++) {
+	for ( ; mc->n_rmaps < n_rmaps; mc->n_rmaps++) {
 		o = kzalloc_obj(struct vsie_rmap, GFP_KERNEL_ACCOUNT);
 		if (!o)
 			return -ENOMEM;
diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
index 141ee7b9f019..461302f05e50 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/dat.h
@@ -479,13 +479,20 @@ struct vsie_rmap {
 
 static_assert(sizeof(struct vsie_rmap) == 2 * sizeof(long));
 
+/* Used when performing normal top-ups */
 #define KVM_S390_MMU_CACHE_N_CRSTS	6
 #define KVM_S390_MMU_CACHE_N_PTS	2
 #define KVM_S390_MMU_CACHE_N_RMAPS	16
+
+/* Used to perform special extended top-ups */
+#define KVM_S390_MMU_CACHE_N_CRSTS_MAX	32
+#define KVM_S390_MMU_CACHE_N_PTS_MAX	8
+#define KVM_S390_MMU_CACHE_N_RMAPS_MAX	16
+
 struct kvm_s390_mmu_cache {
-	void *crsts[KVM_S390_MMU_CACHE_N_CRSTS];
-	void *pts[KVM_S390_MMU_CACHE_N_PTS];
-	void *rmaps[KVM_S390_MMU_CACHE_N_RMAPS];
+	void *crsts[KVM_S390_MMU_CACHE_N_CRSTS_MAX];
+	void *pts[KVM_S390_MMU_CACHE_N_PTS_MAX];
+	void *rmaps[KVM_S390_MMU_CACHE_N_RMAPS_MAX];
 	short int n_crsts;
 	short int n_pts;
 	short int n_rmaps;
@@ -555,7 +562,17 @@ int dat_get_cmma(union asce asce, gfn_t *start, unsigned int *count, u8 *values,
 int dat_set_cmma_bits(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
 		      unsigned long count, unsigned long mask, const uint8_t *bits);
 
-int kvm_s390_mmu_cache_topup(struct kvm_s390_mmu_cache *mc);
+int _kvm_s390_mmu_cache_topup(struct kvm_s390_mmu_cache *mc, bool extended);
+
+static inline int kvm_s390_mmu_cache_topup(struct kvm_s390_mmu_cache *mc)
+{
+	return _kvm_s390_mmu_cache_topup(mc, false);
+}
+
+static inline int kvm_s390_mmu_cache_extended_topup(struct kvm_s390_mmu_cache *mc)
+{
+	return _kvm_s390_mmu_cache_topup(mc, true);
+}
 
 #define GFP_KVM_S390_MMU_CACHE (GFP_ATOMIC | __GFP_ACCOUNT | __GFP_NOWARN)
 
-- 
2.55.0

