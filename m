Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914313FD12A;
	Tue,  2 Jun 2026 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422510; cv=none; b=uAhhxNgrjvmeLwl2dq02fxEqCtyfMipryNTdtFaHm783BPhumQfoOYDVCvsk5KPBKXxXO3Y6P0pd7s8BiXcHReWJvN+nysD6uhtSzYsqNu+11AVb7Cn7XZoGo9ytdo27YbGDB6bSZQ4yAOcI+BBLhgeModpgmubX8qWdbOd6OLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422510; c=relaxed/simple;
	bh=MGZ9N380yBlkkeMs+J0Ed61ZTXhDP9IAl1WudocC2EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNyIFn7I9o/wsd6QTQUNG1paKQuRykzir9G4Ec26PGhb53CyhKdNpUID6ypOKk/iUcQOpERf4gtd28MjyFcj06HTjcJYOaGCPv9Cxw1piHFch1o7C6+uYQyWIvO5qlqQuhphui+oRAR8/MfqfvCHNeGN2ipcxWsLbC2nd+1EHXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZEXynHUZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZEXynHUZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6528DN13125231;
	Tue, 2 Jun 2026 17:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VD6xjCFDeD0aXexjG
	x+LC45KuK/Hqa9MrukWLSug2SU=; b=ZEXynHUZhXOb9y4k4V8JrUWHRoF5g9lPy
	PDEETeRA8VUHofJKMq52Ks9vQoBHSkFkeZovxtTq3lS2Iwf1aUTpjEu+BDOvFpRo
	x1TaBtTTDxkOR1P2iNveAO+B4XkDtyuw5zrxx60lzqgD7NtB6sefUAOnt2VSb3go
	ZZI3q1SSRzGodDtNulUDCukrrENeo7T0BHM0Ktvy53+eKS8Z+dup8tFcHs3qMKU1
	ulw+N5zxZ4CIv25yeOOYoVEkU9/p4rQcReen2h3NT06kxv9eoQjxWSmIhPvtttQn
	s5KNEnYT4Bu3onT5uGh1QgV/D2YHJatoOPntU8SnGZ2rCmdEXWXIA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahpyuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652HdSkx031138;
	Tue, 2 Jun 2026 17:48:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qcm9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652HmKsh45941190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 17:48:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AA5E20040;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E6CD2004D;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 07/10] KVM: s390: Lock pte when making page secure
Date: Tue,  2 Jun 2026 19:48:16 +0200
Message-ID: <20260602174819.255785-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602174819.255785-1-imbrenda@linux.ibm.com>
References: <20260602174819.255785-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3MCBTYWx0ZWRfX7juXtRM+dcbp
 qvP1HVtAbDkuY2+QC6UaQ0OIwODjbiR7rWfpd3lG1h1gJSXhb/TjwQMEn4itzsB1U1kkdYHP9i7
 W2Iphi3VOnJrL1h+xGoQhbhibWbKfSeMRl4/z0tv4ZwGqGuw61DLOK4n7HBlThlqMI4kOhTHlBl
 qaLznPHYTkh81jbdHHiDuROGFm79ML4HL9JQBfCW74M+9ZAvDD4sSpSfN6PJJ/m0SI9r9ENU2dm
 oaBq9q0mFaaU3VsvbNpRo1RR4T6Nnh+duTCsEiUXb7xOeznc9FVNpCnipw54UAGOdlbHp+L6xcN
 6txbvg6G7mcDeJVTxBG6qW8p1nTcoxAbLy+yMJpm67pCd0pB1wBl6PX2zxVwej8AIe1gZq3wSrS
 BEJ/TlNMLYjsM4BcSLQphhEva881O44m3W7+cDF+F8b7/V4Qd3Ykk92I1wSlS71i9HUA2eaHOHn
 6k0XVafHfRRalzqcX4w==
X-Proofpoint-ORIG-GUID: iHbwvT3rznICTkeCczceWcCRDEHgvN2S
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1f176a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=MmVNaJ3caS2uU_XaQsUA:9
X-Proofpoint-GUID: iHbwvT3rznICTkeCczceWcCRDEHgvN2S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020170

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

In theory this does not completely solve the issue: if a page is mapped
through multiple mappings, locking one pte does not protect from
calling gup on it through the other mapping. In practice this does not
happen and it is a decent stopgap solution until a more correct
solution is available.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260602142356.169458-8-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/pv.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index c2dafd812a3b..4b865e75351c 100644
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
@@ -103,9 +105,21 @@ static void _kvm_s390_pv_make_secure(struct guest_fault *f)
 {
 	struct pv_make_secure *priv = f->priv;
 	struct folio *folio;
+	spinlock_t *ptl;	/* pte lock from try_get_locked_pte() */
+	pte_t *ptep;
 
 	folio = pfn_folio(f->pfn);
 	priv->rc = -EAGAIN;
+
+	if (!mmap_read_trylock(priv->kvm->mm))
+		return;
+
+	ptep = try_get_locked_pte(priv->kvm->mm, gfn_to_hva(priv->kvm, f->gfn), &ptl);
+	if (IS_ERR_VALUE(ptep)) {
+		priv->rc = PTR_ERR(ptep);
+		goto out;
+	}
+
 	if (folio_trylock(folio)) {
 		priv->rc = __kvm_s390_pv_make_secure(f, folio);
 		if (priv->rc == -E2BIG || priv->rc == -EBUSY) {
@@ -114,6 +128,11 @@ static void _kvm_s390_pv_make_secure(struct guest_fault *f)
 		}
 		folio_unlock(folio);
 	}
+
+	if (ptep)
+		pte_unmap_unlock(ptep, ptl);
+out:
+	mmap_read_unlock(priv->kvm->mm);
 }
 
 /**
@@ -127,7 +146,7 @@ static void _kvm_s390_pv_make_secure(struct guest_fault *f)
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

