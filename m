Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0433DC4C9;
	Mon,  1 Jun 2026 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327816; cv=none; b=fbHUCf14kIHCqApoRlfgmxpfFBLnoQmev+XiWVXhX6gYtFca5Y2mXIX/zr3PJpVq8JnIF12DnuU2nqgu2R76jab5eAhoKVF0QMvhGA/LZHbro42dOUaLKY6jODWfPlvx8r4k7Qki927JBSXryCsx1PCfbksS/3b6Z9QKf/mdLE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327816; c=relaxed/simple;
	bh=SRo5IBgPJeMhBd66Qkgvhd2/r+7I6kqyIzsB+7f9zvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQaeYo6YNUbIwhjU+tjQYGgBF6KWJValyUmSPDnd7kCXDb9nNRJzv0pmeLiuajTkL/3WG59LaPZAh5cZ4bDnUBwx8V4hQBc+odJHarsdSSIJi84g4r3kej38rbAEdgTMwQ9sz/+YSP+8UWuXXdPgIMXe7N9SMTSdzB+PndiDka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gXT7EJDa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gXT7EJDa"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651CxD8G432511;
	Mon, 1 Jun 2026 15:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FWfLyhJ6GGIDHWn6o
	RZIqvW5vDDYDL2zoOflL5hy3jM=; b=gXT7EJDa40kJUxfjLegNQJUwAcCdyIIzU
	AazUrsW2YS3dQJg7YUTq7MC2V/ea9yqBXRXAz8Buv3KQSuxGNj9Q83TrEE8io5UT
	KUwDzd98EUUuM2S+9kN6qvwqnWgULfZZdsFoqSuYfwJHD4QyvOylk1gfemfP57hr
	lusqZpspolfVsfSsr6TxVZl5AwLA4DyvEwNDnWXtryf6LJTXYVX7AKDw6eWAN3+f
	ehvTuu0ugtttuEEbYtdwcoyc5Ruxbf7XqIO8vl9qsZmVdnOnR/HzPjTOmN1C/S2s
	eVmI/lKZ0gQindzMfm2k1k6dcyisk/fb1GhiFvdvpC0+y3SM90XZw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht12yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:29:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651FO5rg022873;
	Mon, 1 Jun 2026 15:29:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7jxs6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 15:29:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 651FTrdG51511678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 15:29:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 629A020043;
	Mon,  1 Jun 2026 15:29:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39A4720040;
	Mon,  1 Jun 2026 15:29:53 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 15:29:53 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 7/8] KVM: s390: Lock pte when making page secure
Date: Mon,  1 Jun 2026 17:29:50 +0200
Message-ID: <20260601152951.196859-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601152951.196859-1-imbrenda@linux.ibm.com>
References: <20260601152951.196859-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ypF_omuVHZLZoiMCS4MfrC0gKKg-4-nV
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1da577 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=MmVNaJ3caS2uU_XaQsUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE1MSBTYWx0ZWRfX88l8x/YSQVqM
 1rht6nNANIzNs6on/jN71AgWwNcqx4WXVOcU4fmaeij3gCksl3A2NzSLRUHYKGNQ4CbTsOjaEiX
 MhhQGKC75SC1UzUxWOVE+MmlMz29K/1cu9BId/GZ4cxVwcxZ3WmdM2w/XnsUKZV8WuQvcLA2gLA
 FNoovLws4+P18lzoT518JO4Ia75BDBVWLS0eM2GOHkIgS/W5Zvp+9NdFVAP0aL1BDjh98gpKYft
 yQDbiidJrhrMQ+D4KVBOZgqsdAuj+x8Jdv8J/S14qOD0ECTBE7UYl5bUPmgO/U+QH7X3Rkte0i9
 o0LizGNcDkSRDjwmdWFZ0UqnU/Fa+heKscp2zI/GYtHxtoPc/LSH1eILnd1T+7z+xH81vl9EWGy
 OFJpRS4iSa55vO+CyyrL6Kn21dGkxlrrv9+UuxIdLlkduT0plROpLf/Lyfu+fn4jFv1uDXleKS2
 +zeO+rpPYPK5CDnJm+Q==
X-Proofpoint-ORIG-GUID: ypF_omuVHZLZoiMCS4MfrC0gKKg-4-nV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010151

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

