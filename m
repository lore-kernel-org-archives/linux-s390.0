Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D6933859A;
	Mon, 10 Aug 2026 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377272; cv=none; b=PdsH0au+UxmOUKcfL75f1IbydI6zirMDSJaG+Spu+2JstRnjaXcy4TVdiks0LmQNWGTvqcTbXzxBd4cxdgqbpsOAodVBYOzTFNbDJPkOyaOYGk+yTaY8Nd+lPVYJM6f8ZSj5dhu9cfCMWeH98mfJC1ZtW+L+lHOT2W2cNd7saMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377272; c=relaxed/simple;
	bh=eOsmPna9+ADsFikWgI5X+yaAnXPw2tvdhhEXAPwvae8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iFkzODVc8SH24cNRgQhzQ4W8WkevKE7ZMABajR571eQa0DXSS0GoPpqAKw+59NuKGoc3mYELLfffp1+kaf4GpOuaJXaQiQnUclB2VX98Y5Z2CmOykXX3tBzaHgEryB/8NKZgYtC4cIvmVvfzkgMWjEp44DXvpVHh0dHxs7xPL7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O8Fu0Bsz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O8Fu0Bsz"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AFWQsa163685;
	Mon, 10 Aug 2026 15:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UT8DH3
	IBq9zJdfsr60XQz1jVCGWbppXj6s+D9mciduo=; b=O8Fu0BszhMxlUpGkq2Pkkr
	T9w6H4iO3tGS1UnoOXXKb2sfAcRA75iVCtkO/1Ocd7ZPOtWuRT+cnbnbT8reyO5V
	27Yth4vn76iMoabQc9kHodqGgsOzPkT4XJGSaXxEqu6Avlo020ibkdoHQW9hCqMJ
	lxh/CqrLAGleO7vTIPSfDCzxJC2AtnNtuedj/GLx9dsNyNwsVC9gdilRWsiSCNDs
	V6BKk+4hiXKn10SvM0DUPA/CxmBCzcY8rPbDHur3ylCaR/LWyAl1dzzh8/ATN7gu
	WG5x4Y58B68qlk1uGX098Xbk8Kp81dScFJDrCZLsO+mgdA+Ej+e/DV7siWJ9xQug
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyrtjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AFgW2B003777;
	Mon, 10 Aug 2026 15:54:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjne3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 15:54:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AFsKmB52756962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 15:54:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98B4220049;
	Mon, 10 Aug 2026 15:54:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05FAB2004D;
	Mon, 10 Aug 2026 15:54:20 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.41.151])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 15:54:19 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 10 Aug 2026 17:54:00 +0200
Subject: [PATCH v2 12/20] KVM: s390: vsie: Add helper to pin and unpin
 multiple guest pages
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-vsie-sigpi-v2-12-e8d59a2f2f70@linux.ibm.com>
References: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
In-Reply-To: <20260810-vsie-sigpi-v2-0-e8d59a2f2f70@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=eOsmPna9+ADsFikWgI5X+yaAnXPw2tvdhhEXAPwvae8=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFmVX5QOPTLd/CuCO1Px91HVRZvPPZWqsivIWOki5N/F9
 eKPw/EDHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzk8mtGhqkChWlL5zFHS3Jr
 i+31f7RVM4uH4cfnY/funJ2WJCiktYvhf9b8TbGnpfdZxP05/SfmobLQ5hkh07faVx0Ob1m5OO2
 sDxMA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfXwMOUbDgTqe7E
 aMgQZoRW4pT7T6tpw3LXtc4awqG1ckRFJatSkdEjvXPju8Xv34ppSA1zByoXDW7PPOqxEpJtTvl
 4u6SE2nJgoWG+wyIbi7iQ+XMHqpCGy1go/vvPaEPXOYYOO9Psx5EVFvsGTVz7bCzsX8Y+LRnig+
 e9Ta3mQ5EH5MjlWqoHNjget2xT5Xld0AIe1Hv8BkIw11JxSUr/dvnb61dMFa1SVD4KqnnoI47mr
 YM402NSF2CKpotjdnsLAYJ96xWNNA3n5ARrgwTHAYvpJRE7mX37RSI1gu524AQrybgeEX+tVdO5
 RhNiMKK+2NFYtYcPmdDCPndKfSz98QwX8SWymp/WnHCRTlJkBjsOuVZXAY4vvSZ+Lnfxlhkf3ap
 f2LwoEiJYj52pZWR6MNjYzkwoneorwACv5A2LFzj4Mp09+x6DFZaZcqEXXK5X/C3PDLiOfAgtEM
 ZX2sIgAQHk/XREE9elQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzNCBTYWx0ZWRfX650zwfDxwBRE
 RLHkSTvRsi/iXOlGI2BF4Mwwzcrq98ZF8oUXFNcEdgK/KgzcGcGYejo6HZyjm91K+UQPfMfAmPG
 r3NQvsq/QflQK0XmjhagNwqBupVBFpQ=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a79f431 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=b1Ck5HAT0Q-BmxMTSzUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ej0z_i-kRoYkx6PCNkZKdyS2tNRY9I5D
X-Proofpoint-ORIG-GUID: Ej0z_i-kRoYkx6PCNkZKdyS2tNRY9I5D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100134

To handle vSIE configurations with an ssca we need to pin and unpin
multiple consecutive guest-2 pages in guest-1. As these might not be
consecutive in guest-1 it is necessary to iterate over all pages and
store guest and host addresses for later use.

Since the new methods use the existing {,un}pin_guest_page() helpers,
they are moved up unchanged in the file to avoid having to resort to
forward declarations later on.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 4f4d35e0c8c1..0bbb65300a85 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -71,6 +71,11 @@ static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
 static_assert(offsetof(struct vsie_page, mcck_info) == offsetof(struct sie_page, mcck_info));
 static_assert(IS_ALIGNED(offsetof(struct vsie_page, crycb), 8));
 
+struct kvm_address_pair {
+	gpa_t gpa;
+	hpa_t hpa;
+};
+
 static inline bool sie_uses_esca(struct kvm_s390_sie_block *scb)
 {
 	return (scb->ecb2 & ECB2_ESCA);
@@ -249,6 +254,46 @@ static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
 	mark_page_dirty(kvm, gpa_to_gfn(gpa));
 }
 
+/* unpin multiple guest pages pinned with pin_guest_pages() */
+static void unpin_guest_pages(struct kvm *kvm, struct kvm_address_pair *addr, unsigned int nr_pages)
+{
+	int i;
+
+	for (i = 0; i < nr_pages; i++) {
+		unpin_guest_page(kvm, addr[i].gpa, addr[i].hpa);
+		addr[i].gpa = 0;
+		addr[i].hpa = 0;
+	}
+}
+
+/*
+ * pin nr_pages consecutive guest pages
+ *
+ * Returns number of pages pinned or -EFAULT.
+ */
+static int pin_guest_pages(struct kvm *kvm, gpa_t gpa, unsigned int nr_pages,
+			   struct kvm_address_pair *addr)
+{
+	hpa_t hpa;
+	int i, rc;
+
+	gpa = gpa & PAGE_MASK;
+
+	/* the guest pages may not be mapped continuously, so pin each page */
+	for (i = 0; i < nr_pages; i++) {
+		rc = pin_guest_page(kvm, gpa + PAGE_SIZE * i, &hpa);
+		if (rc)
+			goto err;
+		addr[i].gpa = gpa + PAGE_SIZE * i;
+		addr[i].hpa = hpa;
+	}
+	return i;
+
+err:
+	unpin_guest_pages(kvm, addr, i);
+	return -EFAULT;
+}
+
 /* copy the updated intervention request bits into the shadow scb */
 static void update_intervention_requests(struct vsie_page *vsie_page)
 {

-- 
2.55.0

