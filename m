Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB144E643;
	Wed, 26 Aug 2026 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756733; cv=none; b=r9hDrLFLG7Fpjl6sn0P+63hZHoQTT5dE7M28enmAhRn2np5ogUy+/ugNZaRrxE6tQ+WTM+YBwb6rLkZ+DcvsBcTTv8e+b+64s/xAdRLO1MZR1V6M2DZ+TG14+pobgIvaz2MYdfyddyMulJT/5lOy66gE5j1r/xiG9lliUryd4nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756733; c=relaxed/simple;
	bh=d78YO1SrT8RgWKwly3hwhmxrt5+27np1l3x5vCEERg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ui/kd4OihYFCqEvELdGXYbGvKjICBnHcEOetqRalroJ7TzRCk0GjBBRAT76L0JL8w4Nv13V8qjQw9kh4SkHHbeSM5FeGpBayelQLYkgMvSoMTbhD5fOdx/XbSRrpd9J/UgVSN6aUhM8V1RXu2ECzRk8h+2pnwhAr8iuiy/uiqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CjrSJr1+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CjrSJr1+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1fq24099702;
	Wed, 26 Aug 2026 15:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pKyu6z
	vyfUv0iFGtxN4v3q10nzAOd06WU+g1omebxsQ=; b=CjrSJr1+xGMCpfCnr6dKqs
	gvCqp9EZi+YFZ+m0u+66F0SsrjZvekeL2q0L0Wc/P+H9mC8dmII5sATlmgbwSzXF
	QkzAxldgU/8ImxRP8zLcpxOefloIWjUp0DwtGXM2mnvc+xd6h8jxjG/SflmGXhbv
	unmdcOjNYapq4ZoV2o295V8gEhRIIFNreG6DM6006lsp6u9gLYGNwIWwcM7HZUJv
	YszA0TJuM0BE/LrSPFD3pLY9pLoRKDjCvH4D+ZifI9VunEXsD1hRAOqgtwhKGqXx
	LmFlNIssUo5C9TLOMzaXme6/7hFPpW2Qhuhxnzxx3cTO8kYMGyL0pLaHFvYMfD6g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hyhkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEuN47000523;
	Wed, 26 Aug 2026 15:05:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyab17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 15:05:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QF5Ki145351404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 15:05:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EC9120040;
	Wed, 26 Aug 2026 15:05:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5B6C2004D;
	Wed, 26 Aug 2026 15:05:19 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 15:05:19 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 26 Aug 2026 17:05:17 +0200
Subject: [PATCH v5 15/21] KVM: s390: vsie: Add struct vsie_sca with pin and
 unpin methods
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-vsie-sigpi-v5-15-cf471edb46b2@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4450;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=d78YO1SrT8RgWKwly3hwhmxrt5+27np1l3x5vCEERg8=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn9DKu9Kz4tUz9vu/i2wTs5NaPYl5WbA//VBjac3vfN7
 Jd86+zlHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzkgyMjw+L7Eu7HWq5MXLSW
 q+8yT4v07OKODFNvc/NDzy4cOSPX28rwV173yprNnPunWJYufWo84W3K41M3J/cEbg9/7PFYOar
 yHj8A
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfX4EmJmQh5GKyt
 mF5Hn8BsjRikZ5C5GPwGDA2FHVMI4s5quSKALuw2nB/BNvU7zZCEV3zdIbH8s9SNvnAJPiueELu
 NHWd5G47LndrD0GaFsc/CyufS+5jeMA=
X-Proofpoint-GUID: Cu50UXOr-yd2A4rY4cMu-LMVUGwH9Srf
X-Proofpoint-ORIG-GUID: 7PqqQ7otfyZddkjiILxC3IQ7kiKxOKbj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyNSBTYWx0ZWRfXwPy9OO+WDv5b
 +m5G+6HNpICoYvh2I8fL5I4Jw10KAbSU64+9GFZZeYVOOPHFdSLnZqEcDGwbWV5WUI96esSywOx
 S01sXZLdGVE/r4IIvd+KuwazVnROIh5hg30At7PRzJ4HMo3JnTz0s8w/5+GOB9yxE7RwUhPHG7q
 kVCzoxZeZPRM74Vo8Ef+LI6VN50PILPDIDuoUTo5Nl1mBAHKocaGaeseeNEZk/YcN0JUrsLPOmj
 QdOonUgV04hhe5EM5BDhiUVeRoJLPgLBrH0S4gCnBNdZNCJCCHEN7l0wWyykc3k9CuWK6pTaA4H
 fUdlVRvIoq3AUCHi2nb7Prt1InM3HiXzsImuyEZpJbC7LiDVndXAQUqXJHh2CCM76aRoRIb+Z8e
 F5c+8RVJ6acclKgpw3DdE0Lt9P+YM+ShUSusXipbNaXhmr17Cd29Se2jsHpsWWs4TBgQfPEaRm1
 RvgJ2Syk28fxx8xu5oQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8f00b5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=F8FVqei25e47uhyEDlAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260125

Introduce the struct vsie_sca to hold the SSCA and required management
data along with alloc and free methods to use with the struct.
On this basis we can also add methods {,un}pin_sca() to simplify the
pinning SCAs in g1.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_s390_types.h |   1 +
 arch/s390/kvm/s390/vsie.c                   | 101 +++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host_s390_types.h b/arch/s390/include/asm/kvm_host_s390_types.h
index 0b69e71bc8ee..1ac31a54d508 100644
--- a/arch/s390/include/asm/kvm_host_s390_types.h
+++ b/arch/s390/include/asm/kvm_host_s390_types.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 
 #define KVM_S390_MAX_VSIE_VCPUS 256
+#define KVM_S390_MAX_SCA_PAGES 5
 
 #define KVM_S390_BSCA_CPU_SLOTS 64
 #define KVM_S390_ESCA_CPU_SLOTS 248
diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
index f7a7170e3112..3c94faa35b44 100644
--- a/arch/s390/kvm/s390/vsie.c
+++ b/arch/s390/kvm/s390/vsie.c
@@ -62,7 +62,8 @@ struct vsie_page {
 	gpa_t scb_gpa;				/* 0x0258 */
 	/* the shadow gmap in use by the vsie_page */
 	struct gmap_cache gmap_cache;		/* 0x0260 */
-	__u8 reserved[0x06f8 - 0x0278];		/* 0x0278 */
+	struct vsie_sca *vsie_sca;		/* 0x0278 */
+	__u8 reserved[0x06f8 - 0x0280];		/* 0x0280 */
 	struct kvm_s390_crypto_cb crycb;	/* 0x06f8 */
 	__u8 fac[8 + S390_ARCH_FAC_LIST_SIZE_BYTE];/* 0x07f8 */
 };
@@ -76,6 +77,36 @@ struct kvm_address_pair {
 	hpa_t hpa;
 };
 
+enum vsie_sca_flags {
+	VSIE_SCA_ESCA = 0,
+	VSIE_SCA_SCA_PINNED = 1,
+};
+
+struct vsie_sca {
+	struct_group(head,
+		struct ssca_block	ssca;
+	);
+	struct_group(keep,
+		struct vsie_page	*pages[KVM_S390_MAX_VSIE_VCPUS];
+		/* The mutex is used to synchronize access to the pages[] */
+		struct mutex		mutex;
+		atomic_t		ref_count;
+	);
+	struct_group(tail,
+		gpa_t			sca_gpa;
+		unsigned long		flags;
+		u64			mcn[4];
+		unsigned int		sca_o_nr_pages;
+		struct kvm_address_pair	sca_o_pages[KVM_S390_MAX_SCA_PAGES];
+	);
+};
+
+/*
+ * SSCA needs to be 32-byte aligned and members before the cpu field need to be on the same page.
+ * Forcing it to offset 0 will always fulfill the requirements.
+ */
+static_assert(!(offsetof(struct vsie_sca, ssca)));
+
 static inline bool sie_uses_esca(struct kvm_s390_sie_block *scb)
 {
 	return (scb->ecb2 & ECB2_ESCA);
@@ -859,6 +890,74 @@ static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
+/*
+ * Unpin g2 original sca in g1 memory.
+ *
+ * Called with vsie_sca_lock held in write, except in the destroy path.
+ */
+static void unpin_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
+{
+	if (!test_bit(VSIE_SCA_SCA_PINNED, &vsie_sca->flags))
+		return;
+
+	unpin_guest_pages(kvm, vsie_sca->sca_o_pages, vsie_sca->sca_o_nr_pages);
+	vsie_sca->sca_o_nr_pages = 0;
+
+	clear_bit(VSIE_SCA_SCA_PINNED, &vsie_sca->flags);
+}
+
+/*
+ * Pin g2 original sca in g1 memory.
+ *
+ * Called with vsie_sca_lock held in write.
+ */
+static int pin_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
+{
+	bool is_esca = test_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
+	gpa_t offset = vsie_sca->sca_gpa & ~PAGE_MASK;
+	int rc, nr_pages;
+
+	if (test_bit(VSIE_SCA_SCA_PINNED, &vsie_sca->flags))
+		return 0;
+
+	if (is_esca) {
+		nr_pages = 4;
+		if (offset + sizeof(struct esca_block) > 4 * PAGE_SIZE)
+			nr_pages = 5;
+	} else {
+		nr_pages = 1;
+		if (offset + sizeof(struct bsca_block) > PAGE_SIZE)
+			nr_pages = 2;
+	}
+
+	rc = pin_guest_pages(kvm, vsie_sca->sca_gpa, nr_pages, vsie_sca->sca_o_pages,
+			     &vsie_sca->sca_o_nr_pages);
+	if (rc)
+		return rc;
+	set_bit(VSIE_SCA_SCA_PINNED, &vsie_sca->flags);
+
+	return 0;
+}
+
+static void free_vsie_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
+{
+	free_pages_exact(vsie_sca, sizeof(*vsie_sca));
+}
+
+static struct vsie_sca *alloc_vsie_sca(void)
+{
+	struct vsie_sca *vsie_sca;
+
+	vsie_sca = alloc_pages_exact(sizeof(*vsie_sca), GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!vsie_sca)
+		return NULL;
+
+	mutex_init(&vsie_sca->mutex);
+	atomic_set(&vsie_sca->ref_count, 0);
+
+	return vsie_sca;
+}
+
 void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, gpa_t start, gpa_t end)
 {
 	struct vsie_page *cur, *next;

-- 
2.55.0

