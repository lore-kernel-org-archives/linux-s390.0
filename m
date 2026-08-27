Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24838486E4C;
	Thu, 27 Aug 2026 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846002; cv=none; b=DXs8fmwKn2UGYF41E4lAo8j4ANC5mtEbgu+0JVJyVuZLq0OxQ5p6atDYCt+LvZ9WFZOD2NTfKyvf1UXl7m2mbUVuFaQuh60lMIyzCWxT5Ely9Um7nR23Q1aN9Me4Q8nvvvlJQDHjXNdy3didTz6VwEcebmXxRa+Y/ZkyZ0wuQI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846002; c=relaxed/simple;
	bh=wKg4imVUpXrG6NKzkjGdC0TaD7wHsqhZPTwiss8sRVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BRa76X8DDilEPfHVYdbc6ZXO010G5wmqzGZGGi7ion9LyC2RoKJsZ/RgBfCqUhDHRs3zkL7KSLipkVfC9enU3YXgacSRib21nGsnz/ymaXHOibq1YraVML5dKME8pdM+rUQ0XPqXcP4ma7FhVsy3nMp0NXKpOy0VJS7bsGdwRB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aL4JDiAE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aL4JDiAE"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF52ev3355162;
	Thu, 27 Aug 2026 15:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6AilMC
	GHHarHSWzi0VLydvneYBaG1RCVtfa1s3XTAYo=; b=aL4JDiAEGDrSL3rw4w3wOa
	vPSwoDpofqgpkO8AaYisS7gPz3yXRmuwQsGIRwbDqQulNnXeN24upNLzlx8JGPTv
	LAmCTz6+f0I8XMRlvvls1J4SutRLe6sVk15qYYG11fKjLcKDe2GW3pFiIWNUtlDC
	ogxBwHxzlZ5riOQy4hROjKDcMYmsdyd4Y8q92ZPxGbhW7LG2mzCYzcJTcsuDKVlA
	plmYc7V8DEac/tRAORWelQXZuLVneZvr+q9V5smvsTPjwpm1iPGQcYvwD+CZDIL1
	HFPGfe8kSQBhI77iP6zgBU91HG40yEU3S5x5wkLy4/IEQmlYFIGQDJf5Bbe8033Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g56f4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RFflH8006069;
	Thu, 27 Aug 2026 15:53:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragrqtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 15:53:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RFr7Zr40304938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 15:53:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 031E520043;
	Thu, 27 Aug 2026 15:53:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B27620040;
	Thu, 27 Aug 2026 15:53:05 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.61.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 15:53:05 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 27 Aug 2026 17:52:55 +0200
Subject: [PATCH v6 15/21] KVM: s390: vsie: Add struct vsie_sca with pin and
 unpin methods
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-vsie-sigpi-v6-15-8020bb53be52@linux.ibm.com>
References: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
In-Reply-To: <20260827-vsie-sigpi-v6-0-8020bb53be52@linux.ibm.com>
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
 bh=wKg4imVUpXrG6NKzkjGdC0TaD7wHsqhZPTwiss8sRVM=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFkTYoMPFGo+9vYXyuXId+s1UHt4x3vP487ygvebT/azm
 t/1CNbsKGVhEONikBVTZKkWt86r6mtdOueg5TWYOaxMIEMYuDgFYCLbtjD8r5rTVSAe4ZI4e/ff
 VSnLG59/63ostFBB4yMrk/18DcduLkaGrYntLw9O2PPc8vfj5Q+Erx78V2VYl/Ky903Xbjmm83r
 1bAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: wPvj2-7WPYVVwQnWF4PZprT-ML8Pds7-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX8AfDSIoUZMwW
 xiYMJbPrX3HeDgxWc9cr7qOAbRL0bYwhUWZcu2QsFoUKDwnoBcjDoQMEKzZu/i/UetnzwpUWkcI
 L+FgC0PjNhtp4+lUrbDwK6wGGqoY93Q=
X-Proofpoint-GUID: xzt9-Auxju5dCh4g4JRRKLeMjpUe93sP
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a905d6b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=F8FVqei25e47uhyEDlAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEzMSBTYWx0ZWRfX1G42Z5pbPNp1
 PpoF8z2St2IEIXfW/4VORf64g5U6MYvND4LOojP9f4CqtmSpHaZaGXm5U9LDdDsrLutGuuDhJld
 3h1IeO0SKcFqdmQlYvQSftyc6gzPjgscV1J6m1yLEg2nhqoPTwJ7TVWMFNKAAFMewinhKS616rF
 HUWGNEO41V5z6vLGmnOQEwgpsPf/BbVd6UQu2VV5hAhsEM1yTUoGVoJZOHt1Pt5sOGLbaRC6KMk
 y7uVTroMoBsNTs72PRuu66jLAeYeKDs3s2kPqxkO+RFeEJtoZWov0og5CAoGXIFXjUFBa/L8Uvn
 FQ9embTcH+xmXu1vNj94YLffN5dh0Z/oc6rxdpTOckeXCd+PhJYzGs9RPAMcwEARdf6RKZiUfx9
 G4QXh9kNXPbN+L+tFAeSeFrGLj5foS2rKZqGQjMvdVgrv9auKDPa5v1m7/YeO3Lft0/VRzRrNrC
 py/wQ9e836mzJdOhW6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270131

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
index d52c3a42aa27..69334d4a3231 100644
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

