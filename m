Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C3E51DAF2;
	Tue, 13 Oct 2026 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902562; cv=none; b=pqlBG5W/CeTkMIARIMWOcTxwSg7kxwQGyjba1D4vKm3XGfimiHchqzWjs+9DcAt7hR2leQm1zCRj8cgyHjMD/ucAS+XDrnBX8417dGWXFX3GG1QDBmsiXjweYBXHYjsZUn2q/o05Pwb9joVP8KPPaugZwWiCrSEfxNdYerhIKis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902562; c=relaxed/simple;
	bh=gki4PqMyEFuaN3sYqYSnFREY/5dld7W0TIu+9NP9hSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T36AifnXrAjIEYjX1khZF9YA4kFqXozGc93WCUa5hOU8tq1Og2+DkpTUYXoR9l2GnVKESrgHguhH/bntYN4PUn1iHZmokIPUAqSxioVbiMxmdIyxqXHiQ9Usw47bsJAD/XGtabvJes2tfGlf0E6O6jEihUod/uBGb+8scNTsVlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eWsBQ6ae; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eWsBQ6ae"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDm5o5151880;
	Tue, 13 Oct 2026 14:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sw0OuizzvLLn1DSCm
	uK8oZtZtFWj4l5J0cwi4w/14s8=; b=eWsBQ6aer+foHbFYvf4pt5gSMUQA+za1w
	apiR6upmr07RqQ9qEZs1H7rvTe4t9pkvWpwYtvzmA46K1ABjUoRaAJzYA1LV7sV2
	49f4IwF0k1OB5dDc14fX8pCalf7gRhIWvVCH+7dq5ZdbR5NRRnijyNyyPN3qcy5h
	QyHoFOF9tsluXJv8K0YXRWF97HRQDg89+HZ2R3pLiRofQ9NBvtJCUR1aC8xpCMik
	1XZmtaqpt+/T9S7GCtJ3dVpqZZoCUSrPAuLkzL1fGXXYKj2C/IHqDC3hex12lLcN
	jpTAuS8Xey6OLB9SMqCi/wmfL63cbbe56bMcTgiGLgUQjA5BAoegA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwherp5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 14:42:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCHqLK2709289;
	Tue, 13 Oct 2026 14:42:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816h2ah7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 14:42:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DEgYFd34079346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 14:42:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4745B58068;
	Tue, 13 Oct 2026 14:42:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E22BE5805D;
	Tue, 13 Oct 2026 14:42:31 +0000 (GMT)
Received: from t83lp65.lnxne.boe (unknown [9.87.84.240])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 14:42:31 +0000 (GMT)
From: Gautam Gala <ggala@linux.ibm.com>
To: borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, pbonzini@redhat.com,
        seanjc@google.com, shuah@kernel.org
Subject: [PATCH 2/2] KVM: s390: selftests: add ESSA migration mode PGM_ADDRESSING regression test
Date: Tue, 13 Oct 2026 16:42:25 +0200
Message-ID: <20261013144225.8885-3-ggala@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013144225.8885-1-ggala@linux.ibm.com>
References: <20261013144225.8885-1-ggala@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NiBTYWx0ZWRfX5m7dnWBtUYZN
 COeL0tk3RWIh0IIqI8s+nN/9zO5Oz6uSJS8NKRZnQMoKDRqRqT1z52r04Zjg49C994yA6FJSoOI
 A4tm0oad9cRUCmfCsxObIwHQjyNuBIw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NiBTYWx0ZWRfX6cirK3VY+GCz
 Usn64JP/GLt9EiFL3mQWE3FmGCnUU/kV6Kzt7zmUMExSuSMV/fPR4GtHotTzd1EC26a+cHIYeDW
 FWmFKvKQ1UxAlZbNji9YhXOrAR1vhFyeVwP0iljJHqVBP+pWQCjHfWvgmDwCcOhqam0CHc2jacT
 LClmCJWFuL8uqvhqKkGUXHMZXjl+EYUA+JVB4CzzvRmV2X6isZ2K7Eb/Mv4Lm2MXwIwrR1W8mPw
 RcJyVaE/VzO1sbi1HvAREKHzgBE6OHLdtY6MrqPWoDowHJmHfc9m1OR71ffHSXU2AocrjBGhRs+
 WXKT/dE15BElOuGesSYvlhnx4ZJTY2ziKKs0Wh5bn5A9daNYJW8zL2DQ+2zrp224P2Msy7AKMWm
 yM1zAy09xz115iutOwuVBZY5suQHEgb6VMfAiQhMrL7JS+kuo1k+pNlq3R4THMtLUIN/Zc9wfSN
 8apVrmy+CJhL3Nly7DQ==
X-Proofpoint-GUID: sKx43bbwrGBZ3mRCRtpGd79olc5vpGSf
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6ace435d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=lRAwDPCLeQXcjmSgwEsA:9
X-Proofpoint-ORIG-GUID: i6WN06vnnGBN8ceIgqgSyC8AVuM2nHWe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130056

Regression test for the bug where ESSA emulation in migration mode
silently dropped addressing exceptions instead of injecting
PGM_ADDRESSING into the guest.

The test is integrated into cmma_test alongside the existing CMMA
migration tests.

Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390/cmma_test.c | 79 ++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390/cmma_test.c b/tools/testing/selftests/kvm/s390/cmma_test.c
index 15d81b2ed7ad..2b351b4fc894 100644
--- a/tools/testing/selftests/kvm/s390/cmma_test.c
+++ b/tools/testing/selftests/kvm/s390/cmma_test.c
@@ -8,6 +8,7 @@
  *  Nico Boehr <nrb@linux.ibm.com>
  */
 #include <fcntl.h>
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -18,6 +19,12 @@
 #include "kselftest.h"
 #include "ucall_common.h"
 #include "processor.h"
+#include "sie.h"
+
+#define PGM_ADDRESSING		0x05
+#define VCPU_RUN_TIMEOUT_S	2
+#define UNMAPPED_GFN		0xffff000UL
+#define __LC_PGM_NEW_PSW	0x1d0
 
 #define MAIN_PAGE_COUNT 512
 
@@ -651,6 +658,77 @@ static void test_get_skip_holes(void)
 	assert_no_pages_cmma_dirty(vm);
 }
 
+static void pgm_handler_c(void)
+{
+	GUEST_SYNC(PGM_ADDRESSING);
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
+		"0:	j 0b\n"
+		:
+		: [addr] "Q"(addr)
+		: "r1", "r2", "cc", "memory"
+	);
+}
+
+static void handle_alarm(int sig __maybe_unused)
+{
+	ksft_test_result_fail(
+		"ESSA migration mode: vcpu_run timed out - PGM_ADDRESSING was not injected\n");
+	ksft_finished();
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
+	lowcore = addr_gpa2hva(vm, 0);
+	pgm_psw[0] = vcpu->run->psw_mask;
+	pgm_psw[1] = (u64)pgm_handler_c;
+	memcpy(lowcore + __LC_PGM_NEW_PSW, pgm_psw, 16);
+
+	/* Migration mode requires dirty tracking on all memslots. */
+	vm_mem_region_set_flags(vm, 0, KVM_MEM_LOG_DIRTY_PAGES);
+	enable_migration_mode(vm);
+
+	signal(SIGALRM, handle_alarm);
+	alarm(VCPU_RUN_TIMEOUT_S);
+
+	vcpu_run(vcpu);
+
+	alarm(0);
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
@@ -659,6 +737,7 @@ struct testdef {
 	{ "GET_CMMA_BITS: basic calls", test_get_cmma_basic },
 	{ "GET_CMMA_BITS: all pages are dirty initially", test_get_initial_dirty },
 	{ "GET_CMMA_BITS: holes are skipped", test_get_skip_holes },
+	{ "ESSA migration mode: PGM_ADDRESSING injected on unmapped GFN", test_essa_migration_pgm },
 };
 
 /**
-- 
2.55.0

