Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C54421258;
	Wed, 22 Jul 2026 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739994; cv=none; b=VrOl+OX7/CJTXxq8JgtVKies1mMtxmMddTXPRdplN6E4/JxHz8t79eQ+tqrswXDoZ1Cnzvt6e/itDnw7EHNfTEp+GkStlA5pgsIjodAxyJmV9KQMbxMdEs506eU0Npa1pr9Hh6nMZBO5k4AuFHnlYLHok8HGxEnW3XBfIWqoVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739994; c=relaxed/simple;
	bh=RwzXk/loI857roFrBPTgONzObOwrW7DdnNgQkrxFiCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZNBa3AURMuTxKFfCc0zfNdrWse9fFoPY9R4+8RvsTIjcIbI9oW6Tr0AwILx3uyDPhlOX2K+B5rWGQVGFEOjccbAodtWivZAxL8nlnIK2GQWoYLTl+kBpN8kuhK53BwvjXmEJYtLcknOXrjby496FCR9Usw581y9bpcj1DxF47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i9G9chGX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i9G9chGX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66MFfmNF382893;
	Wed, 22 Jul 2026 17:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=W5iy9Ye8g++11Uesd
	JYnqIsQr+kMkLzAlBRRbH8zpHI=; b=i9G9chGX65ixtCHIsYvDsj3x2Yhzb2bfK
	JnLh7elrsl1YjlGPekeMgQEpGHuqWfhnJFE9AqtqF8eQOYtfuTLRq8fBpv6FmEbn
	lYvScQreoieB3jfZG0NEgwG2VIlLd6KGOtZGWrTfAo0uULrnVLd2FAaSkS6x7QVr
	j3ph2Lo4n2wj8be+sprf4r2ZobxY01f42rMvzhS2hMfLYfnhr04WMHLKC7KO9VHl
	kXqBiZdBaoeIFAKGQ2u7Tzbp16+vTiyvsNwFTJjIBbCz/Pa3n5mis6IOfLuodJKO
	d/Kf3+xmOvHsFX+RBgMCUq1u7It5Yr9NdPmTG7+cn/UXoadItnsAw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7913cwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:06:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66MH4gro025503;
	Wed, 22 Jul 2026 17:06:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah88wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 17:06:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66MH5slG9765626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 17:05:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5A4D58053;
	Wed, 22 Jul 2026 17:06:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E9EC58043;
	Wed, 22 Jul 2026 17:06:29 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.249])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 17:06:28 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        farman@linux.ibm.com
Subject: [PATCH v4 6/6] KVM: s390: pci: Validate AIBV and AISB before pinning guest pages
Date: Wed, 22 Jul 2026 10:06:21 -0700
Message-ID: <20260722170621.1686-7-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722170621.1686-1-alifm@linux.ibm.com>
References: <20260722170621.1686-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CS8sPQxa_q40Y9uBSKPdq0V4ihrGbMpo
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a60f898 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=i8wI3NWYBEf5A6oN4S0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfX8KAp2HFyCaVe
 CGLCZeTo5mx6tFwcH7CBfPJ2Hp6AfNjG4M6ZuQV9iv3Il2vQIS0+HBG+IC/7xEBdLS+8FY47DxF
 yIS0KjxqDH2n5+ynIcLj3Heja5DGZPg=
X-Proofpoint-GUID: CS8sPQxa_q40Y9uBSKPdq0V4ihrGbMpo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE2NCBTYWx0ZWRfX6CjyNEflAyvx
 gcyevkOFvzWmphadC4x7SQc5Wjsb6cI2wGV+kbdBlnNoGG9M7FNq8aRyliegwqUWjrIpZRqv90u
 AJppQSjmi9D3vz6NWA4TTQ0FG5pzSrJhF37xfQewPc1DrlcI8n7VvFn9nOXg4/ZOIemDkr/eggA
 xJVr8j74Ut3IiZtuhsNCYqtTjUjM0SkRcWg1nDsfcJTRsXfqBarzNXTpOjbOT6EN0bZRsU2l1e/
 KFLkV5EyQdrKmjgFojZV5ISQg/6hRtGom8SZTxSlDJJint5+Z/Rv7S1iRhbA0+xNJes//saP9kG
 2Ttad9HYPDV7JqifxyjqUL/Iee9+fk86QMJVwL801058OtFkHsSYxyNMlqR29qbpv1u7AvUKvD/
 SnAox/ZPyDY2hARKUcALthJLXjzW/PzmXtT5aApM8Mf2gexXoPYKTldE9cQoouxrJ1YKJk8AohK
 Zban/ZcxxzsGe3/L3IQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220164

The AIBV holds one bit per MSI-X vector for a given function. The size of
the bit vector is derived from the NOI and the AIBVO. If the size of the
AIBV exceeds a single page boundary, then reject the request as we cannot
safely pin the guest AIBV.

Similarly reject the request if the AISB address is not 8-byte aligned as
the architecture requires doubleword alignment for the summary bit address.
Since the AISBO can address up to 64 bits, the size of the AISB can only be
8 bytes for the function. This also ensures the AISB doesn't exceed a
single page boundary.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index d76b2c5484ac..e55e75b81b51 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -241,7 +241,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 				   bool assist)
 {
 	struct page *pages[1], *aibv_page, *aisb_page = NULL;
-	unsigned int msi_vecs, idx;
+	unsigned int msi_vecs, idx, size;
 	struct zpci_gaite *gaite;
 	unsigned long hva, bit;
 	struct kvm *kvm;
@@ -268,6 +268,14 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 		return gisc;
 
 	/* Replace AIBV address */
+	size = BITS_TO_LONGS(msi_vecs) * sizeof(unsigned long);
+	size += (fib->fmt0.aibvo / 8) + 1;
+	npages = DIV_ROUND_UP((fib->fmt0.aibv & ~PAGE_MASK) + size, PAGE_SIZE);
+	if (npages > 1) {
+		rc = -EINVAL;
+		goto out;
+	}
+
 	idx = srcu_read_lock(&kvm->srcu);
 	hva = gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aibv));
 	npages = pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, pages);
@@ -283,6 +291,12 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 
 	/* Pin the guest AISB if one was specified */
 	if (fib->fmt0.sum == 1) {
+
+		if (fib->fmt0.aisb & 0x7) {
+			rc = -EINVAL;
+			goto unpin1;
+		}
+
 		idx = srcu_read_lock(&kvm->srcu);
 		hva = gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aisb));
 		npages = pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM,
-- 
2.43.0

