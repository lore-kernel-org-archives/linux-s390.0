Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DAC3EFD1C;
	Wed,  6 May 2026 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076733; cv=none; b=bPptxi6pZOwwWylvAXG97ylaGSiRdJVKKHMYVz8w4rXC0JOJFsDBVkTQ33gzSE2uHezWdeiozuKNqlyi5NPJYTd8/D+vrjHiWLjDwga5RI7PnJbE6dY/T0R9jgWlTjmXn+CeNKh7VW2TZRy6PGVLDY3/He0oVRe1mzd4wSg6uLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076733; c=relaxed/simple;
	bh=PQXL2q8lPz28tHv3UNIhhZHz7U9Srk3+0bqAXPx1isU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArG9ensP2hbDDMduyCkD/cxO/lU+RHujT9DrGxDg+2x99M+yC2I6E38ztYtGyqRePoseiadUy3pOoKHYNZZDdOQM8tVq8SDuebe5Rmmif7eCVfePXFIqr8AOd8a7dkcIUasELS1oUDu/6a+i8WFG1DjDiZmBXgVVvKFcfQX85+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=noA8kfOb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="noA8kfOb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645MtRoe989845;
	Wed, 6 May 2026 14:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HEftkmCaoDUHlx8a+
	3vIvDJinmnGodSU8A50Eix8Pz8=; b=noA8kfObQWZ52T524zqr251gJuprTbakm
	Z0IPTqcP+dPCkyKsWoemIAaHyoCKFtbkT9AuebFu8XwwQWNT6ndWxi93BX8pTYwa
	yhN5biyp4fkBlUqkKA91bnI8/Ac8V6nmfScrlr6ff8QiXpIiUWCMikIaEMJq5eeK
	C+NjfSSijZP2Z4oDuweYFLtDYu85eK+gyTd6JWwx2JVrwTjqDxkwoIlLnBh11XIn
	r2vlOw7bXVDbTUxr+l5wD56VxIYVZZihshjnrqdR9MV9M4WuVLcjV2zl+JGvXvWu
	pfbZHro67wRXq33o0QGfZ4v8EC5gLU/GPrjLFhd0UKdeQ8WsUsFkA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6gcv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:12:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646E9bIR024653;
	Wed, 6 May 2026 14:12:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3h6g2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 14:12:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646EC0aw62914898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 14:12:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C675A20043;
	Wed,  6 May 2026 14:12:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA4282005A;
	Wed,  6 May 2026 14:12:00 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 14:12:00 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 3/3] KVM: s390: vsie: Fix unshadowing logic
Date: Wed,  6 May 2026 16:11:59 +0200
Message-ID: <20260506141159.154240-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506141159.154240-1-imbrenda@linux.ibm.com>
References: <20260506141159.154240-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fb4c37 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Ww7HMaUJomrHWgeF4nUA:9
X-Proofpoint-ORIG-GUID: k10qdcYFr75xG3EjYB18BhP2rQbZTOb4
X-Proofpoint-GUID: k10qdcYFr75xG3EjYB18BhP2rQbZTOb4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzOSBTYWx0ZWRfXz1kztoRrKlBL
 DikW+M3vurUoZAfKIi+GPpjoPop9XaesyApvlaMzMDyCS09h2MhZqxur/xPIBwWMM3zP2dgt+fs
 Z7PRnTAmXGARQPjcXh8jf1ZRezY5Tjp3cU8kk/JzutHw5Je926DprQtVhu8ulRg8nDp1U7G9z6Y
 Ys2KOdysFEfMcXGufOdZzRFm2ZfNTLhJryHXGmCD/D0ggBVNq0eZlxk4+iQ9O/wwvL7RHh0NEV2
 rIoP8wFgTstYN7QVRTHUftz9gY6+NcBbxCc4Tv74n9vFjkPdV9jQo7Ttm4/5AxBJ4ZRb/nAJAWq
 SoPwF1Y0aI2gpfcq+x168zGC4NQB6UjP0PwsryAqFjC/mlKPXHN9+toxECPtJxTQOmsIfuP51Y8
 mtj+qtOfgGz917UGwBOObKyq8nJne4JlXO7CLCAfuI8FqS9COcdyReyPH+CPuhRaJ8r7d1ZpN2e
 VvRf3iChu9HyUYTFvYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060139

In some cases (i.e. under extreme memory pressure on the host),
attempting to shadow memory will result in the same memory being
unshadowed, causing a loop.

Add a PGSTE bit to distinguish between shadowed memory and shadowed DAT
tables, fix the unshadowing logic in _gmap_ptep_xchg() to prevent
unnecessary unshadowing and perform better checks.

Also fix the unshadowing logic in _gmap_crstep_xchg_atomic() which did
not unshadow properly when the large page would become unprotected.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
---
 arch/s390/kvm/dat.h  |  3 ++-
 arch/s390/kvm/gmap.c |  1 +
 arch/s390/kvm/gmap.h | 12 ++++++++++--
 3 files changed, 13 insertions(+), 3 deletions(-)

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
diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
index c1140da0689d..08fb806c9c36 100644
--- a/arch/s390/kvm/gmap.c
+++ b/arch/s390/kvm/gmap.c
@@ -1053,6 +1053,7 @@ int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gf
 	pte.h.p = 1;
 	pgste = _gmap_ptep_xchg(sg->parent, ptep, pte, pgste, p_gfn, false);
 	pgste.vsie_notif = 1;
+	pgste.vsie_gmem |= level == TABLE_TYPE_PAGE_TABLE;
 	pgste_set_unlock(ptep, pgste);
 
 	return 0;
diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 96ee1395a592..f4caa3f42c0e 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -167,6 +167,13 @@ static inline bool gmap_unmap_prefix(struct gmap *gmap, gfn_t gfn, gfn_t end)
 	return _gmap_unmap_prefix(gmap, gfn, end, false);
 }
 
+static inline bool needs_unshadow(union pte oldpte, union pte newpte, union pgste pgste)
+{
+	if (pgste.vsie_gmem)
+		return (oldpte.h.p != newpte.h.p) || newpte.h.i;
+	return (oldpte.h.p && !newpte.h.p) || !newpte.s.pr;
+}
+
 static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, union pte newpte,
 					  union pgste pgste, gfn_t gfn, bool needs_lock)
 {
@@ -180,8 +187,9 @@ static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, un
 		pgste.prefix_notif = 0;
 		gmap_unmap_prefix(gmap, gfn, gfn + 1);
 	}
-	if (pgste.vsie_notif && (ptep->h.p != newpte.h.p || newpte.h.i)) {
+	if (pgste.vsie_notif && needs_unshadow(*ptep, newpte, pgste)) {
 		pgste.vsie_notif = 0;
+		pgste.vsie_gmem = 0;
 		if (needs_lock)
 			gmap_handle_vsie_unshadow_event(gmap, gfn);
 		else
@@ -217,7 +225,7 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
 		gmap_unmap_prefix(gmap, gfn, gfn + align);
 	}
 	if (crste_leaf(oldcrste) && oldcrste.s.fc1.vsie_notif &&
-	    (newcrste.h.p || newcrste.h.i || !newcrste.s.fc1.vsie_notif)) {
+	    ((newcrste.h.p != oldcrste.h.p) || newcrste.h.i || !newcrste.s.fc1.vsie_notif)) {
 		newcrste.s.fc1.vsie_notif = 0;
 		if (needs_lock)
 			gmap_handle_vsie_unshadow_event(gmap, gfn);
-- 
2.54.0

