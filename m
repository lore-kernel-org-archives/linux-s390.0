Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4B33B6EA;
	Tue, 12 May 2026 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608384; cv=none; b=sdSl91CMCmvT8dLtZpQL4siGW67I4/WW82xHNLDa2P71WXTUCLMQAFnD7Vu86SzG5A7BaI9nBzeIsYmwdcvrzsqDmHJeoF/06nOT9sV+xktDzjm+UK/tpQQ+Fm1P8Yd7bDtbkpmGBdPQqUftV+ExbPlD+YIt5rGVl6u4W+yr00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608384; c=relaxed/simple;
	bh=hkaG77L11yqLNwMqbM+czki+C7bDucmwuQ3K3BIU75k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usJ9uhsFnlDEAfbRRV/dT93bpco9Ts3tk3ZtjjlGigQAvDT4wBuJ4EXV4tzpX553eh7hZBpkPyBMYwLCaWWEeQiaJH6kORHlF5BW+SPrFA2qTcfZVLkKjvueNZ4Bzmz8xG59ML+svmgBwi3dylP9dKb3z53VMEGKsW/b3iQpXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NROp6EKV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NROp6EKV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CFQ43W3827529;
	Tue, 12 May 2026 17:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/hHD4lUf9fvdwfDnt
	jF+OnSypyNh08eTAbjDCXvsE/g=; b=NROp6EKV/q5bv8bJnPFPhTeDVsbomnqR1
	3732KZKBqIK6aqR4RVT/zXRZ5XdTVOCobzhYA6F6o5IfDZpP0W4grCnhwvP0w6dN
	ONgBOchcQ+Hh/Pl98bqCIxumt0WxV2VDXFGg3g/KMK38nnxawr3nmhVhn4KimNq7
	wJW2xF/50mbrU05+azgI7LRjCQcDlXcfLfXBprb+FAJQi/gY3jhA1qXCSg82qaDe
	rEFINDvhraW0Q55iAF9KBYODD9tv8CEdBwqjJFtAFqiGuvHj4ahkOzQbP7JK8FZX
	O7YAWKnM9fiqAf9Vh9pfyjlH+y8bZfMRgwlgtOoEzZDd8rzJ9wU3g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6m54e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:52:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CHddZv029834;
	Tue, 12 May 2026 17:52:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgc8pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:52:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CHqq4w37618102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 17:52:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C880620049;
	Tue, 12 May 2026 17:52:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EDF820040;
	Tue, 12 May 2026 17:52:52 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 17:52:52 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 3/5] KVM: s390: vsie: Fix unshadowing logic
Date: Tue, 12 May 2026 19:52:49 +0200
Message-ID: <20260512175251.300882-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512175251.300882-1-imbrenda@linux.ibm.com>
References: <20260512175251.300882-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a0368fb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=LTrI32VXtVmKWDySyG8A:9
X-Proofpoint-GUID: xlW0flP1LpkrGhwOCsmoMFdluBb8BpMl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4MyBTYWx0ZWRfX1oWmr3TdkGNm
 IcH5Fk3j/o0jiy0uI371hZ2jcGO0aX3Zf0O8KNwA7+HGagEqUK6X277XODqzf8pxphb2rBl6HEh
 UhbDbeaPR4vCVLTXfkVaisqCAa3WPVwF9K2tgpxgNbByhrRPvsy0IZHtgHJwm6aUAqdYe6xDF21
 Lsc2ZDK0mP+fYK/wHp68yuT2tmCD3JteJlHsAIXW6qBKK2edMNscb6a9Hk0dziGWS/66rnLtlA8
 KVH5SkesqINeuWMUYuYYIrHuyPtSmEBDD3TRYPlKN6CK41K3V1YWueEc4yGJgSui900zMNqHVvd
 5wNFqMzcOmE4si53w1sUaNfETGZziZpeG+3ymWIo+kh7XgOeA6OnO4lj1L74IIe2y1mAtxOK3ZP
 8gE7Cungyl6CqJgKUzNQ0HBWP5VfXrI5mLxzlWojEW8TEsvOMRk4zuBzEAvuu2RuCLcrHlvK8YA
 Ebgukd7w191WEaCR+Zw==
X-Proofpoint-ORIG-GUID: xlW0flP1LpkrGhwOCsmoMFdluBb8BpMl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120183

In some cases (i.e. under extreme memory pressure on the host),
attempting to shadow memory will result in the same memory being
unshadowed, causing a loop.

Add a PGSTE bit to distinguish between shadowed memory and shadowed DAT
tables, fix the unshadowing logic in _gmap_ptep_xchg() to prevent
unnecessary unshadowing and perform better checks.

Also fix the unshadowing logic in _gmap_crstep_xchg_atomic() which did
not unshadow properly when the large page would become unprotected.

Opportunistilcally add a check in gmap_protect_rmap() to make sure it
won't be called with level == TABLE_TYPE_PAGE_TABLE.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
---
 arch/s390/kvm/dat.c     |  1 +
 arch/s390/kvm/dat.h     |  3 ++-
 arch/s390/kvm/gaccess.c |  1 +
 arch/s390/kvm/gmap.c    |  3 ++-
 arch/s390/kvm/gmap.h    | 22 +++++++++++++++++++---
 5 files changed, 25 insertions(+), 5 deletions(-)

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
index 96ee1395a592..e490f2995a26 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -167,6 +167,15 @@ static inline bool gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end)
 	return _gmap_unmap_prefix(gmap, gfn, end, false);
 }
 
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
@@ -180,8 +189,9 @@ static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, un
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
@@ -198,6 +208,13 @@ static inline union pgste gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, uni
 	return _gmap_ptep_xchg(gmap, ptep, newpte, pgste, gfn, true);
 }
 
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
@@ -216,8 +233,7 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
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

