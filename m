Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A92518FDBE;
	Fri, 22 May 2026 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453004; cv=none; b=lC3HQ1yVCDIsZm4gSCCFR7+0mC8dHlAgruNCwbrPV0CiYX0DSZ095PZPOUS9ltpKAoV0nLydfBIj3Go6H1tyPHyawXs0ol4isYTx4u8EzBPF0UTydGrFnfEfdV15rt/7U4A+LCsN+CTrJMvyfzezN/SDIv2YzuNlDfvIm0TV3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453004; c=relaxed/simple;
	bh=quuUdex1zD9rMvzn8Q77ynDV7FVzDyel9Sn7+ajgBew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHtaNxfQ6OjmSo+BziWyS9VurGao23LoW+2GinWyvi4x5Yx2BPAuizojDCXfclYSDrnPakBz89m7xQCQEE0VS95DAqK2jOqLTrali0Wp1PK5D2gzN28/9qNQ9bv2fh6cney1wcknpswBnqFWbJMP/nTM5bPa5T5tXTGz0yj8Fuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B6coWBEb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B6coWBEb"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LMI0Wa709576;
	Fri, 22 May 2026 12:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=87dV5pLcleW61sgWN
	JcIFQLZD14PVz5VnTrgy8AHYGM=; b=B6coWBEbl/aKJ5AiG425fpU4gJbCb4xWW
	bbZe3o+JNS/8G94Fq/EDhlcgc5/KUmsQzsnL67RyvWcj6d8aEZqZKJZZdJD9RKxb
	X6vwRz+o9pkJ6Of0YdfhNZBXgAyMCD7jn2IwkVOwOhUl1lgf4rTcR5AJiFi+2RV1
	qfpqtirQ6qmovv061BN+PMmhV3rTUNKrG5T/6Zy2mWds4z/4/hy2RiybqrT48QYa
	ZyNy4EZ09t05k4yHR7SFirUBWnFj7Nzmb70stb1gZwUTx4wbY17QBvnmIKBB+AUM
	+FOLzMjaezetI1rENxjKk/40fCRHvwDJXCjMXR2mmHlOz23nBcH6g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h75bvjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 12:29:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MCOEmg017140;
	Fri, 22 May 2026 12:29:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dj0rs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 12:29:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MCTqIE51315170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 12:29:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4BCF20040;
	Fri, 22 May 2026 12:29:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6325A20043;
	Fri, 22 May 2026 12:29:52 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 12:29:52 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 3/5] KVM: s390: vsie: Fix unshadowing logic
Date: Fri, 22 May 2026 14:29:49 +0200
Message-ID: <20260522122951.117120-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522122951.117120-1-imbrenda@linux.ibm.com>
References: <20260522122951.117120-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a104c47 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=HUs3gJRqiL1-pXx69t4A:9
X-Proofpoint-ORIG-GUID: RlpKdoJ-nbc2e-v3eNzWoSFLEjqLVs9S
X-Proofpoint-GUID: RlpKdoJ-nbc2e-v3eNzWoSFLEjqLVs9S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEyMSBTYWx0ZWRfXys6QsE3hXQcs
 makqhsxwnntUf3jOn/JvHjMHL1aI+VPzwABhIDIuss2OkjugOT4/s5/SUZvbZuqT+3VlD/CjPlt
 vHH9wicty9E0pfVRdUuCeQANTuMmbruh8Joyl1gEvA9WpbIYbHoTtMwd7RfBSseSX6iJcbfwsqH
 yWosnEtEySnbszlNDS/q2V1c2yCdyQOuRMRYKNwwa6dkYGVqhqQrMqIt7PHKL/EmjTBOk5UcQs/
 YRJ7B9OAENLdX3cmmnQTjQWfShD2RMlaAV4zqItsSmjI4ykJJyQaxx1mSc90zLDuUKTNpImazsj
 0lfZMFhYVSf6vF5csMfEohUMzWv7lggujDwztEKwVg0AMQy6rUA0S2ibGqnmUzE02aofjVGWQwy
 zBx+w8dMe4EHWv2YOP25zL1zR8ix439q49m9P6xmGUAWwt/PJFUlFJXfxIdVC25ib/Rw7VSNo9c
 pga8qBzWa9xemcPJBuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220121

In some cases (i.e. under extreme memory pressure on the host),
attempting to shadow memory will result in the same memory being
unshadowed, causing a loop.

Add a PGSTE bit to distinguish between shadowed memory and shadowed DAT
tables, fix the unshadowing logic in _gmap_ptep_xchg() to prevent
unnecessary unshadowing and perform better checks.

Also fix the unshadowing logic in _gmap_crstep_xchg_atomic() which did
not unshadow properly when the large page would become unprotected.

Opportunistically add a check in gmap_protect_rmap() to make sure it
won't be called with level == TABLE_TYPE_PAGE_TABLE.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/dat.c     |  1 +
 arch/s390/kvm/dat.h     |  3 ++-
 arch/s390/kvm/gaccess.c |  1 +
 arch/s390/kvm/gmap.c    |  3 ++-
 arch/s390/kvm/gmap.h    | 60 ++++++++++++++++++++++++++++++++++++++---
 5 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 7b8d70fe406d..4a41c0247ffa 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -267,6 +267,7 @@ static int dat_split_ste(struct kvm_s390_mmu_cache *mc, union pmd *pmdp, gfn_t g
 			/* No need to take locks as the page table is not installed yet. */
 			pgste_init.prefix_notif = old.s.fc1.prefix_notif;
 			pgste_init.vsie_notif = old.s.fc1.vsie_notif;
+			pgste_init.vsie_gmem = old.s.fc1.vsie_notif;
 			pgste_init.pcl = uses_skeys && init.h.i;
 			dat_init_pgstes(pt, pgste_init.val);
 		} else {
diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
index 8f8278c44879..873e13ac5a27 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/dat.h
@@ -145,7 +145,8 @@ union pgste {
 		unsigned long cmma_d       : 1; /* Dirty flag for CMMA bits */
 		unsigned long prefix_notif : 1; /* Guest prefix invalidation notification */
 		unsigned long vsie_notif   : 1; /* Referenced in a shadow table */
-		unsigned long              : 5;
+		unsigned long vsie_gmem    : 1; /* Contains nested guest memory */
+		unsigned long              : 4;
 		unsigned long              : 8;
 	};
 	struct {
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index b07accd19618..4f8d5592c9a9 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1445,6 +1445,7 @@ static int _do_shadow_pte(struct gmap *sg, gpa_t raddr, union pte *ptep_h, union
 	} else {
 		pgste = _gmap_ptep_xchg(sg->parent, ptep_h, newpte, pgste, f->gfn, false);
 		pgste.vsie_notif = 1;
+		pgste.vsie_gmem = 1;
 	}
 	pgste_set_unlock(ptep_h, pgste);
 	if (rc)
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 10c98c8cc1d8..8cff0cf5ce24 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1031,7 +1031,8 @@ int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gf
 	union pte pte;
 	int flags, rc;
 
-	KVM_BUG_ON(!is_shadow(sg), sg->kvm);
+	if (KVM_BUG_ON(!is_shadow(sg) || level <= TABLE_TYPE_PAGE_TABLE, sg->kvm))
+		return -EINVAL;
 	lockdep_assert_held(&sg->parent->children_lock);
 
 	flags = DAT_WALK_SPLIT_ALLOC | (uses_skeys(sg->parent) ? DAT_WALK_USES_SKEYS : 0);
diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 96ee1395a592..6e51ec6066b4 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -167,6 +167,36 @@ static inline bool gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end)
 	return _gmap_unmap_prefix(gmap, gfn, end, false);
 }
 
+/**
+ * pte_needs_unshadow() -- Check if the pte operations triggers unshadowing.
+ * @oldpte: the previous value for the guest pte.
+ * @newpte: the new pte being set.
+ * @pgste: the pgste for the pte entry.
+ *
+ * If the pgste.vsie_notif bit is not set, return false: the page is not
+ * involved in vsie and thus should not trigger an unshadow operation.
+ *
+ * If the pgste.vsie_gmem bit is set, this pte represents shadowed guest
+ * memory. The access rights on g3's memory should be synchronized with g1's
+ * and g2's. Therefore unshadowing is triggered if the new and old pte
+ * differ in protection, or if the new pte is invalid.
+ *
+ * If the pgste.vsie_gmem bit is not set, this pte maps the g2 dat tables
+ * for g3. If the entry becomes writable or absent, it becomes impossible to
+ * guarantee that the shadow mapping will match g2's mapping. In that case,
+ * trigger an unshadow event.
+ *
+ * Return: true if an unshadow event should be triggered, otherwise false.
+ */
+static inline bool pte_needs_unshadow(union pte oldpte, union pte newpte, union pgste pgste)
+{
+	if (!pgste.vsie_notif)
+		return false;
+	if (pgste.vsie_gmem)
+		return (oldpte.h.p != newpte.h.p) || newpte.h.i;
+	return !newpte.h.p || !newpte.s.pr;
+}
+
 static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, union pte newpte,
 					  union pgste pgste, gfn_t gfn, bool needs_lock)
 {
@@ -180,8 +210,9 @@ static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, un
 		pgste.prefix_notif = 0;
 		gmap_unmap_prefix(gmap, gfn, gfn + 1);
 	}
-	if (pgste.vsie_notif && (ptep->h.p != newpte.h.p || newpte.h.i)) {
+	if (pte_needs_unshadow(*ptep, newpte, pgste)) {
 		pgste.vsie_notif = 0;
+		pgste.vsie_gmem = 0;
 		if (needs_lock)
 			gmap_handle_vsie_unshadow_event(gmap, gfn);
 		else
@@ -198,6 +229,30 @@ static inline union pgste gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, uni
 	return _gmap_ptep_xchg(gmap, ptep, newpte, pgste, gfn, true);
 }
 
+/**
+ * crste_needs_unshadow() -- Check if the crste operations triggers unshadowing.
+ * @oldcrste: the previous value for the crste.
+ * @newcrste: the new value for the crste.
+ *
+ * If the old crste did not have the vsie_notif bit set, return false: the
+ * page is not involved in vsie and thus should not trigger an unshadow
+ * operation. Conversely, if the bit is set, it can only be g3 memory, since
+ * dat tables are never mapped using large pages.
+ *
+ * Similar to the pgste.vsie_gmem case of pte_needs_unshadow(), if the
+ * protection bit is changing or the new page is invalid, trigger an
+ * unshadow event. Also trigger an unshadow event if the new crste does not
+ * have the vsie_notif bit set.
+ *
+ * Return: true if an unshadow event should be triggered, otherwise false.
+ */
+static inline bool crste_needs_unshadow(union crste oldcrste, union crste newcrste)
+{
+	if (!oldcrste.s.fc1.vsie_notif)
+		return false;
+	return (newcrste.h.p != oldcrste.h.p) || newcrste.h.i || !newcrste.s.fc1.vsie_notif;
+}
+
 static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, union crste *crstep,
 							 union crste oldcrste, union crste newcrste,
 							 gfn_t gfn, bool needs_lock)
@@ -216,8 +271,7 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
 		newcrste.s.fc1.prefix_notif = 0;
 		gmap_unmap_prefix(gmap, gfn, gfn + align);
 	}
-	if (crste_leaf(oldcrste) && oldcrste.s.fc1.vsie_notif &&
-	    (newcrste.h.p || newcrste.h.i || !newcrste.s.fc1.vsie_notif)) {
+	if (crste_leaf(oldcrste) && crste_needs_unshadow(oldcrste, newcrste)) {
 		newcrste.s.fc1.vsie_notif = 0;
 		if (needs_lock)
 			gmap_handle_vsie_unshadow_event(gmap, gfn);
-- 
2.54.0

