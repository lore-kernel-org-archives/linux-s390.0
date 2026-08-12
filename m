Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27CE43F0B0;
	Wed, 12 Aug 2026 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549065; cv=none; b=WNjcWbfIiK4IFOwyZBe4QfiwY86W/QegCbXGFKqfL71XwmT+cYenF0lSsla9uJDgGyMAc2rqJIQYA2QFflHmeezhZVrzlCIaA41u7asm9ZoSytNVNbAzsUZrFNbUtsRx/c7wE8wyU32qNaRGSGnDLcPYk4Ph/qBJquaz3dGcLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549065; c=relaxed/simple;
	bh=6q3PngeZ1hyi+tVAWj8ORRjbK5g9L1BDdRmFLtI8tRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMXGm6WvVcYLrBh4+iV+umHReGNyXFL/TiYoZ7Hj4Lt5a1GjivsOQgYPvzoItM/dD4u5CRxE6kCY1HwlsnJXagP2j+Extk7JPTxpgCMk/kTnhdJFbQvVaK4MdQztB+lZWdRk7ebmMu/vwIPDhVztlbYifBbhztIsJSZpcjSDlk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dYQRnXNY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dYQRnXNY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE2IqY3595592;
	Wed, 12 Aug 2026 15:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mbc7MwJqZ/oVGq1aC
	bVY0xikGd/ZXjZ5Sb3UUIYFWbs=; b=dYQRnXNYotm7frMv7VWiZW6wNtSiNfnaD
	e0wItjx10TNZVJ4hHnXjZqMt3lf9/PuEcAw8AJ072A1VWz9BkgfrkTt8RT+5gPgc
	vx+ZalvtrsnGTNg5HXdQp5fFQuOQRA33D8iwnpPvSkgmQW+33j/71TAgaPwmCKXi
	vjA+m2ael5Uq1CL/UciQ8EAvIcjIMkpVQevFnY/j37uwZrnVf8c3J8rf4+Fh2lIO
	598fMhb40PZikRgMcpkOp48JggMJY79zAjqc70bE0t2OiHukWnsNBGC1EM0xX1jU
	si0Wco5kAidpC6lLeWgOx2aezNK6Xehfgvz3LPke+ZP1cIIqk6SjA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp32e1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFBKqP018660;
	Wed, 12 Aug 2026 15:36:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w6tdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFaeAx29425952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DADF32004D;
	Wed, 12 Aug 2026 15:36:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A0A92004B;
	Wed, 12 Aug 2026 15:36:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:39 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v6 20/33] KVM: s390: gmap: Make CMMA optional
Date: Wed, 12 Aug 2026 17:36:16 +0200
Message-ID: <20260812153631.3376090-21-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812153631.3376090-1-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c930d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=xXhVJQDoiGTxmNljp-oA:9
X-Proofpoint-GUID: fsAwtltayVLSvOkRwSMx1HbJvAQEEUbx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX1UIm/jR5T6w2
 SkLMqY0X8cljbMkJRx+SHGPxMB1svlxS3fAzWF0hFNyPmX0XDyVKBakrBWTvEskHbwNre5DYIze
 cjDzBVErIAOmvWovQYZX0MAz0msDPnTFoED1tpcKfXmcWItn+aNuPHk6VDPHS9QsbCMa+v7aP6u
 5IR3qpp5NDRJkYEFYZ66td4/UOnCr2Bogi+Hw44+/9vuxqeoxF/qQoQXzkYvjTAafwT6OmGuew9
 Su+tT4FkwWUGqcoCrbXIUkKBqoZfLqOYVIr54Fm5rBzIbFKPu/6GG4SBmzwna68QPOOAhHtc3y9
 3ohEtouSwrB/YTAMAJJVWIwOjRvzLo/PKqMTM6YtbDJ9Q9YJylTWf2c44uECzQP9zR/U6ebDc3v
 DR75QfWziYEWusO/1aoW+fUPYNZ6BVaj5imfvJYEAbAdOWziulqdeiNPiQTLwSRe3FkKpaNdICw
 WeyRHTL1jMPI7/IKWcw==
X-Proofpoint-ORIG-GUID: EozK7Pm1xakV4njc29zNzW026GCiJ_VO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX2ORiOJgtG1qd
 /2gsj0NmpZpvGAhhfyRHvaCpLD1VOHKYP/Q6LK6ndh/y5q42RDmnp0gcqS0Xq1c6geNqeBK2occ
 GoA1D6WAOayP8WXxRCUxciqPtErAQak=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120126

Guard guest CMMA behind `KVM_S390_MANAGES_S390_GUEST`. This enables
other KVM implementations to use gmap without implementing CMMA.

No functional changes.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.c  | 2 ++
 arch/s390/kvm/gmap/dat.h  | 2 ++
 arch/s390/kvm/gmap/gmap.c | 2 ++
 arch/s390/kvm/gmap/gmap.h | 4 +++-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index f4e142995367..43ebafb56ce5 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -1059,6 +1059,7 @@ int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn)
 	return 0;
 }
 
+#if KVM_S390_MANAGES_S390_GUEST
 /**
  * dat_perform_essa() - Perform ESSA actions on the PGSTE.
  * @asce: The asce to operate on.
@@ -1336,3 +1337,4 @@ int dat_set_cmma_bits(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
 	}
 	return _dat_walk_gfn_range(gfn, gfn + count, asce, &ops, DAT_WALK_IGN_HOLES, &state);
 }
+#endif /* KVM_S390_MANAGES_S390_GUEST */
diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 2cc072168810..4f11f9bbd83a 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -552,12 +552,14 @@ int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gf
 int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn);
 bool dat_test_age_gfn(union asce asce, gfn_t start, gfn_t end);
 
+#if KVM_S390_MANAGES_S390_GUEST
 int dat_perform_essa(union asce asce, gfn_t gfn, int orc, union essa_state *state, bool *dirty);
 long dat_reset_cmma(union asce asce, gfn_t start_gfn);
 int dat_peek_cmma(gfn_t start, union asce asce, unsigned int *count, u8 *values);
 int dat_get_cmma(union asce asce, gfn_t *start, unsigned int *count, u8 *values, atomic64_t *rem);
 int dat_set_cmma_bits(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t gfn,
 		      unsigned long count, unsigned long mask, const uint8_t *bits);
+#endif /* KVM_S390_MANAGES_S390_GUEST */
 
 int kvm_s390_mmu_cache_topup(struct kvm_s390_mmu_cache *mc);
 
diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index c1b0e2572818..86513f653850 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -1098,6 +1098,7 @@ int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gf
 	return 0;
 }
 
+#if KVM_S390_MANAGES_S390_GUEST
 static long __set_cmma_clean_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
 	union pgste pgste;
@@ -1140,6 +1141,7 @@ void _gmap_set_cmma_all(struct gmap *gmap, bool dirty)
 						  &gmap->kvm->arch.cmma_dirty_pages);
 	} while (gfn);
 }
+#endif /* KVM_S390_MANAGES_S390_GUEST */
 
 static void gmap_unshadow_level(struct gmap *sg, gfn_t r_gfn, int level)
 {
diff --git a/arch/s390/kvm/gmap/gmap.h b/arch/s390/kvm/gmap/gmap.h
index 328a81c72c7a..6f3bf11d2166 100644
--- a/arch/s390/kvm/gmap/gmap.h
+++ b/arch/s390/kvm/gmap/gmap.h
@@ -110,7 +110,6 @@ int gmap_insert_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gfn
 		     gfn_t r_gfn, int level);
 int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn,
 		      kvm_pfn_t pfn, int level, bool wr);
-void _gmap_set_cmma_all(struct gmap *gmap, bool dirty);
 void _gmap_handle_vsie_unshadow_event(struct gmap *parent, gfn_t gfn);
 struct gmap *gmap_create_shadow(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
 				union asce asce, int edat_level);
@@ -204,6 +203,8 @@ static inline bool pte_needs_unshadow(union pte oldpte, union pte newpte, union
 	return !newpte.h.p || !newpte.s.pr;
 }
 
+#if KVM_S390_MANAGES_S390_GUEST
+void _gmap_set_cmma_all(struct gmap *gmap, bool dirty);
 static inline void gmap_set_cmma_all_dirty(struct gmap *gmap)
 {
 	_gmap_set_cmma_all(gmap, true);
@@ -213,6 +214,7 @@ static inline void gmap_set_cmma_all_clean(struct gmap *gmap)
 {
 	_gmap_set_cmma_all(gmap, false);
 }
+#endif /* KVM_S390_MANAGES_S390_GUEST */
 
 static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, union pte newpte,
 					  union pgste pgste, gfn_t gfn, bool needs_lock)
-- 
2.53.0

