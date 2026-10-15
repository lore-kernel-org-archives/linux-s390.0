Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABD4D6C55;
	Thu, 15 Oct 2026 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061317; cv=none; b=Gu/ZAPx4+O8m5Z7xizxd+SjDMGK0RmIWUl2y7BKDGkGKlzVsEcfH+9GtXW47m6J58QngPh8jdaRZzTYAOvNaPW/74ueKIhWiD924COxYfW/33BZikN3LeJRU7LiHRRNWTrrth/v7zbP96Tr0BGbOxlke7hzCpKD2aP/jFJOCRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061317; c=relaxed/simple;
	bh=vfLzHLtpTAKftZr+xANKJbzHv2meWv9e1g2x3h+oT5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S76M0b4bHRRiKhnJK8NCTVp9HaYkaEuMIOaV1A0n93MlKrtH5gGzX3ytaiRvesIEoVb7/mRRBvOdVB2z9wl+K5RA5bP3a06whDzR4metetvB5CUTwYE2U2isfFswc8AvTtPaJdcGhDCX2TFzrAIBNBdDQP+cQAclpAs3YPbUftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EWNJbuGp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EWNJbuGp"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9kGwg3000794;
	Thu, 15 Oct 2026 10:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uVgETm147/nAjd0A2
	AnRu2J1hHtEfosbyyRiuUNXVXU=; b=EWNJbuGpu13hj5EnTnmCq49h7J/apOrMr
	Ajwc1hf2UbZfcyX56iWWWHjiKxNalFDP1z38FeF6YHOvrX3DlqqifmrayI57MDWa
	FUSAf1DIYCxvMwlPBXTa5g7sQKy1I9c+MCGqH4de6yikv4G2JHf9FPNY1rPFZijj
	1NCUI3XsrfGHRCFY9u3n+Z+yo3rJJ7Ub6Suf4HkKpKmef9XyD2B6rGNSsEejV07X
	sMeanAWglh46A6gHb0nEwapAtWUTs6AfoKr/qVgXKmNvHUgzq7R35li1/SDkuXJ/
	8E6h8XpvvrZcfG9ZIpRCQb9DU4K4M5NexsH81KdT9zjSr/eIgKazA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhsf92-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 10:48:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9ntZm1974793;
	Thu, 15 Oct 2026 10:48:31 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9qb710ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 10:48:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69FAmUOE16056888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Oct 2026 10:48:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9042B58063;
	Thu, 15 Oct 2026 10:48:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46C4758062;
	Thu, 15 Oct 2026 10:48:28 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Oct 2026 10:48:28 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc: frankja@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, shuah@kernel.org
Subject: [PATCH v2 2/2] KVM: s390: selftests: add ESSA migration mode PGM_ADDRESSING regression test
Date: Thu, 15 Oct 2026 12:48:22 +0200
Message-ID: <20261015104822.77062-3-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015104822.77062-1-ggala@linux.ibm.com>
References: <20261015104822.77062-1-ggala@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfXxc2mdt/peRlK
 NoSkMqXWAuNhng1j9SYGtd7B1bqx8l2zoVqP8KIYlQbk0fUPn1aqMRLaHCKaHYLRbo593rqARxU
 D78+n0THxfXJqhiOKKAxe88mpgzaFnM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0MiBTYWx0ZWRfX0ONnTVx0dILZ
 ixxonLDNG7Xov5pPn0azUCc3J7TlK8PH1t2YrSxJ8e5SKAl+3iGZ6cSFQhpwP7DSDlxiS+HAWgv
 s6N8+1cWwRMguY9aVD7wnrW4qGnx07cld9SEMSyz0AkCxCmkIksZ7oaEGefE71SgPVqWEeZ/Mr6
 4X0a4T3QCiZU8nQXDH5yA886VL5+5SKu2mxSYRVYbjtDohFz5sTSOHyqYwgQ4FOKQGhykY4yAf4
 HJMtUFZOsfye8L4/k3tZMG/I8mQHxIr7FF0FMcKYn9vAfRkl9TTAo9bt4lYEB43yzxW/F7+fMHx
 RXbFcIxtT7FAye5ngyA6c908Mj4fOxy1xBiHQi6x6weTG26a/8m9DXSLDHkfagiOx9+aYrsCdXg
 1+93vtx8yck+P+PmqJ6Hqp21Y7lJQEXQjchIxBctAdIemsqRfwcQ7fsFKcFXHztU0tSpOnftCVl
 f6SnTe3M3O634/qAF+w==
X-Proofpoint-GUID: gniNwwBMB-3RD21edzUmuQgQmJzN7S3j
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ad0af80 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=lRAwDPCLeQXcjmSgwEsA:9
X-Proofpoint-ORIG-GUID: mweYjPgDJg24DILcNJ-XViKk-lhkw_57
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150042

Regression test for the bug where ESSA emulation in migration mode
silently dropped addressing exceptions instead of injecting
PGM_ADDRESSING into the guest.

The test is integrated into cmma_test alongside the existing CMMA
migration tests.

Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
---
 .../selftests/kvm/include/s390/processor.h    |  7 ++
 tools/testing/selftests/kvm/s390/cmma_test.c  | 69 +++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/s390/processor.h b/tools/testing/selftests/kvm/include/s390/processor.h
index 33fef6fd9617..d71df6784dad 100644
--- a/tools/testing/selftests/kvm/include/s390/processor.h
+++ b/tools/testing/selftests/kvm/include/s390/processor.h
@@ -26,6 +26,13 @@
 #define PAGE_SIZE BIT_ULL(PAGE_SHIFT)
 #define PAGE_MASK (~(PAGE_SIZE - 1))
 
+/* Program interruption codes */
+#define PGM_ADDRESSING		0x05
+
+/* Lowcore offsets */
+#define __LC_PGM_INT_CODE	0x8e
+#define __LC_PGM_NEW_PSW	0x1d0
+
 /* Is there a portable way to do this? */
 static inline void cpu_relax(void)
 {
diff --git a/tools/testing/selftests/kvm/s390/cmma_test.c b/tools/testing/selftests/kvm/s390/cmma_test.c
index 15d81b2ed7ad..0899fa971dcb 100644
--- a/tools/testing/selftests/kvm/s390/cmma_test.c
+++ b/tools/testing/selftests/kvm/s390/cmma_test.c
@@ -18,6 +18,9 @@
 #include "kselftest.h"
 #include "ucall_common.h"
 #include "processor.h"
+#include "sie.h"
+
+#define UNMAPPED_GFN		0xffff000UL
 
 #define MAIN_PAGE_COUNT 512
 
@@ -651,6 +654,71 @@ static void test_get_skip_holes(void)
 	assert_no_pages_cmma_dirty(vm);
 }
 
+static void pgm_handler_c(void)
+{
+	uint16_t pgm_code;
+
+	memcpy(&pgm_code, (void *)__LC_PGM_INT_CODE, sizeof(pgm_code));
+	GUEST_SYNC(pgm_code);
+	for (;;)
+		;
+}
+
+static void guest_essa_unmapped(void)
+{
+	unsigned long addr = UNMAPPED_GFN << PAGE_SHIFT;
+
+	asm volatile(
+		"	lg   2,%[addr]\n"
+		/* ESSA r1,r2,orc=1 */
+		"	.insn rrf,0xb9ab0000,1,2,1,0\n"
+		:
+		: [addr] "Q"(addr)
+		: "r1", "r2", "cc", "memory"
+	);
+
+	GUEST_SYNC(0);
+}
+
+static void test_essa_migration_pgm(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	char *lowcore;
+	u64 pgm_psw[2] = {};
+
+	vm = __vm_create(VM_SHAPE_DEFAULT, 1, 0);
+
+	enable_cmma(vm);
+
+	vcpu = vm_vcpu_add(vm, 0, guest_essa_unmapped);
+
+	/* The guest runs with DAT on; map the lowcore so the handler can read it. */
+	virt_map(vm, 0, 0, 1);
+
+	lowcore = addr_gpa2hva(vm, 0);
+	pgm_psw[0] = vcpu->run->psw_mask;
+	pgm_psw[1] = (u64)pgm_handler_c;
+	memcpy(lowcore + __LC_PGM_NEW_PSW, pgm_psw, 16);
+
+	vm_mem_region_set_flags(vm, 0, KVM_MEM_LOG_DIRTY_PAGES);
+	enable_migration_mode(vm);
+
+	vcpu_run(vcpu);
+
+	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_S390_SIEIC);
+	TEST_ASSERT_EQ(vcpu->run->s390_sieic.icptcode, ICPT_INST);
+	TEST_ASSERT_EQ(vcpu->run->s390_sieic.ipa & 0xff00, 0x8300);   /* DIAG */
+	TEST_ASSERT_EQ(vcpu->run->s390_sieic.ipb >> 16, 0x501);
+
+	get_ucall(vcpu, &uc);
+	TEST_ASSERT_EQ(uc.cmd, UCALL_SYNC);
+	TEST_ASSERT_EQ(uc.args[1], PGM_ADDRESSING);
+
+	kvm_vm_free(vm);
+}
+
 struct testdef {
 	const char *name;
 	void (*test)(void);
@@ -659,6 +727,7 @@ struct testdef {
 	{ "GET_CMMA_BITS: basic calls", test_get_cmma_basic },
 	{ "GET_CMMA_BITS: all pages are dirty initially", test_get_initial_dirty },
 	{ "GET_CMMA_BITS: holes are skipped", test_get_skip_holes },
+	{ "ESSA migration mode: PGM_ADDRESSING injected on unmapped GFN", test_essa_migration_pgm },
 };
 
 /**
-- 
2.55.0

