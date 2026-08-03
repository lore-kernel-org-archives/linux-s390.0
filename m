Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A53420475;
	Mon,  3 Aug 2026 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777712; cv=none; b=d7/8aHOiAR7Ts4PpYtdBkp0/lYcgy/RapdOZzYivTQuiSrrex8yoViQrn5T/2eLdWLewvptwiCTLGYTNC9KReqBrG+ecdcNXBp1ij1GLT4DlC1PJxLpEjKcPCn2JdpVxmVHn29JNMfS7MlgnFVSVQo2RG9GBZ8Z++med3SKdKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777712; c=relaxed/simple;
	bh=1hpUAB5Bl37yqmVHvL+u2kMqrdEZwdsCOrgl0+7me/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvsK6tGWlnc5dgcRsBI9mpyHT3D1L32gYb9AJDZzz4auWprZhbY0QXARvA/P43nW5OfjhF5FDDtwBFDhPgg5CQgk6tPe+lF6d+HqBGQSrL8je8wjm3sOCszz+cVZO4b8TEEFJXHf8m4W2/nr5XHd6Iov06aYceZEU1CkzqU8KDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BSr+AqQ5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BSr+AqQ5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673HHnQo2744422;
	Mon, 3 Aug 2026 17:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wg1t4ubwJ9RV0NobU
	zgbGsTFyV1NhYdIWFtI4mMlBkA=; b=BSr+AqQ5JoXU92FLJM2PxpmUgFvPPjY95
	3hrOPyfNutf1Dx0+y3IIf6VYJDVsvST9Nx4PnKcG0SZgC0P2RUAWyp/pbfoenN90
	N1KZDJOcIPA4dPoZXAYdlhKmIp4L9pa0lrNizkTt587iPPGOhkcm8BgtuWsy/4aq
	FjfWdbMTfRqlMtFM5+I9QGpijkZhGzUMtPiweDbdqrU1PbVGboziPAeZQXSlImRK
	84iEX44xSztccSYfPIecFxvaOYeDPljWLyAJ0gCegaVhXGv+JNTfJmSlg+E3tjf0
	a5qmaE1EJNd5K0xqJdzYSTnByiHhf5IDsaIImI8dYIoqd9wwfLofw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euhnc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 17:21:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673HBc4e005677;
	Mon, 3 Aug 2026 17:21:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh6dm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 17:21:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673HLjQk51052858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 17:21:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 349B82004F;
	Mon,  3 Aug 2026 17:21:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17A3A2004E;
	Mon,  3 Aug 2026 17:21:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 17:21:45 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] s390/mm: Add __context_unsafe() attribute to gmap helper functions
Date: Mon,  3 Aug 2026 19:21:43 +0200
Message-ID: <20260803172144.827049-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803172144.827049-1-hca@linux.ibm.com>
References: <20260803172144.827049-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kVKXYnxPgf-yKnxrhv_m0ssBQVRiNSL5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE1NCBTYWx0ZWRfX1Om2g+79+Zx2
 D0/YJUk4oMqJcmBXmsbedAYBxVRGxLIK76p3AfxL4qXgGChS+zGDUBzfI4gUMdyUSpeIEKsX0zP
 frer/HoOTfs0kg2YDkkfs6Hf4nH+zSw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE1NCBTYWx0ZWRfX0YRWyAZMKM1B
 dSwuk87pikIOZsPHtTdFpB2X+TEr+YyWK9h96nnIIDWevvDRjTdUfypGMx+FtKw4kTBMYOkbXyE
 y3A0BnQ5EQ22HjQF8VdwWGH51d7FKuYyHRdK7fPeQk/QT9wr9QGe3PKxB0WzpAbYrci+5hdDWYq
 Q5WGzTdI7snjcq/cfiKn0qKLoylihsiEV5j+qbS8HA5gLX0PFe2WSsCA+SYSt5ArKnKagt0vliz
 AJY1+7+nyl2POYcU9802iN8/dP2XNY7r3XpsClCCuxJk+NG5TfxINwjOJpTYyF7CHvcG/5Lbv6S
 i54JJD8hDBsMECyuXR1FjuybLGfkK93w0Vle1O805jU4/Jc7/YdJGycNBpAhqFIlKmSgK2RNDBf
 /Owkcz5KGIAV3wtoCnk6L+s/lcPPcDWqdNqbXCE3yp3+GiUPZLUD+iO91mdnwbk9M1QPrerM/6S
 50CICFoWx258pXPF5mw==
X-Proofpoint-GUID: kVKXYnxPgf-yKnxrhv_m0ssBQVRiNSL5
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a70ce2e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=731AlwBMPmVrNEvb580A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030154

Disable context analysis for various gmap helper functions to get rid
of a few warnings:

arch/s390/mm/gmap_helpers.c:80:1: warning: spinlock 'ptl' is not held on every path through here
arch/s390/mm/gmap_helpers.c:116:2: warning: releasing spinlock 'ptl' that was not held
arch/s390/mm/gmap_helpers.c:186:2: warning: releasing spinlock 'ptl' that was not held

Use __context_unsafe() to give a short comment why for function context
analysis is disabled.

try_get_locked_pte() is disabled since it may return a nonull value
regardless if it returns with a lock held or not.

This cannot be reflected with the context analysis attributes. It is
however possible to workaround this e.g. by adding a another `contended`
function parameter, however this would lead to the next problem:
pte_unmap_unlock() is a macro and therefore doesn't come with the
required context analysis attribute to address this.

For that reason also disable context analysis for
gmap_helper_zap_one_page() and gmap_helper_try_set_pte_unused()
until this has been addressed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/gmap_helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index 4bf7c9012feb..f910c9584560 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -40,6 +40,7 @@
  *   and locked.
  */
 pte_t *try_get_locked_pte(struct mm_struct *mm, unsigned long vmaddr, spinlock_t **ptl)
+__context_unsafe(/* Returns nonnull if lock taken or not taken */)
 {
 	pmd_t *pmdp, pmd, pmdval;
 	pud_t *pudp, pud;
@@ -90,6 +91,7 @@ EXPORT_SYMBOL_GPL(try_get_locked_pte);
  * Context: needs to be called while holding the mmap lock.
  */
 void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr)
+__context_unsafe(/* pte_unmap_unlock() not instrumented */)
 {
 	struct vm_area_struct *vma;
 	spinlock_t *ptl;	/* Lock for the host (userspace) page table */
@@ -161,6 +163,7 @@ EXPORT_SYMBOL_GPL(gmap_helper_discard);
  *          disabled.
  */
 void gmap_helper_try_set_pte_unused(struct mm_struct *mm, unsigned long vmaddr)
+__context_unsafe(/* pte_unmap_unlock() not instrumented */)
 {
 	spinlock_t *ptl;	/* Lock for the host (userspace) page table */
 	pte_t *ptep;
-- 
2.53.0

