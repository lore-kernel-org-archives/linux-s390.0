Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3783803DB;
	Thu,  9 Jul 2026 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610139; cv=none; b=jDgJqKySYyZO+jBJQXl0N/WvgAij/cT9Ll5IiCbTjoYTRzT4LszqeWxgSAuvGdsfUkwv+qxUBY5Ce069GXSP91B3DdeNJqpTcoGSD2dRUMgYEqbklHBtAbDBP/dYG6oyb1FU+dKE7TqehcMMGC7lDiGNwCf8EsB3OY/gOFPUc2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610139; c=relaxed/simple;
	bh=it78sR/ErkcgiHXgXrzvbg1fpVbfSnMV723u0oH2wao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iyUqMlCv0grfXB3qC3BrMvGPQ2WvDmNWtv54aDFhSu6A2MNochxSq4e8sZIWQs+dZycrGf7hIWzWNLvPXqfDbLUGVaJhag0uGkngDTIt2K3OM0Ob45vvz5nFFUUE2+hIAzqO8N2iTSgCrIMEb/+a16gweZsHkHFYiuOE+BDVqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aZOVW6gM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aZOVW6gM"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EIaZi2409159;
	Thu, 9 Jul 2026 15:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nwXbVz
	rel4F8qxjVlNkWQ/tdjeHZPFiymsIZI1uzPd8=; b=aZOVW6gM4soresoZIiAP0S
	ffyMzzPSytC2V15UYvO0GLzjl1Mq5NLCx9useh8LpoizTGayYBXh6mVDrLdI+APT
	z/mGK6Y6WXA50NHv31DHRxgUNxvo3GenmLAj/kK2Y6NQIqd2J4gaoVka+iOEfcUd
	2Jm7hiPana6owN82OVvRm+WJgZ2y0gcrMqIntC/j2YKHq9oVqB0nYJ4cGV+s1tsE
	03pKGAhf3sCgMusvyH00itBaaeg9WXd2m95FL6QOo/e+9AUZ/R5+rrobBBn3JEo4
	Q0WEBc9bn48KEdwOfKGv/YIMVHVgsTjBWfe1JTkNBzV+riTD4Z6h+8uCwCL15RJg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp42e7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669EndwB028366;
	Thu, 9 Jul 2026 15:15:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgqdwct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFTsx24248780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ABB22004B;
	Thu,  9 Jul 2026 15:15:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF2C820043;
	Thu,  9 Jul 2026 15:15:28 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:28 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:15 +0200
Subject: [PATCH 15/21] KVM: s390: vsie: Add struct vsie_sca with pin and
 unpin
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-15-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Eric Farman <farman@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4035;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=it78sR/ErkcgiHXgXrzvbg1fpVbfSnMV723u0oH2wao=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u1lbft6exvmPQ6S9QNP+4rfLcSzv5rY9sv+7QXp13
 t1DKmKBHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEykJoHhn3LOM5+YbJ+wD5kC
 BtyuIfMys9S9XtwUjdEx2/JgfV3PNkaG62KCjboWonZMXoKP1l1XOmxpeHTS/T1X5b9eygi6w3W
 KBwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4fbb16 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=OIv39ysXCM8_XdHbMy4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX9qluFSN3GzJ1
 R0lhc7fUSHlsS8V3F6RkFuTbmOmPAYzAE+BEPT3vKnOxxztDmj1xFg5iD1MdnOBfmlFW6g+POal
 j66i5d63SkSsRc11EzKOIE9flq7ZCfQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfXyxDtOgnNP2+F
 CzPvx8FG606bRPnDhp8Xdq3dcG7E6Hp0EFRVWMxWU9xzEQ/bEjQNY3VqeovjmuAPV7TR5K6J2uJ
 mkZDO6i98Hu9cNiRiKHxIY0qYqrBWBPmeCm4DYgqsLPFK6j+XyZBd6t5hi+ZzvzkSix65LuqL75
 e9BcOeunDL7f8DB00FPKoZu1wiCNPbUT4GX3Pb6X/SLndKbfKwRfBDG2Y+az1Whesg3PZhK6OPm
 VPRCskyYfaBSeP9zKkEyAEx+Qpd2SOUaF5F0+zt2GdeMEmHjyvwAR7tsvC+yZ6JHO4mUu1xF8/6
 OmqHpE2PDganUl890+fMi2eBoJDzNkfFGPNekJFG8ZUvGrYAwOGaYdwD2emW/+q+4JKTCYgFN6w
 4Y+C3UnZqlc/GPGFGs+OPwP7jYHBjCkQc5PUafQ4WJ1CUFCKkqsPfWJdcI/r588JptU8m4hdi6n
 zvzoTlOIl/YR6z1RF+g==
X-Proofpoint-ORIG-GUID: 2CsMsjomex8SDVvIqJpS71iRsQNf-2R4
X-Proofpoint-GUID: 2CsMsjomex8SDVvIqJpS71iRsQNf-2R4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146

Introduce the struct vsie_sca to hold the SSCA and required management
data along with alloc and free methods to use with the struct.
On this basis we can also add methods {,un}pin_sca() to simplify the
pinning SCAs in g1.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_types.h |  1 +
 arch/s390/kvm/vsie.c                   | 79 +++++++++++++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

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
index 874ed2a55347..4b492af15542 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -29,6 +29,7 @@
 
 enum vsie_page_flags {
 	VSIE_PAGE_IN_USE = 0,
+	VSIE_PAGE_PINNED = 1,
 };
 
 struct vsie_page {
@@ -64,7 +65,8 @@ struct vsie_page {
 	gpa_t scb_gpa;				/* 0x0258 */
 	/* the shadow gmap in use by the vsie_page */
 	struct gmap_cache gmap_cache;		/* 0x0260 */
-	__u8 reserved[0x06f8 - 0x0278];		/* 0x0278 */
+	struct vsie_sca *vsie_sca;		/* 0x0278 */
+	__u8 reserved[0x06f8 - 0x0280];		/* 0x0280 */
 	struct kvm_s390_crypto_cb crycb;	/* 0x06f8 */
 	__u8 fac[8 + S390_ARCH_FAC_LIST_SIZE_BYTE];/* 0x07f8 */
 };
@@ -76,6 +78,27 @@ struct kvm_address_pair {
 	hpa_t hpa;
 };
 
+enum vsie_sca_flags {
+	VSIE_SCA_ESCA = 0,
+	VSIE_SCA_PINNED = 1,
+};
+
+struct vsie_sca {
+	struct ssca_block	ssca;
+	struct vsie_page	*pages[KVM_S390_MAX_VSIE_VCPUS];
+	struct mutex		mutex;
+	atomic_t		ref_count;
+	gpa_t			sca_gpa;
+	unsigned long		flags;
+	u64			mcn[4];
+	unsigned long		sca_o_nr_pages;
+	struct kvm_address_pair	sca_o_pages[KVM_S390_MAX_SCA_PAGES];
+};
+
+static_assert(!(offsetof(struct vsie_sca, ssca) & 0x3f));
+static_assert((offsetof(struct vsie_sca, ssca) & ~PAGE_MASK) +
+	      offsetof(struct ssca_block, cpu[0]) <= PAGE_SIZE);
+
 static inline bool sie_uses_esca(struct kvm_s390_sie_block *scb)
 {
 	return (scb->ecb2 & ECB2_ESCA);
@@ -831,6 +854,60 @@ static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
 	return 0;
 }
 
+/*
+ * Unpin g2 original sca in g1 memory.
+ *
+ * Called with vsie_sca_lock held.
+ */
+static void unpin_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
+{
+	if (!test_bit(VSIE_SCA_PINNED, &vsie_sca->flags))
+		return;
+
+	unpin_guest_pages(kvm, vsie_sca->sca_o_pages, vsie_sca->sca_o_nr_pages);
+	vsie_sca->sca_o_nr_pages = 0;
+
+	__clear_bit(VSIE_SCA_PINNED, &vsie_sca->flags);
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
+	int nr_pages = KVM_S390_MAX_SCA_PAGES;
+
+	if (test_bit(VSIE_SCA_PINNED, &vsie_sca->flags))
+		return 0;
+
+	if (!is_esca) {
+		nr_pages = 1;
+		if ((vsie_sca->sca_gpa & ~PAGE_MASK) + sizeof(struct bsca_block) > PAGE_SIZE)
+			nr_pages = 2;
+	}
+
+	vsie_sca->sca_o_nr_pages = pin_guest_pages(kvm, vsie_sca->sca_gpa, nr_pages,
+						   vsie_sca->sca_o_pages);
+	if (WARN_ON_ONCE(vsie_sca->sca_o_nr_pages != nr_pages))
+		return -EIO;
+	__set_bit(VSIE_SCA_PINNED, &vsie_sca->flags);
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
+	return alloc_pages_exact(sizeof(struct vsie_sca), GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+}
+
 void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, gpa_t start, gpa_t end)
 {
 	struct vsie_page *cur, *next;

-- 
2.55.0

