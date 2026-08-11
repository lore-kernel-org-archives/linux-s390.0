Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1637F445ACD;
	Tue, 11 Aug 2026 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455414; cv=none; b=LxuEB9cM5NHtZEUxaQJLhW23uT6cWl9yoDAZTQ429sIUp8IkDcTrLTi4YptNnQ45XfPtGpqxdYIhMYHfGgzvARDCmUZa8EOlHccbxT3JWx7Dg0Nl//I7e5+WzkXDUoXdyA4jv5paYArVB6hz0V+EJ/UqO3qM1e/cqvnUJogx80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455414; c=relaxed/simple;
	bh=rHq4hIql5bA8YYphZ+pIk4CQ+oS2Wj/dysUmPk733lU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MqG3hl4PHsVZ1FjDcxcBFcGeafYvx2ToMYWKZzEbkScyr3jrTuHwbrBnjBdiXjsOeBTFMkz6Cvt2TbyCQxQiDYdeoatF9STrbKZtjDdmFkvuYFsBcmFjcVRb+2FhZXOfmaXthqBI8QSHAVks7bxVBIKRgRs0ivCEoQbNNLyLGfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jg+50jq4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jg+50jq4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDXDe8451368;
	Tue, 11 Aug 2026 13:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dKzCHo
	tXb58+XDpkdGGamzIxBTQlKQT/p2AGTtu12sA=; b=jg+50jq48XEJjFcAgOrZpy
	nTBaDj6B34o8PEGqKxszFCQhlebS8VRvlsjmfgR4hGrT2N94RTwRUqlu7uayesKv
	ua2eKM6BJ4D8qmAI1mW55XpMizJTQ4kopkxTyGIvCjnzsi6+P1PaCMwnqzjIKGfM
	nGt9sfSIeiqEZHmWG18rfPTdt4YjEGy/EUOTzwM95jeBr44K9em4iQBuua7btfvb
	9mAjhr/juZo7Ty4x1g8kiK9le6pA6EhdIYdmYC7Zj7r7lrHFxC+Qh8owQhGAmavE
	+pM6YWvqIvq/K3mERaWWYtG/YyijFTWqKKmByMXF9F59EvODaNQqOEcHhNw/Dhlw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2vgk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BDQFXY025563;
	Tue, 11 Aug 2026 13:36:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy0vb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 13:36:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BDab3o26215146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 13:36:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5694120043;
	Tue, 11 Aug 2026 13:36:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4BB12004D;
	Tue, 11 Aug 2026 13:36:36 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.69.228])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 13:36:36 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 11 Aug 2026 15:36:28 +0200
Subject: [PATCH v3 13/20] KVM: s390: vsie: Add struct vsie_sca with pin and
 unpin methods
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-vsie-sigpi-v3-13-45aa1ab07c7c@linux.ibm.com>
References: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
In-Reply-To: <20260811-vsie-sigpi-v3-0-45aa1ab07c7c@linux.ibm.com>
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
 bh=rHq4hIql5bA8YYphZ+pIk4CQ+oS2Wj/dysUmPk733lU=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFnVqlFOFtO27Drcss2nb2Nw13uXhROX6Jyx/Gd7umaN9
 pVDXU8bO0pZGMS4GGTFFFmqxa3zqvpal845aHkNZg4rE8gQBi5OAZhI0lZGhlM1G5judEzurGZZ
 vfVf3Y11Tu5pjBYMlp6bf7uorrER8mJk2BFjUXF9+7z5p7Xmuymdmtwlq22xZLPLYZveW++ZZPc
 uYwEA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7b256a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=F8FVqei25e47uhyEDlAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sWVwC-6cTrw6YTodx2ai6CbMOlePjpCo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfX11v0IwduzREw
 xE2NDIRD1QOOGSkrgloT0gmWJZn/Oma/fUHL+VYzQjglJ5bmxwbUOYJjee5q6jAG+aP/XPiBkKM
 VJC930v1Lye5q93FNmA7boJTjaoScM9bHYRNhiuuTCR9GtmFRD/ixheEHn8/rgD6wpDHe1Cd/ef
 5e4GbST0ax0yc3BL8jIddvBIMgfKVQXSQchUJd6QTk4UbQIu8LCbovlwDYO5/DP0lP8PSPQ25MU
 1F6QU1MHSDGRynQE2EXuIAgxmkv9Fw2+uxRmydUB+r9Qc8+7lVO6CFrWBJW6MUZdi3naVnLmwWH
 XbCgNeYmCU6yVwsWBCWeE8i3N1vx6qgcbntAq+Y0UjIs/wbjpYqye7Ykxwqk/ZNoFv2RTg4eqHU
 o9euJxWnVMneHHgMo29M4z82MBupE+j8rcOp2WOxVaewNP2+7Zta3a7Xv4axKAUvr26Mkrk+Knu
 p05fyN8muniG7USlvHA==
X-Proofpoint-ORIG-GUID: sWVwC-6cTrw6YTodx2ai6CbMOlePjpCo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExMyBTYWx0ZWRfXzRX01QdlDDWg
 S41UJYBgsAq5BItm4QJizGhgFI8/ANetEXTIxsb0SxUxK6jfldMUoE5ILmbEArA2y9skQICjnXZ
 36jinP6qUYuRGBJt30WVW6DfX+rv7YE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110113

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
index 8326ba1d2ead..b0421f0a0090 100644
--- a/arch/s390/include/asm/kvm_host_types.h
+++ b/arch/s390/include/asm/kvm_host_types.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 
 #define KVM_S390_MAX_VSIE_VCPUS 256
+#define KVM_S390_MAX_SCA_PAGES 5
 
 #define KVM_S390_BSCA_CPU_SLOTS 64
 #define KVM_S390_ESCA_CPU_SLOTS 248
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 0bbb65300a85..1970bfd8135d 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
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
@@ -76,6 +77,32 @@ struct kvm_address_pair {
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
@@ -844,6 +871,74 @@ static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
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

