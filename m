Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817A3E0C66;
	Thu, 28 May 2026 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968860; cv=none; b=exAvzCENvUzhyOyl0nuU3fkRnyk4GBpABkQSAx+lfMOORqKh9ZboeijIeBPLAJ5fsJYcrbPbYbC3mPy1/lXo5yRUDCy2AMIA4H7lOiodkVeqFrBiR8xaVhjrcgfSNGxJ2R0GCgwP7Zq2iUWonJJ4aOy65oXuBjuXo6O6UGs/61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968860; c=relaxed/simple;
	bh=eNqVmeTfeJYH+iXdavogpx7EVs4tNZWFz1weDRzggoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvEzpNGjjKiyfatwYNrRAADTi39mgg64wH7KjecYC/vtIo3gw+90+U3gCekGLkIwwj83zfCw80uau0RmnRuts8QJ5G0pBeaDPSUlIVflkG1+P3jEpOL49cuqpbFhcN0y6jbbiZz+p9k2hv+YDaZvkdaf/lWlUo7timW1n8aS15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JEVay4Ve; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JEVay4Ve"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RL6fxH3139218;
	Thu, 28 May 2026 11:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=H3PLpwos1CiiWA3Bq
	XNRKIVsfLPTfE0kt7pA6Nfl+lI=; b=JEVay4VeP78gqFnuBCnJ2Y2LKE6MrEvxd
	kOa1f+ZPYEoCnPq/1p412RiUjWgVUuyawh4GjZw4Mmf/t/A6/XqrgFHOTOHTW0jM
	cOHI6Yaue7/vuh9GJ4IBZ/cX9xZWC7opJoDz5gpid/HLimPs+btjcyIQqb/JtLkc
	EH7XyqkdhIyXJGHbwTI+9D8QIwzbz1obHq0uqoxjooC+y+iXvYS3tEgVnctFNZj+
	AvQxnD9e03TTCkW26UiKR/uT40rlgYZ0gesTLAGhINhuOMSSThx7IbxWNaQs3Ca0
	Jh9WukHU4RgjOlTyUkxtjKCf6VuEebn7RT4jI280O+U9Y9aBl9atw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee887jmun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SBd6US030811;
	Thu, 28 May 2026 11:47:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb7wda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SBlTJk51118574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 11:47:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B562720040;
	Thu, 28 May 2026 11:47:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 874DF20043;
	Thu, 28 May 2026 11:47:29 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 11:47:29 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 6/7] KVM: s390: Lock pte when making page secure
Date: Thu, 28 May 2026 13:47:26 +0200
Message-ID: <20260528114727.142178-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528114727.142178-1-imbrenda@linux.ibm.com>
References: <20260528114727.142178-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QLJYgALL c=1 sm=1 tr=0 ts=6a182b58 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=KoT7INjNzoFCoOw_JEkA:9
X-Proofpoint-GUID: wb1R5Y70SUP4CEmfUgKeCL6DC2Kw1qLU
X-Proofpoint-ORIG-GUID: wb1R5Y70SUP4CEmfUgKeCL6DC2Kw1qLU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDExNyBTYWx0ZWRfXzIq0dSNdvEXM
 zvtM16SANt/c8QVTg7/fD2yefKmFcP+74KCSER5FBdAD1kmnrAA7uD6ziEtI5mc3/SIR0qh9Ywk
 hYQQ24lmb8gFuyMT6BxGDzYMCH127BoNYCFRZ2jT29dZ+hKP0bptdHpxn1Z6+obmWeJHXUJ+tVp
 m/IvKLDKC65xIy25sRZgQm3+fkXuvE1MKeRNbivhkHrV02VCJIz8gvYO3DGEC0iPbKXnX5H1Ic9
 MxDfcSrNoYRp8rgpISeCrr/cqPBkeATRdfKu1uRCC5pl2RAhIJCOhLcwvrojDMSN0AeMV5+VynC
 vet08FWnlntp8cz6a8is/ST7RpYchwYlx0OS8kgg5bEOUIbZXCDtff0vXwv/y4KZwuXSnZAslND
 domTqDBy35/aQ/LLM5hufvxgdJdN+YIaFlvpMIOBUxA2Ho4NE/hHkILTsbfQfl8kTh/XBTFSr0Y
 /3OnuRhyTSuRbhJLCcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280117

Make sure _kvm_s390_pv_make_secure() takes the pte lock for the given
address when attempting to make the page secure.

One of the steps in making the page secure is freezing the folio using
folio_ref_freeze(), which temporarily sets the reference count to 0.
Any attempt to get such a folio while frozen will fail and cause a
warning to be printed.

Other users of folio_ref_freeze() make sure that the page is not mapped
while it's being frozen, thus preventing gup functions from being able
to access it. For _kvm_s390_pv_make_secure(), this is not possible,
because the page needs to be mapped in order for the import to succeed.

By taking the pte lock, gup functions will be blocked until the import
operation is done, thus avoiding the race.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/kvm/pv.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index c2dafd812a3b..3a7410f6b609 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -17,6 +17,7 @@
 #include <linux/pagewalk.h>
 #include <linux/sched/mm.h>
 #include <linux/mmu_notifier.h>
+#include <asm/gmap_helpers.h>
 #include "kvm-s390.h"
 #include "dat.h"
 #include "gaccess.h"
@@ -73,6 +74,7 @@ static bool should_export_before_import(struct uv_cb_header *uvcb, struct mm_str
 struct pv_make_secure {
 	void *uvcb;
 	struct folio *folio;
+	struct kvm *kvm;
 	int rc;
 	bool needs_export;
 };
@@ -103,17 +105,24 @@ static void _kvm_s390_pv_make_secure(struct guest_fault *f)
 {
 	struct pv_make_secure *priv = f->priv;
 	struct folio *folio;
+	spinlock_t *ptl;	/* pte lock from try_get_locked_pte() */
+	pte_t *ptep;
 
 	folio = pfn_folio(f->pfn);
 	priv->rc = -EAGAIN;
-	if (folio_trylock(folio)) {
+	if (!folio_trylock(folio))
+		return;
+
+	ptep = try_get_locked_pte(priv->kvm->mm, gfn_to_hva(priv->kvm, f->gfn), &ptl);
+	if (ptep) {
 		priv->rc = __kvm_s390_pv_make_secure(f, folio);
 		if (priv->rc == -E2BIG || priv->rc == -EBUSY) {
 			priv->folio = folio;
 			folio_get(folio);
 		}
-		folio_unlock(folio);
+		pte_unmap_unlock(ptep, ptl);
 	}
+	folio_unlock(folio);
 }
 
 /**
@@ -127,7 +136,7 @@ static void _kvm_s390_pv_make_secure(struct guest_fault *f)
  */
 int kvm_s390_pv_make_secure(struct kvm *kvm, unsigned long gaddr, void *uvcb)
 {
-	struct pv_make_secure priv = { .uvcb = uvcb };
+	struct pv_make_secure priv = { .uvcb = uvcb, .kvm = kvm, };
 	struct guest_fault f = {
 		.write_attempt = true,
 		.gfn = gpa_to_gfn(gaddr),
-- 
2.54.0

