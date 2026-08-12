Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87145DF4F;
	Wed, 12 Aug 2026 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542775; cv=none; b=G5x5c91tPgmwLFFrKcPdUwTQOjPIa3df9ygt4NqmiYtRM6PpZ/L/yxWK4oLLJ3mvlDtJoVKWMxifbTF/sJAYLf2FKCg7ZruELANdYHmSnfxG/cQSJaYj4UxAEOQxMZdn4flJK5061bnZsTulzPDHM4CaHmwdCcWcLGeAVtp1Qk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542775; c=relaxed/simple;
	bh=ElvJzFLE8QInzZf9DyECDjE45SL/wZkAqKd11FGS6b4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qlPeuSgYXddvOSjkmRiW1rj0rAm85rsxepR/ibbeZsOKOvjkUT+PoaYYJ7sqaxwc1uALsesElY/HiWowhmR9TAr+aYQZrEFw5JmOmNnXGcrqe4cgihUGwfj7+d+zp/Rb6l1eLSwN6qANN1AoJxfdcRG7dCdnWtmkc+jikkFu+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cfz8qsIU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cfz8qsIU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB43HH1434917;
	Wed, 12 Aug 2026 13:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JJQFlg
	+ABdM/rAwXvifDcU5fK0qRUTZjYwi6gKk3W9s=; b=cfz8qsIUH3Kg1iHXaxL7v8
	XK0ijw/cfa5zWP6jllPEYbb9L7JOH+CsngtVrFc/ujC3cr/geIB7HumjAhruyeRt
	Jstm6iYWjdoJG8a5H4P8bl1AYPUr79vOL2aPEsT2MF2J6vweg8eqiJ59PLSabKRt
	SnF24uuoRRAwG/KYVRa12PCt58l0jkTxbRfjKSNRG7GHrhy+FAJlex2Z7o4qm8MF
	oYJya5n2sMOA3mdxm/ktqGNxFYbsrLymd+q/L5ByXBpNqu4SwrID3OGjJqyK33Wk
	Ja2lvRE7KrlMgrbg4gI/B0XduV2V4ZpKRd0+rHjQIrooacnIhFr4b0Y1GKbg+Nww
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk02q0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CDfdFJ022779;
	Wed, 12 Aug 2026 13:52:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjx8dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:52:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CDqd0D34406730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 13:52:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ADE120040;
	Wed, 12 Aug 2026 13:52:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D3872004D;
	Wed, 12 Aug 2026 13:52:39 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 13:52:39 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 12 Aug 2026 15:52:42 +0200
Subject: [PATCH v4 13/20] KVM: s390: vsie: Add struct vsie_sca with pin and
 unpin methods
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-vsie-sigpi-v4-13-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4379;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=ElvJzFLE8QInzZf9DyECDjE45SL/wZkAqKd11FGS6b4=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFk1VYsDtk33vLBfV7Hx14L36XyztyyeJb1p2brHQk2uz
 QZbwpMnd5SyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjARyR+MDJ99D5zlk+9e7GVz
 j5cle17n98s5sXPdnKT8Dv/w5q9PPM/wv06BW4VXqOit/MwT/qJzWl7M0HBr37Xzl2mxwL+Dm+q
 6WQA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX+tWiX7a5a95O
 CgY6uXl/1MB1KkPeWqq1ngOMA4fdDFCvgvM5yFMvd6D4LfXVyF51JxyEtpgjLI0iLLx2VNxYC7J
 4GEBia8PnFbGXnI8JO402J1bvmNjYbdWzUqvYkljOnuGR/HHNBXZQpvQqipZBobBnC1of0gAv6z
 Z+8FxgAEuP1mCNUKfxGish7vAyYffm/VVsXWl/ht+FaSIoXiveOJ0OsCyWybte00zuR8x7NkH0R
 CBLs8oKVgCFFrLoVBTHCL0FM2PlyIjm0dDwFNcHtNXUYUjvwr4KFrG+SzwguOjbz3BdK/4v2fdj
 Jw4lqvOr/A0jL2Zm3Tx9BDa8w7kD2wjJcBVqvR2ld6f85pHMpgryGUBCt/eECpOB6ZvMU8oHOqk
 Hp3QhjmG2DHykedROzeMQvc7lnClxDSR7+VhQ9+b3ZHw5dDnbyf0nYAB4d1cDWpYqYUu2iw4xlg
 QoGDI3e9kko1tUEstvw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDExMCBTYWx0ZWRfX6DLBbCDLx3Tt
 /U47DoOWwH/PrdcTsMdbWZQY2eldYmfEU+MBQiCUwXwcGPNeEURD4tsllNQsx5NbIZzCobK+bix
 kH5DJTK0MnMpxuajUDErq5YXC29RI0M=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c7aac cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=F8FVqei25e47uhyEDlAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XNurLGSQ7kMl4l0nKcm-OwTqdqNqxYqR
X-Proofpoint-ORIG-GUID: XNurLGSQ7kMl4l0nKcm-OwTqdqNqxYqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120110

Introduce the struct vsie_sca to hold the SSCA and required management
data along with alloc and free methods to use with the struct.
On this basis we can also add methods {,un}pin_sca() to simplify the
pinning SCAs in g1.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_types.h |  1 +
 arch/s390/kvm/vsie.c                   | 97 +++++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host_types.h b/arch/s390/include/asm/kvm_host_types.h
index 6540146b4b00..d6025b34a66d 100644
--- a/arch/s390/include/asm/kvm_host_types.h
+++ b/arch/s390/include/asm/kvm_host_types.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 
 #define KVM_S390_MAX_VSIE_VCPUS 256
+#define KVM_S390_MAX_SCA_PAGES 5
 
 #define KVM_S390_BSCA_CPU_SLOTS 64
 #define KVM_S390_ESCA_CPU_SLOTS 248
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 442e7997ee51..e63231122200 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -65,7 +65,8 @@ struct vsie_page {
 	gpa_t scb_gpa;				/* 0x0258 */
 	/* the shadow gmap in use by the vsie_page */
 	struct gmap_cache gmap_cache;		/* 0x0260 */
-	__u8 reserved[0x06f8 - 0x0278];		/* 0x0278 */
+	struct vsie_sca *vsie_sca;		/* 0x0278 */
+	__u8 reserved[0x06f8 - 0x0280];		/* 0x0280 */
 	struct kvm_s390_crypto_cb crycb;	/* 0x06f8 */
 	__u8 fac[8 + S390_ARCH_FAC_LIST_SIZE_BYTE];/* 0x07f8 */
 };
@@ -77,6 +78,32 @@ struct kvm_address_pair {
 	hpa_t hpa;
 };
 
+enum vsie_sca_flags {
+	VSIE_SCA_ESCA = 0,
+	VSIE_SCA_SCA_PINNED = 1,
+};
+
+struct vsie_sca {
+	struct ssca_block	ssca;
+	struct {} start_no_clear_fields;
+	struct vsie_page	*pages[KVM_S390_MAX_VSIE_VCPUS];
+	/* The mutex is used to synchronize access to the pages[] */
+	struct mutex		mutex;
+	atomic_t		ref_count;
+	struct {} end_no_clear_fields;
+	gpa_t			sca_gpa;
+	unsigned long		flags;
+	u64			mcn[4];
+	unsigned int		sca_o_nr_pages;
+	struct kvm_address_pair	sca_o_pages[KVM_S390_MAX_SCA_PAGES];
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
@@ -845,6 +872,74 @@ static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
+/*
+ * Unpin g2 original sca in g1 memory.
+ *
+ * Called with vsie_sca_lock held.
+ */
+static void unpin_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
+{
+	if (!test_bit(VSIE_SCA_SCA_PINNED, &vsie_sca->flags))
+		return;
+
+	unpin_guest_pages(kvm, vsie_sca->sca_o_pages, vsie_sca->sca_o_nr_pages);
+	vsie_sca->sca_o_nr_pages = 0;
+
+	__clear_bit(VSIE_SCA_SCA_PINNED, &vsie_sca->flags);
+}
+
+/*
+ * Pin g2 original sca in g1 memory.
+ *
+ * Called with vsie_sca_lock held.
+ */
+static int pin_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
+{
+	bool is_esca = test_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
+	gpa_t offset = vsie_sca->sca_gpa & ~PAGE_MASK;
+	int nr_pages;
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
+	vsie_sca->sca_o_nr_pages = pin_guest_pages(kvm, vsie_sca->sca_gpa, nr_pages,
+						   vsie_sca->sca_o_pages);
+	if (WARN_ON_ONCE(vsie_sca->sca_o_nr_pages != nr_pages))
+		return -EIO;
+	__set_bit(VSIE_SCA_SCA_PINNED, &vsie_sca->flags);
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

