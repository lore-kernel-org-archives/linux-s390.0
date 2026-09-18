Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5314501297;
	Fri, 18 Sep 2026 15:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744189; cv=none; b=m/vAwKLmiUcP1pLLtKP/68xS78DssqL57TlivREoYbn/igok4hWmh/+2wLtIV49b6ppL6WZlncLjYmDes5JhG173UbN9wrq9aNz09Pf0m/cByZ3aMQ7Par/9/ZeXP+f43E3UzM1iGVJHrIgvrrNGBdRoolfkWsYA9MMFKuYnm5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744189; c=relaxed/simple;
	bh=pO6OdBRB72enlVOM0UmHRsaqVeV+A1iUOreJuFDH1MQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z3HXwD+pdvRLUtUSBOgR0CXho9pXCe506RRxvjiqm9Dlgo6gqI3o4gb4GGRufFKUumCPKpe6Y/vPpyABfZgiGTV6vcSt6+i4bYsgXux9/HU1W+GNewwXHwYEDcc30VOLmv91sbVo9iaHpy7Qyvw8+mbN1hdTYxjccEydbKVh4PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S1ezXixL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S1ezXixL"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVmPO1236092;
	Fri, 18 Sep 2026 15:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+WP9+/
	XejeHQm/4hztHw8/vuKI9AnB1CyAqzDQPHC0E=; b=S1ezXixLq1Z4omb7buHUvb
	8Mx2BtmH2n8wpTJTboCpp3StR1uAmffZvow3/rAJf0W/jaLo/2981+rDQn5PS/s0
	Xt3RFZfsWH2npq3wyNhjsz3RNGqJmNvV67co/l/xkWahWI6d0VWBsb5paUFooVHc
	2H4nbJi48382bk9bbRvJ8pPxLGx9IdT2Wdco8AN6HTh+yAF23W2yj/budfh1d7xW
	dLNfRGecntysUHeuK0/Pa+0sY5f13lq4UqgdRzTM8ozNQJF8I0zciLceMgrLR3l5
	/KQjz7kOOjV99bCDilQ3Xdk+2TN3mx25BhbtqodvW42LtF4KC2KLiIOYQj/ZINbQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j8gey-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDO9gg771962;
	Fri, 18 Sep 2026 15:09:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5fffvrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 15:09:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IF9VO132244314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 15:09:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B886C20040;
	Fri, 18 Sep 2026 15:09:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41B1C2004B;
	Fri, 18 Sep 2026 15:09:31 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.72.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 15:09:31 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Fri, 18 Sep 2026 17:09:32 +0200
Subject: [PATCH v7 15/21] KVM: s390: vsie: Add struct vsie_sca with pin and
 unpin methods
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-vsie-sigpi-v7-15-f39806eaae37@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4450;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=pO6OdBRB72enlVOM0UmHRsaqVeV+A1iUOreJuFDH1MQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFlrQ5Ryel6qnGTt/DP3e0Snl66o9roD530d61yl7tq/b
 AmQFf/QUcrCIMbFICumyFItbp1X1de6dM5By2swc1iZQIYwcHEKwESqjjP8jziWILc5M+q/aZG7
 8/cbkUenyjN92qSvt8WpfvXa4qIWGYZ/5tyi5wqtUj2/TfrBfb8kZaOXomKa69L6+30M295vrJ3
 AAwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfXzqNfug7e4JyV
 nHomOhybd5QtDfhjnKlV5LAQNVUyzmMx9UzVj10etdENOZVTmdkGIX6j5hc8D1yRZAWeDsJZBEv
 0oXY+5MRNysfAIDsd61coFDD//cmD2ugZh6Zz4aVKfMoiih9xke5AbQrIh5r1FFBfNS3CHmtS+/
 pVjo1kdaGfjt/VKLXDA9mP9coXjKg/pgae7mGzgI/gc7GNzvAhZdoMkIwUQtwOatkksWZGhJPWj
 MlGyF7FugW8FijD6l8ajAbGhvRvZO23i2/iCXSB2q6tHK3eLNLOkLh8oEsUqaXAyrkppmqt+bLZ
 CfayjyiPpkAZ6cEnOyDB8LLFFTEVvlAB3nhHM/CfGiNBUmSfW6Y69+qAPN88W+HPsxGudjyi7Xi
 ECrf2Je8oaml262SIlmvKUL+19IfGEWDlelnMrccJC5YLjHH6sTvz4+D92CaMC0Oun+Lk/45q/K
 477s8SHReOZoc6vI15A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDIxNCBTYWx0ZWRfX3ZkjOY0iEgvm
 7gzu1yyq2/cnGDa16QxamFHUbg7rQW1xJwG5PLzEcuqiltYj9SAqPUMM58jXGhPQJAU9VVpDog6
 rK7DEomg2jdjhM7BqLrESmYcG180mBM=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aad5430 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=F8FVqei25e47uhyEDlAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hFNenOKpQH36RWntrAXbdWc5VokWxw3Y
X-Proofpoint-GUID: pMbLlX3uflDd8xwWOFVLUhxFB533xIp1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180214

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
index fa43b6c46bbb..c67623a0185e 100644
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

