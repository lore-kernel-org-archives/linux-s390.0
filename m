Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CE33BBFC9;
	Fri, 19 Jun 2026 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884336; cv=none; b=lCX+RHeeeu48y6lRJzrBjSwBFUoPYcD7Unly3nVLIly1i9kJ5mSAIwiauY1/AHc3J1Da3DZwkcIf4C9EdLFCEEdQtY0i7j+osXQvBcSbF6v+p7QFiGYQYY9PH4PdFmvXHzqgTgyICgb29ShsZKOWzNPUBrNmNETMH/CnaSonIBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884336; c=relaxed/simple;
	bh=hxJlohSZhxk2e3l4YWgw1gpyQXL+9HMKNrlV8Vg49Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQ5mBIgyuNMo2HXn3EaU9F+2PK2JyAMFUl9daLCmXQk3/PuTf6mIgSJj0IrU/UV96Zw0JORuaLwtL2DjZ2X/3WAjK1ZVr0722JZMEkiq32iG3IbpSnOnCovW6mD3gBX+OnzJyjGIKvktk+4gH5bJrrVMw1e9QZK75hUQN/Jwkto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EXfdsgtV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EXfdsgtV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JDIVbB2320928;
	Fri, 19 Jun 2026 15:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Uxan4MqSAHmyV3Qxf
	eM/l8JC0t/V+KuyjCfyeWrMWXU=; b=EXfdsgtVTf1qKlbVrIVtLu3MPGIt5LCN9
	wNnobIrqpRCQsuVoRiZQt8ps34ZJGadC8Q5E2P6weJMu0IcxJoTB/b9nqQtpobC5
	p97tbYtw1FgSdbE3uH4Mv8SM2Q3B3UMhUcid92tpQKBtaPfyg0J5ijMqspc5gU9/
	bOEQZolkD5U+7gqtByS8itY6ajAe1U8nSfaKAZILl17pfAtCVKiDOUh1t16PnhHr
	Nl3pIlnwcbzgwBaZJkvFRIj6yx/7pw055vtYwzbcAOpvWAdPVHpH8gv6ltyDhaif
	23WnPIKF7LQnuRMOv6B7YVotZ+1b2kqcXJ7gMRUSSARkn2aO6zLuw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxp6cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 15:52:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JFnxn2026562;
	Fri, 19 Jun 2026 15:52:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172hh6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 15:52:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JFq3L433882464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 15:52:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5994620043;
	Fri, 19 Jun 2026 15:52:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4817520040;
	Fri, 19 Jun 2026 15:52:02 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.54.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 15:52:02 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v4 6/7] KVM: s390: cmma: Fix cmma dirty tracking
Date: Fri, 19 Jun 2026 17:51:53 +0200
Message-ID: <20260619155154.307572-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619155154.307572-1-imbrenda@linux.ibm.com>
References: <20260619155154.307572-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OcSoyBTY c=1 sm=1 tr=0 ts=6a3565a7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Y1bJqYFpAtDwCtoAyV8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE1MCBTYWx0ZWRfX4PLysUdg3L6D
 77R/9u47cOtJXvAdKZKMcu12SD/VOVv9sW/EAYKgxhPTY3bGcNbirA/120kl7IZRPaJzdP9Mb65
 9L3WoE5bqYlfxSN8q9KwdxAYdu1sNUeGUuU33lr68eqUMNo+42Jqv/BFpV/wWKpe9Rd3H2rwwLk
 FeLWzjXK/xM+tTyjdm1WXcmNpl//JtJR9oJlYrwcXvV1u3ebuhkjCrTE22vtVj1VnsBOHd4ur1U
 2FzP4ubtg5w+HMrq9S5+mGOPcoVEyu65Jiv59r3tv6wmhaJejCNSSO1P/Up/2f6iS/cxPvuL1g1
 Ax7lgnyV0rrO/LW8TpI0b0NsaElbO3pT4XeKZGB1FI2PHw7TsfQ9BTyGohEA3+QPe/OY7bOZLsC
 UR1fz8rPX9HD70p8I8SavKTtfrOL2vtn2YJkGUM5B6xlg7u87SCCCWcMgyT5+W5+JuDfA3xrl9C
 baVUoq8lBHJ3Vz5fy7A==
X-Proofpoint-GUID: XeXbK-JGZEn8J0wQkpIEX5PPpmm_P7Y2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE1MCBTYWx0ZWRfX77TBKS97rR0o
 dxxwGL+6sfQe7fm4UnqXwnAnGeI/jF/qCky2FCjLV230izsl6AGIg+tzSlOQFKC2b/CWvgozsHL
 Cwr8Mv+u1sNS0ohl+RrFQ/21s++HjH4=
X-Proofpoint-ORIG-GUID: XeXbK-JGZEn8J0wQkpIEX5PPpmm_P7Y2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190150

It is possible that some guest memory areas have not been touched yet
when starting migration mode, and thus have no ptes allocated. Only
existing and allocated ptes should count toward the total of dirty cmma
entries.

When starting migration mode, count how many pages actually have a pte
(and PGSTE), instead of blindly counting the number of pages in all
memslots. Avoid double-counting pages whose cmma information has been
updated concurrently.

Also fix dat_get_cmma() to properly wrap around if the first attempt
reached the end of guest memory without finding cmma-dirty pages.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c      |  3 +++
 arch/s390/kvm/gmap.c     | 14 ++++++++++++--
 arch/s390/kvm/kvm-s390.c |  5 +----
 3 files changed, 16 insertions(+), 6 deletions(-)

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
index e6e786811db8..e3d620af8a85 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1075,7 +1075,16 @@ int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gf
 
 static long __set_cmma_dirty_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
-	__atomic64_or(PGSTE_CMMA_D_BIT, &pgste_of(ptep)->val);
+	union pgste pgste;
+
+	pgste = pgste_get_lock(ptep);
+	/* Avoid double-counting when concurrent updates happen */
+	if (!pgste.cmma_d) {
+		pgste.cmma_d = 1;
+		atomic64_inc(walk->priv);
+	}
+	pgste_set_unlock(ptep, pgste);
+
 	if (need_resched())
 		return next;
 	return 0;
@@ -1089,7 +1098,8 @@ void gmap_set_cmma_all_dirty(struct gmap *gmap)
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
index ffb20a64d328..907d2ca9951d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1191,7 +1191,6 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
 {
 	struct kvm_memory_slot *ms;
 	struct kvm_memslots *slots;
-	unsigned long ram_pages = 0;
 	int bkt;
 
 	/* migration mode already enabled */
@@ -1208,12 +1207,10 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
 	kvm_for_each_memslot(ms, bkt, slots) {
 		if (!ms->dirty_bitmap)
 			return -EINVAL;
-		ram_pages += ms->npages;
 	}
+	kvm->arch.migration_mode = 1;
 	/* mark all the pages as dirty */
 	gmap_set_cmma_all_dirty(kvm->arch.gmap);
-	atomic64_set(&kvm->arch.cmma_dirty_pages, ram_pages);
-	kvm->arch.migration_mode = 1;
 	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_START_MIGRATION);
 	return 0;
 }
-- 
2.54.0

