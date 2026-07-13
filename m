Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68368346FA7;
	Mon, 13 Jul 2026 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963580; cv=none; b=h2kG5dxFCI+5BLqeq1TBfoyFZrNRb+Rok8Z/Z9M9EcgfozsrGxOQrpD/CWxvi0BFKBvv/9Eolzi8qhiUlJwa5NslvFxqDkUFfMTl83sshvclCftXVncwL3HV1C0lDS2VbKCQivVPx2TLY5pm/zuD/X/0CmCJJKYacx0jR6BoTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963580; c=relaxed/simple;
	bh=nVgeEDe627f6cggLKPkI1ALB+FbPLILphH4xvUQKmbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViUC6HEHsbtnemZBf3N3P3QOrkTid+vWnOt7DponGRov1yAaK+3EGQ/Rhuwnc+GohuhLDU1sECXpfj3rVAWAEWk+Helwk7GsRbncipaRUolbaWxSdRPGn0VvVZehBQjKaG5Hn7mnVfyjMWAZptygfX5b7Gca/ZYjD1/wU0Myx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ib/sxBdM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ib/sxBdM"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFEQ022833006;
	Mon, 13 Jul 2026 17:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qAcgkNewLpdxXeGjL
	nt8JjFj97yq/1EZHAmBCwn086k=; b=Ib/sxBdMctu5cTh7qMPQH72y+/mvz803E
	MHfPR2Qnq2EWycDkYCR8s38C+vf7qIuc4G4Pd3qfyr+ojeAjhXYVyWIpdP/iQspi
	++s8/bJKE2VUqkNaZyH50iwH2jVhOeSUHsGGNcesdibJjaQUzojMDIq1q4HCE1Ov
	fPEeAhZLAheOgKy7ar10cGN52fLypQAFBBfyWoS855OT5RI8v+mmnhqJiS4LuFNa
	veJ0Km034payWWGeQv2NntDN76YEZN3reYhjwORYXNAANNSmpTG4/N6+Tm3549Vt
	t8tEx1wwWmsmAGp4u9VM7zoKbDmTyQJvnS4d+dqmqkyJAdr0HdiAA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbhmk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 17:26:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DHJcNi016539;
	Mon, 13 Jul 2026 17:26:06 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxxhtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 17:26:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DHQ5HC11076176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 17:26:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7221C58051;
	Mon, 13 Jul 2026 17:26:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EACF25805A;
	Mon, 13 Jul 2026 17:26:04 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.249.24])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 17:26:04 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com
Subject: [PATCH v1 5/5] KVM: s390: pci: Fix AIBV and AISB spanning multiple pages
Date: Mon, 13 Jul 2026 10:26:00 -0700
Message-ID: <20260713172600.1284-6-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713172600.1284-1-alifm@linux.ibm.com>
References: <20260713172600.1284-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a551faf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=iuJ1MhL1WkBYaHGgpXwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE3OCBTYWx0ZWRfX0q6kERTCv5ri
 pyhWhCRhqYCt1MO0OzvCms0qDN1Ie35WTq0KTeBfyreU4Q4cqL601yUrD9By6R7FgYkyK1xCsjn
 nVDSZ8TSkP4SDedhrUsgRvTI2wuqrccWsJQp4WzHrLJwAJTIrOeSJF9zb+wD96zexWbl6ID6VgD
 bACSTpLU8xgz/UstepyJKSAJWxmFXIR0prmW9kPzCKU4W6XK1lV59ptY6AVrCX8HPrQIT1XdACx
 M2QGTch0fe10TrtrCCQhQN5Z1orbewq3fLoWOd0QdIViTSCxmSAAcyvKh9I8R/wNvAqaLBPKsvS
 fwJjScNxWVPuxbTPAHruWDgPD0kfCpOUceGFJB+i2nv3KX2t4mH0p1HF4PjR4xgDHCF9zOxmWKG
 fTa9WZy8R/uMfvfofoDY6brrORuYm7pc2gWsBgaPB2wn5RAklQwU3EEd6IcDKJYtbHrNzyt0Ggj
 /qcNvFxpUF443dnHI2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE3OCBTYWx0ZWRfXwqLjQucuJ9Vz
 JQz4n/qSNUhvrFKK+zBHEH+kG69j4X5KoVnUd/E1dPzg02lW5EFpA4Hskyi/NxnyPzJ6JN+5Mh0
 qtlGG84aDNdTIVQx2I1L7K9sxXgzlKc=
X-Proofpoint-GUID: yLD9RvtyBrRsJNFjLQT2wWNljh26CoiS
X-Proofpoint-ORIG-GUID: yLD9RvtyBrRsJNFjLQT2wWNljh26CoiS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130178

The AIBV (adapter interrupt bit vector) holds one bit per MSI-X vector for
a given function. With a maximum of 2048 MSI-X vectors per function, the
AIBV can be up to 256 bytes. Because a guest is free to place the AIBV at
any alignment, it may cross a page boundary. Pin all pages covered by the
AIBV to handle this correctly.

The AISB (adapter interrupt summary bit) holds one bit per zPCI function.
Its total size is configuration-dependent and not architecturally bounded,
so the AISB offset is used to detect whether it crosses a page boundary
and pin accordingly.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 78 ++++++++++++++++++++++++++++++++++-----------
 arch/s390/kvm/pci.h |  5 +++
 2 files changed, 64 insertions(+), 19 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 9a16a2eac65b..5fe07181f3d6 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -229,13 +229,15 @@ static inline int account_mem(unsigned long nr_pages)
 static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 				   bool assist)
 {
-	struct page *pages[1], *aibv_page, *aisb_page = NULL;
-	unsigned int msi_vecs, idx;
+	struct page *aibv_page, *aisb_page = NULL;
+	int gisc, npages, npinned, pcount = 0;
+	unsigned int msi_vecs, idx, size;
 	struct zpci_gaite *gaite;
 	unsigned long hva, bit;
+	struct kvm_zdev *kzdev;
 	struct kvm *kvm;
 	phys_addr_t gaddr;
-	int rc = 0, gisc, npages, pcount = 0;
+	int rc = 0;
 
 	/*
 	 * Interrupt forwarding is only applicable if the device is already
@@ -244,6 +246,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	if (zdev->gisa == 0)
 		return -EINVAL;
 
+	kzdev = zdev->kzdev;
 	kvm = zdev->kzdev->kvm;
 	msi_vecs = min_t(unsigned int, fib->fmt0.noi, zdev->max_msi);
 
@@ -253,32 +256,63 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 		return gisc;
 
 	/* Replace AIBV address */
+	size = BITS_TO_LONGS(msi_vecs) * sizeof(unsigned long);
+	npages = DIV_ROUND_UP((fib->fmt0.aibv & ~PAGE_MASK) + size, PAGE_SIZE);
+	if (npages > MAX_AIF_PAGES) {
+		rc = -EINVAL;
+		goto out;
+	}
+
 	idx = srcu_read_lock(&kvm->srcu);
 	hva = gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aibv));
-	npages = pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, pages);
+	npinned = pin_user_pages_fast(hva, npages, FOLL_WRITE | FOLL_LONGTERM,
+				      kzdev->aibv_pages);
 	srcu_read_unlock(&kvm->srcu, idx);
-	if (npages < 1) {
+	if (npinned <= 0) {
 		rc = -EIO;
 		goto out;
 	}
-	aibv_page = pages[0];
-	pcount++;
+
+	kzdev->aibv_npages = npinned;
+	if (npinned < npages) {
+		rc = -EIO;
+		goto unpin1;
+	}
+
+	pcount += npinned;
+	aibv_page = kzdev->aibv_pages[0];
 	gaddr = page_to_phys(aibv_page) + (fib->fmt0.aibv & ~PAGE_MASK);
 	fib->fmt0.aibv = gaddr;
 
 	/* Pin the guest AISB if one was specified */
 	if (fib->fmt0.sum == 1) {
+		size = (fib->fmt0.aisbo / 8) + 1;
+		npages = DIV_ROUND_UP((fib->fmt0.aisb & ~PAGE_MASK) + size,
+				      PAGE_SIZE);
+
+		if (npages > MAX_AIF_PAGES) {
+			rc = -EINVAL;
+			goto unpin1;
+		}
+
 		idx = srcu_read_lock(&kvm->srcu);
 		hva = gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aisb));
-		npages = pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM,
-					     pages);
+		npinned = pin_user_pages_fast(hva, npages,
+					     FOLL_WRITE | FOLL_LONGTERM,
+					     kzdev->aisb_pages);
 		srcu_read_unlock(&kvm->srcu, idx);
-		if (npages < 1) {
+		if (npinned <= 0) {
 			rc = -EIO;
 			goto unpin1;
 		}
-		aisb_page = pages[0];
-		pcount++;
+
+		kzdev->aisb_npages = npinned;
+		if (npinned < npages) {
+			rc = -EIO;
+			goto unpin2;
+		}
+		aisb_page = kzdev->aisb_pages[0];
+		pcount += npinned;
 	}
 
 	/* Account for pinned pages, roll back on failure */
@@ -366,10 +400,14 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 		unaccount_mem(pcount);
 	mutex_unlock(&aift->aift_lock);
 unpin2:
-	if (fib->fmt0.sum == 1)
-		unpin_user_page(aisb_page);
+	if (fib->fmt0.sum == 1) {
+		unpin_user_pages(kzdev->aisb_pages,
+				 kzdev->aisb_npages);
+		kzdev->aisb_npages = 0;
+	}
 unpin1:
-	unpin_user_page(aibv_page);
+	unpin_user_pages(kzdev->aibv_pages, kzdev->aibv_npages);
+	kzdev->aibv_npages = 0;
 out:
 	kvm_s390_gisc_unregister(kvm, fib->fmt0.isc);
 	return rc;
@@ -426,12 +464,14 @@ static int kvm_s390_pci_aif_disable(struct zpci_dev *zdev, bool force)
 	kzdev->fib.fmt0.aibv = 0;
 
 	if (vpage) {
-		unpin_user_page(vpage);
-		pcount++;
+		unpin_user_pages(kzdev->aibv_pages, kzdev->aibv_npages);
+		pcount += kzdev->aibv_npages;
+		kzdev->aibv_npages = 0;
 	}
 	if (spage) {
-		unpin_user_page(spage);
-		pcount++;
+		unpin_user_pages(kzdev->aisb_pages, kzdev->aisb_npages);
+		pcount += kzdev->aisb_npages;
+		kzdev->aisb_npages = 0;
 	}
 	if (pcount > 0)
 		unaccount_mem(pcount);
diff --git a/arch/s390/kvm/pci.h b/arch/s390/kvm/pci.h
index ff0972dd5e71..a2d550f06b6c 100644
--- a/arch/s390/kvm/pci.h
+++ b/arch/s390/kvm/pci.h
@@ -17,10 +17,15 @@
 #include <asm/airq.h>
 #include <asm/cpu.h>
 
+#define MAX_AIF_PAGES 2
 struct kvm_zdev {
 	struct zpci_dev *zdev;
 	struct kvm *kvm;
 	struct zpci_fib fib;
+	struct page *aibv_pages[MAX_AIF_PAGES];
+	int aibv_npages;
+	struct page *aisb_pages[MAX_AIF_PAGES];
+	int aisb_npages;
 	struct list_head entry;
 };
 
-- 
2.43.0

