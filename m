Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609EE3164BA;
	Mon, 22 Jun 2026 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144469; cv=none; b=U8OkxjatL+KDOoh0JffMOP7FffoaMybDCAkiFsYnufnta7PQeZtRfdjyZu18FyB3exhGydcWpjA+XcnGPdKDnuMvlaqiCmcJj8weR1YBIW6ZvJbhTBBRWQM27oPbDRQpb7+7OH+lNLO6dQgsjH/TNst8R2HjbQU6LBAu4wGggN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144469; c=relaxed/simple;
	bh=vHQpI1ru50YyWnNgHEu7/z1Gejp4fHobyiYDAZoSvBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hetJXoPcPf3751Bcf3OdZwxs/Y09Q2SR2BPPiCw/HUsd7AwdzQOqnJ+ubi1CxhUa+TUpZcgejEuW9xjEjBdXN+oAiVpMK8UgHuzaotrR82asygEbS+UvLZqeBvErKh5Fp+HapBg2BQOMeCBtmvTtofT+u3mtc8kl2T7GrnEFFV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f5moyBh+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f5moyBh+"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmLS53398281;
	Mon, 22 Jun 2026 16:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7QC4ryCpxOavYK9Aj
	Dftwxw9g33wGFYBYVVR/Tm8sWM=; b=f5moyBh+cdqeHiZRwLVOgZf6j5CuM3b3e
	FkhPqW6f+mtNl1zBeDC5FUzhmqEcVXr/eWEHUohB+OuIA3l9E6jk4jjd5ER8EC78
	EKCFs8Vcq+/zqXNyHvmgdoQHemim3A9rGLS2mjQsnnDyeUUejpuJbWSsvbG/FuFl
	0S5HHGTm+OloHp6f3y4Xf4EuMZHdbsLGsDTXEntTeDRB40/IVa6gDJxBKf+yHFiF
	ngjk//KMsxrJ5ftXRybmUiv8t5gx2+N3PKKibz02YFpkUrUtaiJDRZwmHrKapqlp
	83csuNfF3wPjin3xRLeYNWD/eVra1TqBkaWVBJb/QZOLrfTpLgSKw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4a544-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MG4j2I028118;
	Mon, 22 Jun 2026 16:07:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56q76wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MG7fUr9371912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 16:07:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C697B20040;
	Mon, 22 Jun 2026 16:07:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A30920049;
	Mon, 22 Jun 2026 16:07:41 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 16:07:41 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v5 7/9] KVM: s390: Fix cmma dirty tracking
Date: Mon, 22 Jun 2026 18:07:37 +0200
Message-ID: <20260622160739.202044-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622160739.202044-1-imbrenda@linux.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfX7Z2jH7zlIs1f
 4/2y9jE7RfiuMv3bAKg/y/yZUmPZyjnaLPAKwHmnPEYcAh39I5n0K176o4eaKDku/Dwv0vLqAxI
 ax9IAmOZIG82YTNpSE8XcjpVl9dPT2A=
X-Proofpoint-ORIG-GUID: vi1DqhJ70R9YyI7evwOkMPdgdPRs5BQe
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a395dd2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=HzbU3q2jQ-ihC4wUKKgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfXzVGSQ35lL4Rb
 bJyrTqa5yCgS44wmzhzFaGCSNMATUbst4UVg0w3crhh4SlEbTg12eWYIkOSnarI85ZAkwvGFdto
 BE2iEheYTvMv7VN4Qtf3hB+mwcnI0yCCDEli3zZ8DALlieQ+LeHRvchTooSFFVrr2FLenOyJWtf
 7lS0504ylsxxtve37cDv0u25ajbZB7323xHo5SMkYVYAAmU8pzkPLV87IcGgfSpOfJUWYFqWJVC
 NzBlf1niGK3LyvsM66jYntOxngRy4hvGtJA7seN3b3vE9HrslliKHvKcWipko4hKahJaiUmMcv6
 mxRXACFzmDTx/88qHVQ0yGxAeP+SVLnArtgOAvILItEVNCTz/qIIkNsJLCzFQbmSVJ9Dr9kmiP1
 6rHuS9alWfimtmkGFNo3mlPIlXZiUMz6iibSviyFw3Pz4o3hjwKs9otdItBiX/Pw6MrWY1Ctgxz
 0oHAGMrBKZMXnQaXYbQ==
X-Proofpoint-GUID: vi1DqhJ70R9YyI7evwOkMPdgdPRs5BQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220157

It is possible that some guest memory areas have not been touched yet
when starting migration mode, and thus have no ptes allocated. Only
existing and allocated ptes should count toward the total of dirty cmma
entries.

When starting migration mode, count how many pages actually have a pte
(and PGSTE), instead of blindly counting the number of pages in all
memslots.

Also fix dat_get_cmma() to properly wrap around if the first attempt
reached the end of guest memory without finding cmma-dirty pages.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c      |  3 +++
 arch/s390/kvm/gmap.c     | 11 +++++++++--
 arch/s390/kvm/kvm-s390.c |  8 +++-----
 arch/s390/kvm/priv.c     |  2 +-
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index cffac7782c4b..0ad4ebc80eba 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -1253,6 +1253,9 @@ int dat_get_cmma(union asce asce, gfn_t *start, unsigned int *count, u8 *values,
 	};
 
 	_dat_walk_gfn_range(*start, asce_end(asce), asce, &ops, DAT_WALK_IGN_HOLES, &state);
+	/* If no dirty pages were found, wrap around and continue searching */
+	if (*start && state.start == -1)
+		_dat_walk_gfn_range(0, *start, asce, &ops, DAT_WALK_IGN_HOLES, &state);
 
 	if (state.start == -1) {
 		*count = 0;
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index e6e786811db8..a9a37fdeb809 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1075,7 +1075,13 @@ int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gf
 
 static long __set_cmma_dirty_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
-	__atomic64_or(PGSTE_CMMA_D_BIT, &pgste_of(ptep)->val);
+	union pgste pgste;
+
+	pgste = pgste_get_lock(ptep);
+	pgste.cmma_d = 1;
+	pgste_set_unlock(ptep, pgste);
+	atomic64_inc(walk->priv);
+
 	if (need_resched())
 		return next;
 	return 0;
@@ -1089,7 +1095,8 @@ void gmap_set_cmma_all_dirty(struct gmap *gmap)
 	do {
 		scoped_guard(read_lock, &gmap->kvm->mmu_lock)
 			gfn = _dat_walk_gfn_range(gfn, asce_end(gmap->asce), gmap->asce, &ops,
-						  DAT_WALK_IGN_HOLES, NULL);
+						  DAT_WALK_IGN_HOLES,
+						  &gmap->kvm->arch.cmma_dirty_pages);
 		cond_resched();
 	} while (gfn);
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 93141a68e0dd..cdd8b41d24ed 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1190,7 +1190,6 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
 {
 	struct kvm_memory_slot *ms;
 	struct kvm_memslots *slots;
-	unsigned long ram_pages = 0;
 	int bkt;
 
 	/* migration mode already enabled */
@@ -1207,12 +1206,11 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
 	kvm_for_each_memslot(ms, bkt, slots) {
 		if (!ms->dirty_bitmap)
 			return -EINVAL;
-		ram_pages += ms->npages;
 	}
 	/* mark all the pages as dirty */
+	atomic64_set(&kvm->arch.cmma_dirty_pages, 0);
 	gmap_set_cmma_all_dirty(kvm->arch.gmap);
-	atomic64_set(&kvm->arch.cmma_dirty_pages, ram_pages);
-	kvm->arch.migration_mode = 1;
+	WRITE_ONCE(kvm->arch.migration_mode, 1);
 	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_START_MIGRATION);
 	return 0;
 }
@@ -1226,7 +1224,7 @@ static int kvm_s390_vm_stop_migration(struct kvm *kvm)
 	/* migration mode already disabled */
 	if (!kvm->arch.migration_mode)
 		return 0;
-	kvm->arch.migration_mode = 0;
+	WRITE_ONCE(kvm->arch.migration_mode, 0);
 	if (kvm->arch.use_cmma)
 		kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION);
 	return 0;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 9bc6fd02ff77..ad0ddc433a73 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1236,7 +1236,7 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 						: ESSA_SET_STABLE_IF_RESIDENT))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	if (!vcpu->kvm->arch.migration_mode) {
+	if (!READ_ONCE(vcpu->kvm->arch.migration_mode)) {
 		/*
 		 * CMMA is enabled in the KVM settings, but is disabled in
 		 * the SIE block and in the mm_context, and we are not doing
-- 
2.54.0

