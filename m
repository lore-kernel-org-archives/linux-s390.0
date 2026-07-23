Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4640680F;
	Thu, 23 Jul 2026 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784844859; cv=none; b=A6Dd+NWZXtRCpM4EFnGeuX9G0ejFGL89QdXd/KAXZeKHaDe4VlLEi/Lh47qtw1KpOCeEoK0p0jBZqLZespVzEGmuQJUTSsrgwUEdp6ujWW8cp3+2U56AaPxCXSxc3T9wp3HfujRfLc+Uax6DObVj9q6P7nOqrcBx17WrrrSqlIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784844859; c=relaxed/simple;
	bh=MacpDKDFJI5J2Im3qcTckDBzBDVwUziMXK28jgxdLOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVLU6Mrn0y2Ajnh7+CUhSC86EH3I2LJueT/vG/w5lu5Xf1UjYA/NvPGiO0jLkL4JbamQfaDNMDnWw8u0M5YPBZhKsq+4c55f2ZM/ZgD6ZvRlp+GrrbfjFvQpYJYuv9QYrdPH6ndXU3tLb9k7YRf6IO++SkVFCANB1qBCGkaCXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IjJ37WaG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IjJ37WaG"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NLfsSG4107491;
	Thu, 23 Jul 2026 22:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rL1hyFJMkJ8v+rgOi
	ipi7u8d2nKbJu/alwGibKzNOiI=; b=IjJ37WaGKMATUq994onJWn7GNhQuI0UAO
	d4BlxdriZktLjf4hbKx7Tp8c6+3b2U1PZwLbQveXH9oFHu+5q/z6V7IbTt044GhD
	sfransM+e0r9KaE7Ir8MdU06fHAKhsiDTMJ8Wj8heWsWCgQRn7MAXa/pxmAL4f3f
	JCJFfGpXsaj7T6MyRtttFVat1zRhxpa+pfLBpDy7AaB9npRgnXEhiyd6kaACVT93
	yD2duUjsfFKSjK0Md/9Jn1oM9y9Js5Q7PVmQx3RbJl89/6VXHR4mUr266opaJstO
	Y0mZ+i7M/kJLbiVM3/R+OSNwgAK+3HGduQUrHtq5HCdUlI+/gyMVw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kh9y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 22:14:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NM4aIk024339;
	Thu, 23 Jul 2026 22:14:15 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahe89u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 22:14:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NMEE0R64684506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 22:14:14 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6045158052;
	Thu, 23 Jul 2026 22:14:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D320B5805E;
	Thu, 23 Jul 2026 22:14:13 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.245])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 22:14:13 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v6 6/6] KVM: s390: pci: Validate AIBV and AISB before pinning guest pages
Date: Thu, 23 Jul 2026 15:14:09 -0700
Message-ID: <20260723221409.5874-7-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723221409.5874-1-alifm@linux.ibm.com>
References: <20260723221409.5874-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a629238 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=i8wI3NWYBEf5A6oN4S0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIxNSBTYWx0ZWRfXxAsQrQjmwiCL
 Iu8DJA3Tt2VGfoeiClFgfCmzZdN6yK0T0A7OgL0/kjJ3Kit9F3UDFz+8pJhnhWLEoca11Gt0nHE
 89NBz67g44ko2srTtIBR/ql14xOfyYPfxtPEc3PWVJb2jXU1kkPHDRNDPlh5jeGsTL6Sy5dvp2C
 TKBT3oWFWNUOyaDrNH/vMBitPJKVcRw0SAoitNIWIaj2JrVqAPa+icN/LDphKx6/s4drhS1AH69
 bLOclxIYEixvi/IsGnptFx8unqRE1bwgPYvTpzp2XK29x3udFtDRXIBg3JHoZlpcHSvw5yP49rq
 Wi0712Ws2x6BjCv+kwst61eSG+9M/ZafPigNmnqPPoKu2/yeMtiS9TT0BnsGSPKYkO76+X9M5Cb
 hIB5AA/41nVUrDQKxA+zU0DsNiUDPzpGhp8LbKkkw56NHTotUBCaTM+7iuaRxn2zypB1e7p0U6L
 /Se+nG6D7OHYWrTF/JQ==
X-Proofpoint-ORIG-GUID: lM1A98UMDCHSDulx3Ev08KneVs_zjml0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIxNSBTYWx0ZWRfX9mnSkeeuc4xT
 eJNdGKCO4huYJ7rWsIu4TeytnBn6yUYvoJX0Ux1KYRlEECPHLZwtu9XbCHmL48few3Xh3eET2xZ
 /G4WkgnoG4jQkRtN57x9gTt+gXIkuJc=
X-Proofpoint-GUID: lM1A98UMDCHSDulx3Ev08KneVs_zjml0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230215

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
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index ca8ef76bcf6b..4394cefef242 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -244,7 +244,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 				   bool assist)
 {
 	struct page *pages[1], *aibv_page, *aisb_page = NULL;
-	unsigned int msi_vecs, idx;
+	unsigned int msi_vecs, idx, size;
 	struct zpci_gaite *gaite;
 	unsigned long hva, bit;
 	struct kvm *kvm;
@@ -271,6 +271,14 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 		return gisc;
 
 	/* Replace AIBV address */
+	size = BITS_TO_LONGS(msi_vecs + fib->fmt0.aibvo) * sizeof(unsigned long);
+	npages = DIV_ROUND_UP((fib->fmt0.aibv & ~PAGE_MASK) + size, PAGE_SIZE);
+	/* AIBV cannot span more than 1 page */
+	if (npages > 1) {
+		rc = -EINVAL;
+		goto out;
+	}
+
 	idx = srcu_read_lock(&kvm->srcu);
 	hva = gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aibv));
 	npages = pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, pages);
@@ -286,6 +294,12 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 
 	/* Pin the guest AISB if one was specified */
 	if (fib->fmt0.sum == 1) {
+		/* AISB must be dword aligned */
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

