Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3F13BE144;
	Tue,  2 Jun 2026 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410249; cv=none; b=D/LBLc2gy+L7LqXZoCyGfgaALvItJn5o4A0sUIQ54PkA08uFYzXGBcPfO/Qk2OHWPgnTeT81k77KIQzgmwNW5KDXzkqJyG6iaEVWqO/w9y6vs/s1laDTML6WBfj3wzV+qvHcozZhZPMdKmexBka465f1pxtOOweIYQaB9DAesGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410249; c=relaxed/simple;
	bh=SRo5IBgPJeMhBd66Qkgvhd2/r+7I6kqyIzsB+7f9zvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIk5V4QCO27PLGG5niFWxgDT1s0dBbKZ8V919lwYloNFbZvrP824avWU6lD9Jfg0HVFzajp3XuyUiaVcCljWxKAvChAe4/rDNmn3AXdoSuOH0ZDhhC5kAcDQYFZCL91G52An01pArdx4JPzDBiYUl0DHoeAnGj3sgF0gnHj57c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oGzXJaUW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oGzXJaUW"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6520RDQ13642169;
	Tue, 2 Jun 2026 14:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FWfLyhJ6GGIDHWn6o
	RZIqvW5vDDYDL2zoOflL5hy3jM=; b=oGzXJaUWGuA4qvHqOTYr2ys6dWvV8ThT6
	UV9gJEboorQklpkB3FDeDN6iSGufWQa4QgBOh/QPVxkJrZL4FDTZXayxHC1AzeuI
	js9myCbmVySCpJgLMxxOT+glgbiXNBrwb9+EyB+KoeQNTCBiLs8GxRrhAf0ySuGs
	3LQEUPZCw9eeWjkbTImtNLChHtLcg6wXoGpbdKWnkjWvpAcJ3CKnS3dJOAKkWBJD
	lHvQvBComoCZ7JjLMLfeYPLcZ+Lo8HgTQV3EdqvoFLqlgcXgjR5enteYUibNEgEH
	4DXQdfCPVESEzrfFoHB+c3Kk6hHzMxBI+cvtD1drMwnTPX10lLlQw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahp4gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652E9AjD014051;
	Tue, 2 Jun 2026 14:24:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegkcjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652ENwjM36962784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 14:23:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 405CF20040;
	Tue,  2 Jun 2026 14:23:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17AA12004B;
	Tue,  2 Jun 2026 14:23:58 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 14:23:58 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 07/10] KVM: s390: Lock pte when making page secure
Date: Tue,  2 Jun 2026 16:23:53 +0200
Message-ID: <20260602142356.169458-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602142356.169458-1-imbrenda@linux.ibm.com>
References: <20260602142356.169458-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzNiBTYWx0ZWRfXwPWpkZJ8AQce
 bWbvSA5gIOeKRfhAioq8Vpup2fZ+8GiCrSrPyZyl8IPiMVHrSPmL7G/tvcKlWvtA6qfAn2ZBsHe
 kV1RY9mnzZ3lFf1o7pKUN2W9bgYzoasbFimCLe81upP+GpSEHLzWG4fpO7PGekuRg6Med8u/z9o
 xtLQxXzVwrfqHIpqGaC2J5SP1Yxv7iXGKa+5Z5UFtNzWLh7R+1E4PVfsBXWJf1FOad0g26jfRZk
 MiQ+yoxV5wFc6zhYeDm8BHHELV9FwfRuL47ysTSEw71kGu4MbypDtZ3kqfX5Vb7beXs1AC965Em
 0jV2p+z8+3LNRA9ba853GuF8EQcBB3lPkYozviyaNOWps99pCxXvGLSq1VVNyZt/YLyguFwe7VM
 XQOlhb434IkqP6AYtXQ0pBSzGOQixBCMmNsMM7cMZBfUFKNYuSrnpu02FOKEE0eUCeOufE18izD
 WSsvkSHAW4GAnlxc2gA==
X-Proofpoint-ORIG-GUID: Ql_3mSPYC-0-pvfUaRZ25xdQDXoKYPDE
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1ee784 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=MmVNaJ3caS2uU_XaQsUA:9
X-Proofpoint-GUID: Ql_3mSPYC-0-pvfUaRZ25xdQDXoKYPDE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020136

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

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
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

