Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5DB401A15;
	Wed, 25 Mar 2026 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458811; cv=none; b=BfSBSK7kxlJV4gZlvPQOF+CiMQXnAbLtRUCefES7o9I34Q/VQJV3TDKs9uS8NvSWG0HrkQRz9StUHR2g4Iby9Zq/rsPk1jJk7rbqhZ3sjeRri017DLWNC5iHmEPnGXzHbWJHNN+bk/N/wjUVb42Ept2MrvOlvBVKEvrs3byQxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458811; c=relaxed/simple;
	bh=UQtUEHaQsqRmHnv53TrlrarbtmDWCkbdmo7byFNh86I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQUvs1WpnY57i/RsKUED/EDkc0Gv7n69cFEvIroDWh5/8saIwa1HJGOdRKLjCKhFUalLfbHeo1b6OhfYo42Rbh0y4DrnQYxWNRXjMRx+10soy9K12NWe40kofQthWoCtR+wyjfPx+5O7wKsLNkZYaWb6HFldk3X+KTcryyoTVwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=McwHpgFp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="McwHpgFp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PA09r8124777;
	Wed, 25 Mar 2026 17:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8c26P9cAngHTk0pkx
	z5TB+Mqm0wiAwcu3yunCC1wMDY=; b=McwHpgFp8Y4Uiybw8qohLxAFB3BpRzn5D
	E98hfOPjCZxjGLFMI4g2Rv3t9GH99GlrorksV7eSwTsZI/NPloelh3K3vS1auTe7
	6XTTmrmrq3tYzbn4yfOBQ9jVtnPZSjkdCkagbTJvQgjAAVuDMDs6LvjDZ7/bInHY
	8iydiicD/RAS0CQHUvq2pHIGyy8LzrfT64/jQYOCz8nrWcSpjxo6ZCfC/1HVI2dv
	QMUcDdPjJcDHBxFiT4n0sRP99C0gDcMkSqR9WHJAv2u4jEnN2S4uWeWn56LEjZFQ
	2gOnikayGrtrshVxAe0oc4gnbiuwgu3hpcJVF/aLu1LG8ZzWh3P3g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv0qx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PG1BRc011824;
	Wed, 25 Mar 2026 17:13:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk79c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:13:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PHDDlH44040584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 17:13:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DE2F20040;
	Wed, 25 Mar 2026 17:13:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01A7520043;
	Wed, 25 Mar 2026 17:13:13 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 17:13:12 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v4 04/10] KVM: s390: Fix gmap_link()
Date: Wed, 25 Mar 2026 18:13:05 +0100
Message-ID: <20260325171311.182210-5-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325171311.182210-1-imbrenda@linux.ibm.com>
References: <20260325171311.182210-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4vKJH0UNDNF2zjngFjAsiLL0SSmDa6uX
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c417ad cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=jDauOpCy_z-6rDg_B6MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyMSBTYWx0ZWRfXzy6py7uo+WEL
 +CknDwosQi24V6ekUIkqzmbFXZ0ki8jw1k82SXYO++GmB1ili52fajaQZNNqQAkdk0ncyJhkqjc
 LCY22Eu7ghIToUD+SEDqz6wvviQRert/+VqMK0SsXvTcZUphWqE9ZYarsbfths+e57Fzh4wCUb4
 LW1hK1pPoNAuxbytQ5TpPkE1xq13RnAw3gfg8alQ8I4BdZBTQu6oMHqxWssu7bE/Gmv6IRs1Ks7
 CeDAEhunYeWp6pVtndH07sYun8LB2sFPdgOn/CWb4rbyquqT93J9YfCbT0ZCIfclkx+/6AQnT9Y
 nkS0nwxym1CO3Jg2huU19K9KU3pqYXcAAG6+j8iAmEUP3/80WDwFQ0WC2pMRtxPgWFd2QbAiKRK
 cCyyBUtWYcije3O3yUi7YKtJnFmVIQLWZBqYW7xlfz3YdnCjwaq2s8jAJiyJx6nupSpD0Gyq+LJ
 C1780fIsyAK1kznrfVw==
X-Proofpoint-GUID: 4vKJH0UNDNF2zjngFjAsiLL0SSmDa6uX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250121

The slow path of the fault handler ultimately called gmap_link(), which
assumed the fault was a major fault, and blindly called dat_link().

In case of minor faults, things were not always handled properly; in
particular the prefix and vsie marker bits were ignored.

Move dat_link() into gmap.c, renaming it accordingly. Once moved, the
new _gmap_link() function will be able to correctly honour the prefix
and vsie markers.

This will cause spurious unshadows in some uncommon cases.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: 94fd9b16cc67 ("KVM: s390: KVM page table management functions: lifecycle management")
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/dat.c  | 48 -------------------------------------
 arch/s390/kvm/dat.h  |  2 --
 arch/s390/kvm/gmap.c | 56 ++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 52 insertions(+), 54 deletions(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 4d44c0f9ad45..7b8d70fe406d 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -997,54 +997,6 @@ bool dat_test_age_gfn(union asce asce, gfn_t start, gfn_t end)
 	return _dat_walk_gfn_range(start, end, asce, &test_age_ops, 0, NULL) > 0;
 }
 
-int dat_link(struct kvm_s390_mmu_cache *mc, union asce asce, int level,
-	     bool uses_skeys, struct guest_fault *f)
-{
-	union crste oldval, newval;
-	union pte newpte, oldpte;
-	union pgste pgste;
-	int rc = 0;
-
-	rc = dat_entry_walk(mc, f->gfn, asce, DAT_WALK_ALLOC_CONTINUE, level, &f->crstep, &f->ptep);
-	if (rc == -EINVAL || rc == -ENOMEM)
-		return rc;
-	if (rc)
-		return -EAGAIN;
-
-	if (WARN_ON_ONCE(unlikely(get_level(f->crstep, f->ptep) > level)))
-		return -EINVAL;
-
-	if (f->ptep) {
-		pgste = pgste_get_lock(f->ptep);
-		oldpte = *f->ptep;
-		newpte = _pte(f->pfn, f->writable, f->write_attempt | oldpte.s.d, !f->page);
-		newpte.s.sd = oldpte.s.sd;
-		oldpte.s.sd = 0;
-		if (oldpte.val == _PTE_EMPTY.val || oldpte.h.pfra == f->pfn) {
-			pgste = __dat_ptep_xchg(f->ptep, pgste, newpte, f->gfn, asce, uses_skeys);
-			if (f->callback)
-				f->callback(f);
-		} else {
-			rc = -EAGAIN;
-		}
-		pgste_set_unlock(f->ptep, pgste);
-	} else {
-		oldval = READ_ONCE(*f->crstep);
-		newval = _crste_fc1(f->pfn, oldval.h.tt, f->writable,
-				    f->write_attempt | oldval.s.fc1.d);
-		newval.s.fc1.sd = oldval.s.fc1.sd;
-		if (oldval.val != _CRSTE_EMPTY(oldval.h.tt).val &&
-		    crste_origin_large(oldval) != crste_origin_large(newval))
-			return -EAGAIN;
-		if (!dat_crstep_xchg_atomic(f->crstep, oldval, newval, f->gfn, asce))
-			return -EAGAIN;
-		if (f->callback)
-			f->callback(f);
-	}
-
-	return rc;
-}
-
 static long dat_set_pn_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
 	union crste newcrste, oldcrste;
diff --git a/arch/s390/kvm/dat.h b/arch/s390/kvm/dat.h
index 22dafc775335..efedcf96110c 100644
--- a/arch/s390/kvm/dat.h
+++ b/arch/s390/kvm/dat.h
@@ -540,8 +540,6 @@ int dat_set_slot(struct kvm_s390_mmu_cache *mc, union asce asce, gfn_t start, gf
 		 u16 type, u16 param);
 int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn);
 bool dat_test_age_gfn(union asce asce, gfn_t start, gfn_t end);
-int dat_link(struct kvm_s390_mmu_cache *mc, union asce asce, int level,
-	     bool uses_skeys, struct guest_fault *f);
 
 int dat_perform_essa(union asce asce, gfn_t gfn, int orc, union essa_state *state, bool *dirty);
 long dat_reset_cmma(union asce asce, gfn_t start_gfn);
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index 956be4c01797..03e15b5e0b9a 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -631,10 +631,60 @@ static inline bool gmap_1m_allowed(struct gmap *gmap, gfn_t gfn)
 	return test_bit(GMAP_FLAG_ALLOW_HPAGE_1M, &gmap->flags);
 }
 
+static int _gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, int level,
+		      struct guest_fault *f)
+{
+	union crste oldval, newval;
+	union pte newpte, oldpte;
+	union pgste pgste;
+	int rc = 0;
+
+	rc = dat_entry_walk(mc, f->gfn, gmap->asce, DAT_WALK_ALLOC_CONTINUE, level,
+			    &f->crstep, &f->ptep);
+	if (rc == -ENOMEM)
+		return rc;
+	if (KVM_BUG_ON(rc == -EINVAL, gmap->kvm))
+		return rc;
+	if (rc)
+		return -EAGAIN;
+	if (KVM_BUG_ON(get_level(f->crstep, f->ptep) > level, gmap->kvm))
+		return -EINVAL;
+
+	if (f->ptep) {
+		pgste = pgste_get_lock(f->ptep);
+		oldpte = *f->ptep;
+		newpte = _pte(f->pfn, f->writable, f->write_attempt | oldpte.s.d, !f->page);
+		newpte.s.sd = oldpte.s.sd;
+		oldpte.s.sd = 0;
+		if (oldpte.val == _PTE_EMPTY.val || oldpte.h.pfra == f->pfn) {
+			pgste = gmap_ptep_xchg(gmap, f->ptep, newpte, pgste, f->gfn);
+			if (f->callback)
+				f->callback(f);
+		} else {
+			rc = -EAGAIN;
+		}
+		pgste_set_unlock(f->ptep, pgste);
+	} else {
+		do {
+			oldval = READ_ONCE(*f->crstep);
+			newval = _crste_fc1(f->pfn, oldval.h.tt, f->writable,
+					    f->write_attempt | oldval.s.fc1.d);
+			newval.s.fc1.sd = oldval.s.fc1.sd;
+			if (oldval.val != _CRSTE_EMPTY(oldval.h.tt).val &&
+			    crste_origin_large(oldval) != crste_origin_large(newval))
+				return -EAGAIN;
+		} while (!gmap_crstep_xchg_atomic(gmap, f->crstep, oldval, newval, f->gfn));
+		if (f->callback)
+			f->callback(f);
+	}
+
+	return rc;
+}
+
 int gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, struct guest_fault *f)
 {
 	unsigned int order;
-	int rc, level;
+	int level;
 
 	lockdep_assert_held(&gmap->kvm->mmu_lock);
 
@@ -646,9 +696,7 @@ int gmap_link(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, struct guest_fau
 		else if (order >= get_order(_SEGMENT_SIZE) && gmap_1m_allowed(gmap, f->gfn))
 			level = TABLE_TYPE_SEGMENT;
 	}
-	rc = dat_link(mc, gmap->asce, level, uses_skeys(gmap), f);
-	KVM_BUG_ON(rc == -EINVAL, gmap->kvm);
-	return rc;
+	return _gmap_link(mc, gmap, level, f);
 }
 
 static int gmap_ucas_map_one(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
-- 
2.53.0

