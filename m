Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E6344C646;
	Wed, 26 Aug 2026 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756731; cv=none; b=DmNpLTnqyDcUOB9URoSppfKyCeHWstObThMQqNYd5cOdkj3zLPwo4wlJ7+5On61t+hELYtCxLwwTvO4lK13C3dKwdqj1GCFkBccIGN1nQJvPGrdUcQFw+XRzZUzfjYGXcxWmttFwG/S56T2vkGErw88dBYK5mmRKEW/BQ/nABnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756731; c=relaxed/simple;
	bh=1d/ElOgjNWOLvso2yHSfNvLdQTtu69dW57Nfq5pIx14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+DL6ZSmIty00NmBDEr8mGtx6+SGkwecZf4DE/tW/EikmD+49axkyfnpyDtIC9t5wjkfWmbxnf8QhjyYOFqVidchWT5MBPnY0oSk16+DJXEPVrm3c01vStRRai+WVKotkVfBS6S2fM3IxP+EAk+tK1mkzsy9QvuOiQnwMGLqeC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RQHHe0eV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RQHHe0eV"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1el3070425;
	Wed, 26 Aug 2026 15:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XI8aiu
	VtwtLBDksj07nEbzOSbLHJGk8g4GudQzZ7BbQ=; b=RQHHe0eVcHsexnGfrEkhwC
	TFytGNivrYXDwVMoxLSHEogmjBzbJhHlHXYdJv58N5wsOF6QLi7VBZrmb3e3R2Z0
	ctYKC/50vKJxiBoUBTHmGGvEOKUdPwgyhqG5mjfjUGpjoTxpyv0aZ48KmKKA3dY4
	RVpSpG9zMosIoiXBuu/5Oq5/jhaJUTRXuASCSz+nAgV/E7jU7HuMuiRfkqgjnr6J
	JaNEAd8Rg3uovkgBfmX/XJzHTtqHPcEesc54QEYMPdOxWqUwY2bh64KoQecSoSYd
	FpaPI1HWAHiMz9YiM08cO1SYyjE3txvsnwBz5nW8l3xSiPtF4w+HhD4t31NWQXPw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxf4f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuH1D015586;
	Wed, 26 Aug 2026 15:05:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhagwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5IRS45089072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 902D62004D;
	Wed, 26 Aug 2026 15:05:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EC8820040;
	Wed, 26 Aug 2026 15:05:18 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:18 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:10 +0200
Subject: [PATCH v5 08/21] KVM: s390: vsie: Create helpers to alloc and free
 vsie_pages
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-8-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
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
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DKvf+4l/6DS5nFhSLLy0oyL+oVvoGfttd52kJxukC
 19Y4lPbUcrCIMbFICumyFItbp1X1de6dM5By2swc1iZQIYwcHEKwETibjAyXPPaVRkn8zLV9ozC
 3ELprJttri9eGs2bf07+9XaF6+pP8xn+18w5//D6E7GDrGvd2C/Xn4xxL2G+trLwgsFK98aVRja
 3OQA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfXxBGuiyektNpY
 7hngAAWmpr2hyyIM25e6L5C1WQIg3RGG9d8CydASrQCA34iaIW30a49dPHqCd3iDKMelDIKiviG
 vKiGrgFK6QksZVyilZriTwiEU3qxi2o=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8f00b3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=-UiXzxHpo5ppJV-mmbwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: aL6U8vU6Mg4dAcN3U_VYzc87yIo6eQMj
X-Proofpoint-GUID: 433Ref2DlmBlbwDn7FJSpo7SKX3xOzEV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX4kM+1KF7JOS2
 TSLT9Me5G56wjIoWdax4AdKrBPSp7DXk44huRLN/m3g/VUaxw6XyPM+cTnqAIJvIRzCQGC3h2cb
 2e1a9Awkc+nBoLhQ9FHT/UgquomECAxNCKXV9F6ILhHQjmCsXzslilaSEerZNyXKcvzelqPTPMN
 nVEByWPsMP1Kdz5cffoCeY1XXLVbxSii9e8aqnSfOeini61PlID0k42ezL+GEU+GztaSlZvPfbn
 AdOJ33+9KnsNDHaVwygVg0tmP7d66pk6XDLeARJK7RAIsek8B1mETabmO7WDX6Y2QZm3/F0lmp+
 8qgtwS3HhASu13844/6Or3Tp5dAwBtk7n8CIDjxkk069vzrjvONeAGubT5jq5YPDHOJc3ICDYEo
 Tcaf74cjLDUEgoAgET7dQcILMp37QXZK+ezox/igyvzkik2Qw+OIq284sTvZbUQY+NBlJ87geVz
 8jYBs02erv9RhvBsKgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260125

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

