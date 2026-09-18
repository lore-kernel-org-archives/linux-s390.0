Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF98D4E9C20;
	Fri, 18 Sep 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744181; cv=none; b=KqVfKi/mpT9sfAah1P38nsWSHd6rAizD43tguy7ZfY7XapXihmzf7OE4QpeD4NuSLwcCv8qolkA/lan0AbbIpC61sSwPn4+YEInx06Jfj2TJCmJCWx9fIdR5JWnfxixzdeuO2SwsWm1cbEN6u2mWiTKdMxIG+AD4kdouIxJqhO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744181; c=relaxed/simple;
	bh=1d/ElOgjNWOLvso2yHSfNvLdQTtu69dW57Nfq5pIx14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uyq1EpSQ28bGPfUvx17XrhFpWqTXsvhujktHZxY8m4qECa62rVCDOqBwbusiHOHQ2GXPuSGHDFSMA1jLmSsp0TiEEZNzrSZqArjXCdtX6s3vzynL82jOV/CgayqG56jwIPEsIHYyA5mW/tEY1/tPNs/5x5HIFS6h8ukpub+laR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c0AIAzkh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c0AIAzkh"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVcir1421259;
	Fri, 18 Sep 2026 15:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XI8aiu
	VtwtLBDksj07nEbzOSbLHJGk8g4GudQzZ7BbQ=; b=c0AIAzkhjqWK7WGQFlQW8s
	COwJg3AnUAePYB96oMhz+czZEjnMV0Nd8U3wOo60aQRHvdgbO0/Br6kJxG3w8Clg
	33CGGruOPNKLSsTGJbFu54pMi62v+9uHz6VRSYA2st4kMEeJkfBIGrlndziaKIyZ
	lNcqTcbN+3tlqwtYa6828BSxSLLZIr1xfMUQt3+WykYdvSgmFv/FTxcIRVlhW1KW
	CZoPmV+gyoiNeAiDIbcourPEskEydOfbRZGPlHho5L+m5kKyTTwiwIzyKBUZ+LOC
	ix3qg/NZDYSB0mTi0Lkz2r0Owt0KUBcjU8CnxBXz6Tbn2YjtRTZh/pz1v6iB0BLA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvg4vd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNxXq695613;
	Fri, 18 Sep 2026 15:09:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fexf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9SZE47120786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF2CB20040;
	Fri, 18 Sep 2026 15:09:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79DCE20043;
	Fri, 18 Sep 2026 15:09:27 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:27 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:25 +0200
Subject: [PATCH v7 08/21] KVM: s390: vsie: Create helpers to alloc and free
 vsie_pages
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-8-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2511;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=1d/ElOgjNWOLvso2yHSfNvLdQTtu69dW57Nfq5pIx14=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQxTXnlp7SFKw+D3vof1fj9mpL5K2ipU4/U6+dnpa3
 nfXX+pyHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenANzkS4wMrYbeP7Rebkn9EPxP
 T2pS1RWHQ/9u5dw+rcqom8QwQy1BkpFhsv03C0GRl23ycR1+HN0aTzwsZBkDUpgDHqzbs91lVSg
 jAA==
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXxEehaOEt0uZT
 qDzeHEJHntUOKNjdG7t6HBIwtHHIrRs3RbvJvX2w7zg7FMZK1JuWahrbh9YxOGQcy9hGIYTdpW+
 aFqQsEiiQRyJ+UszQnTboXWI0XiMmt0=
X-Proofpoint-ORIG-GUID: MGUNqh8lQcEtUH8T20JtrpiOSvpiBAGH
X-Proofpoint-GUID: 1ZvxOY3Fp2gkDi5subbJlWukSr3mdzNL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX5V4n+LmrxCFE
 cMHZ9XKoIxtBNT+tVt0fVCNkik3us3oUIKHR4KYKMVVLo6wDPy606gPsbA1QZAZciAkIl00ic/k
 0Ej7GxnpU3FcGqwjyRrZBD7Df4mDiLGA6Q2xU7O+HMy2EEK7/JwKFKq8JbDTtz97TPQp3mdNoPs
 PDaSNsl/siV1f2BkzBp2U1mVQqGUFnFxLKW8MOwZZApCxSxFGalgM+0dLocfHszIw61V84pXn/D
 z+zKLct/F+fvTzKLowP7OdfYWDkdlO7k5lr/DhN15r1tCOmORRwiZG9Sp7Tngqscnura5Tux6ty
 AvNbLWo7ueEXrd1tLyY0fgO0dYEp/sL/UmHDTUnTZo3Tm6U/B6B78Aj28uayv6tsNUwTcbvvx+V
 qB4Al9BAKKtK5oDbIkug6xgssEzViCcNH6BWNYWpeqdMJbT3J91/AbmNsNa/jkI4QKihp0ltgjm
 laL1TFkPDQPBtLxcFiQ==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aad542c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=-UiXzxHpo5ppJV-mmbwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180214

Encapsulate allocation of struct vsie_page and free into its own methods
to allow this from multiple code paths.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/s390/vsie.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index afc2e56fcabf..e7005bade757 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -1502,6 +1502,24 @@ static void put_vsie_page(struct vsie_page *vsie_page)
 	clear_bit(VSIE_PAGE_IN_USE, &vsie_page->flags);
 }
 
+static void free_vsie_page(struct vsie_page *vsie_page)
+{
+	free_page((unsigned long)vsie_page);
+}
+
+static struct vsie_page *alloc_vsie_page(struct kvm *kvm)
+{
+	struct vsie_page *vsie_page;
+
+	vsie_page = (struct vsie_page *)__get_free_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO | GFP_DMA);
+	if (!vsie_page)
+		return vsie_page;
+
+	/* Mark it as invalid until it resides in the tree. */
+	vsie_page->scb_gpa = ULONG_MAX;
+	return vsie_page;
+}
+
 /*
  * Get or create a vsie page for a scb address.
  *
@@ -1537,7 +1555,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 
 	mutex_lock(&kvm->arch.vsie.mutex);
 	if (kvm->arch.vsie.page_count < nr_vcpus) {
-		vsie_page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO | GFP_DMA);
+		vsie_page = alloc_vsie_page(kvm);
 		if (!vsie_page) {
 			mutex_unlock(&kvm->arch.vsie.mutex);
 			return ERR_PTR(-ENOMEM);
@@ -1557,9 +1575,9 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 		if (vsie_page->scb_gpa != ULONG_MAX)
 			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
 					  vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
+		/* Mark it as invalid until it resides in the tree. */
+		vsie_page->scb_gpa = ULONG_MAX;
 	}
-	/* Mark it as invalid until it resides in the tree. */
-	vsie_page->scb_gpa = ULONG_MAX;
 
 	/* Double use of the same address or allocation failure. */
 	if (radix_tree_insert(&kvm->arch.vsie.addr_to_page, addr >> SCB_ALIGNMENT_SHIFT,
@@ -1662,7 +1680,7 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
 		if (vsie_page->scb_gpa != ULONG_MAX)
 			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
 					  vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);
-		free_page((unsigned long)vsie_page);
+		free_vsie_page(vsie_page);
 	}
 	kvm->arch.vsie.page_count = 0;
 	mutex_unlock(&kvm->arch.vsie.mutex);

-- 
2.55.0

