Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3120F41A54B;
	Fri,  4 Sep 2026 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502023; cv=none; b=LlmLXN1v3tZpRDacOOqQP2AJTzhwqn8VyxmSz0jfHiMdQQJrUW2f9y7EMJL3w2WJjy9yJVTRANT0/cirdY5eXgKg8ztItp9ivHJwVnfHJ3bZ9LkolCiNt+8S6dGry8uElPjxz0DEPTiA0BHFe9JDICXVc9OkPvRa2//Vtw/ljl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502023; c=relaxed/simple;
	bh=wohnYiE4z88AZMyX2rQ1zAQnj+yWVIJV2ncsOox13tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHK4cJ7pMEhJtRMIxIsCDUqlj3eR93VkNCQ9XvRBQyTPCDPe8T9CChjaz0wmcwQ670THlINwlUTt/zzux+dOztfwif5ukCVrUaRB9PwEHQcme/nCBZj1fCWXVv3A9SE7bBclPY/nF269NzDcK+dYXJb53h9bWZdi6IgV6ZMw8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PGBJ0463; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PGBJ0463"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464EUj936716;
	Fri, 4 Sep 2026 06:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Mcc7VYxsjB8ClDqk/
	MRu4sAXBAuHt2gsZ6R8pgAuaB8=; b=PGBJ0463TeeqMl2w05EEuqcRYYNCH6n7R
	JV6R77XoPv4ypPT2ZWbeGmyI28GIp1ws7ZEQQasmVm2ZnjbkkTcME7KlLdeJjRxh
	C4G2V+8uJ9k503rRDsFNXC/uSCdhAw6phwWIHuZnCAYywPP3n1BncOF8MfGJTeht
	1t0D+sKaGzP4CpiQenh5iCnqpzHgPqxvjK4N7743dD7rx32LK9JPccm9i8hKaI7O
	167D3RELxjiComT8pgMkaeZOZ27zhQvJ4XNyr6oxyN56MguS6MaziQ8pPPreZN91
	vGvAjKQ+l0F1SeyIBCoERoQ7tQyVNIps2MQp5jl06GNLT8sosloLQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx610qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6845uHfU015867;
	Fri, 4 Sep 2026 06:06:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjauv44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68466odA40174068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:06:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FCEC20040;
	Fri,  4 Sep 2026 06:06:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1966620049;
	Fri,  4 Sep 2026 06:06:50 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.53.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 06:06:50 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 04/11] KVM: s390: Refactor dat_set_slot()
Date: Fri,  4 Sep 2026 08:06:40 +0200
Message-ID: <20260904060647.562443-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904060647.562443-1-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9a6002 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Dh8sLtxf0uV7TDLfvswA:9
X-Proofpoint-GUID: r2n542dFBQx7oqJXVsgnao8bVoJpQ8Ek
X-Proofpoint-ORIG-GUID: r2n542dFBQx7oqJXVsgnao8bVoJpQ8Ek
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXyHSutGA/6bQx
 sjWLBA9f3xeN8RQxqC1E94bKivbqofxNkXMvlDpQVuZGud/+erJM7XnpNnD99K5RzDzKQNKKgcZ
 Mb2KoHVVcc2ZFwD/B32X951UdodsovQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXwZCYco8iQrNr
 w83Wv6r8fC+cEfaZSAw0OKroprGZqb8NY4LAPxQMBmUUP+0Ipkn2PXcZVR2es994LM8zUPsScx2
 g0f/qCMegGfzKZvN4YDfrapz0WVXmVlqiitmgWea5CWNxWW3RG+3WJ6xQxZKJ5KqBIMgFwPiPx/
 83IxaslYQkX2eL6mtO3Yr0+yKeDlDudPbE7A7Gvzyv3H7blELzYhZFr3R2Uqbs3jQuGA9wa3q3d
 oTlEsiapHSEfdpMwRP6YBsQXVeRNuEzDZQjvcQ8Si3KgnKgrGIuxyVgWdBom285l87Iu735/BjR
 H1QTPEbzU9ZkCllLYUVaXpFiOfdHKiKO5YfDuLpqG2nN9VlxnMQ9OQLOcVgtQDeX8SThsPkVtiV
 0Tehv8s6+CGMDJbPptzN8PJboO3V1siotHUroOww252XklLh/QZzJzI8PjxY2LtHRZ4A/LIl1N2
 IonqKk7XqAa3JP3tV/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040054

Refactor dat_set_slot(), _dat_slot_pte(), _dat_slot_crste(). Now they
only take a struct kvm_s390_mmu_cache as priv. For dat_delete_slot(),
mc is NULL, as no allocations should take place.

This is needed as a prerequisite to move gmap DAT table setup from
kvm_arch_commit_memory_region() to kvm_arch_prepare_memory_region().

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260828115439.145885-5-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/dat.c     | 29 +++++++++--------------------
 arch/s390/kvm/gmap/dat.h     | 10 ++++------
 arch/s390/kvm/gmap/kvm_mmu.c |  4 ++--
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.c b/arch/s390/kvm/gmap/dat.c
index 24547e39fab2..dcedd5479d82 100644
--- a/arch/s390/kvm/gmap/dat.c
+++ b/arch/s390/kvm/gmap/dat.c
@@ -846,19 +846,12 @@ long dat_reset_skeys(union asce asce, gfn_t start)
 }
 #endif /* KVM_S390_MANAGES_S390_GUEST */
 
-struct slot_priv {
-	unsigned long token;
-	struct kvm_s390_mmu_cache *mc;
-};
-
 static long _dat_slot_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
-	struct slot_priv *p = walk->priv;
-	union crste dummy = { .val = p->token };
 	union pte new_pte, pte = READ_ONCE(*ptep);
 	union pgste pgste;
 
-	new_pte = _PTE_TOK(dummy.tok.type, dummy.tok.par);
+	new_pte = walk->priv ? _PTE_EMPTY : _PTE_TOK(_DAT_TOKEN_PIC, PGM_ADDRESSING);
 
 	/* Table entry already in the desired state. */
 	if (pte.val == new_pte.val)
@@ -875,10 +868,9 @@ static long _dat_slot_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct dat_wal
 static long _dat_slot_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
 	union crste new_crste, crste = READ_ONCE(*crstep);
-	struct slot_priv *p = walk->priv;
+	struct kvm_s390_mmu_cache *mc = walk->priv;
 
-	new_crste.val = p->token;
-	new_crste.h.tt = crste.h.tt;
+	new_crste = mc ? _CRSTE_EMPTY(crste.h.tt) : _CRSTE_HOLE(crste.h.tt);
 
 	/* Table entry already in the desired state. */
 	if (crste.val == new_crste.val)
@@ -902,7 +894,10 @@ static long _dat_slot_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct d
 	if (!crste.h.fc && !crste.h.i)
 		return 0;
 	/* Split (install a lower level table), and handle things there. */
-	return dat_split_crste(p->mc, crstep, gfn, walk->asce, false);
+	if (mc)
+		return dat_split_crste(mc, crstep, gfn, walk->asce, false);
+	/* A large page should never cross memslots boundaries */
+	return -EINVAL;
 }
 
 static const struct dat_walk_ops dat_slot_ops = {
@@ -910,16 +905,10 @@ static const struct dat_walk_ops dat_slot_ops = {
 	.crste_ops = { _dat_slot_crste, _dat_slot_crste, _dat_slot_crste, _dat_slot_crste, },
 };
 
-int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gfn_t end,
-		 u16 type, u16 param)
+int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gfn_t end)
 {
-	struct slot_priv priv = {
-		.token = _CRSTE_TOK(0, type, param).val,
-		.mc = mc,
-	};
-
 	return _dat_walk_gfn_range(start, end, asce, &dat_slot_ops,
-				   DAT_WALK_IGN_HOLES | DAT_WALK_ANY, &priv);
+				   DAT_WALK_IGN_HOLES | DAT_WALK_ANY, mc);
 }
 
 static void pgste_set_unlock_multiple(union pte *first, int n, union pgste *pgstes)
diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index e452c141b841..90389d47ba4e 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -547,8 +547,7 @@ long dat_reset_skeys(union asce asce, gfn_t start);
 unsigned long dat_get_ptval(struct page_table *table, struct ptval_param param);
 void dat_set_ptval(struct page_table *table, struct ptval_param param, unsigned long val);
 
-int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gfn_t end,
-		 u16 type, u16 param);
+int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gfn_t end);
 
 #if KVM_S390_MANAGES_S390_GUEST
 int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn);
@@ -973,16 +972,15 @@ static inline int get_level(union crste *crstep, union pte *ptep)
 	return ptep ? TABLE_TYPE_PAGE_TABLE : crstep->h.tt;
 }
 
-static inline int dat_delete_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start,
-				  unsigned long npages)
+static inline int dat_delete_slot(union asce asce, gfn_t start, unsigned long npages)
 {
-	return dat_set_slot(mc, asce, start, start + npages, _DAT_TOKEN_PIC, PGM_ADDRESSING);
+	return dat_set_slot(NULL, asce, start, start + npages);
 }
 
 static inline int dat_create_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start,
 				  unsigned long npages)
 {
-	return dat_set_slot(mc, asce, start, start + npages, _DAT_TOKEN_NONE, 0);
+	return dat_set_slot(mc, asce, start, start + npages);
 }
 
 static inline bool crste_is_ucas(union crste crste)
diff --git a/arch/s390/kvm/gmap/kvm_mmu.c b/arch/s390/kvm/gmap/kvm_mmu.c
index b08b8229bb6f..4c8054e18490 100644
--- a/arch/s390/kvm/gmap/kvm_mmu.c
+++ b/arch/s390/kvm/gmap/kvm_mmu.c
@@ -111,10 +111,10 @@ void s390_kvm_mmu_commit_memory_region(struct kvm *kvm,
 		kvm_s390_update_cmma_dirty(kvm, old);
 		switch (change) {
 		case KVM_MR_DELETE:
-			rc = dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npages);
+			rc = dat_delete_slot(kvm->arch.gmap->asce, old->base_gfn, old->npages);
 			break;
 		case KVM_MR_MOVE:
-			rc = dat_delete_slot(mc, kvm->arch.gmap->asce, old->base_gfn, old->npages);
+			rc = dat_delete_slot(kvm->arch.gmap->asce, old->base_gfn, old->npages);
 			if (rc)
 				break;
 			fallthrough;
-- 
2.55.0

