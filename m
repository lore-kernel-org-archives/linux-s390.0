Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309397;
	b=nQaaB6OdCr+8Tujz6Pc1Mkr+Fq28jL92ujjmkiZFi9HqxgdTJZuWILkwKkQPtFE25bWQ
	 WVeYn8EDXJPosg8Z97fC9XB/YIinozO9JZSHlMbP5SupUZS9fzgYEeAkzO3CZge1OKgLB
	 Snerm+ae9WUcy3hasAObm1xA5n2DY94obx+XCEo/H5TWzxohfJiHJKGGl8cLxGP24ykiu
	 FSNX9ea5VT1k7gxhZXp8+vEr9om1Hhmcbzlw+H+a2iuXQGULGE5mhrBT7Iv/bBAsjEkXX
	 LNVqmpBPoCgERfpIeiTzg1BMSPP8i5yjrhk/hs/Wo6ZD11gl07SvmmOPjeJIcTu+ufQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309397;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OhgsaZa9dfZdhvzdcld9Vtx0WNsoYnaSMpa7SReGwck=;
	b=A1K2Otlmjh3N+ndHMj7ltVyHH7NZtaMw6tYc1/10xQgSFAIuElXQJigFttsYgLCPBicD
	 t1vAp1yCpHwI63BMNVyzxprkyMR8pIhtV7t+h/OixPsrYMiOdzWFCd3Gwbls8Tf5NR1lY
	 HBaOkldtncYa5q7eHId6KJituSwY6cUeM5b+h/wQT6xZ1oOcKE7xrd7dk/62hlH0zr7DO
	 8UtxbS99x62hiJ294cZl0l8HosePlOBNJ3RHFuhJSgvt+nC9oXjRyj84eneGAMrLaKDEM
	 fDmjgu6+xd3t7umYTk1vo3k7QTkZPCUOnQNuc4cJz4ZRbpxYRxX9GWe/BbkiHmpxl2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QazgTrKC;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F8606A33B;
	Tue, 10 Nov 2026 11:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C5F8606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QazgTrKC
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABEJVF2179792;
	Tue, 10 Nov 2026 11:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OhgsaZa9dfZdhvzdc
	ld9Vtx0WNsoYnaSMpa7SReGwck=; b=QazgTrKC1s1jRAhZgDaDp6EfLasdGYBNx
	OuDoyP9/INp7NsxSQyVuP2OHQw1z4JoDzRMiq+pE5SSyTg3o5AwJrT0uO5iLe0be
	+XaLT+coAeqkEqupX+0SR3NCxAVy/qIWXyGymmuJvYhYKoZECp5XWJqaR4n3490Y
	OjW/4eF6883TWjmIVVEoiHmXP6u6Oi14ar3hlyMhwL6+Z2EJYWya5/77wDEtksLp
	jzj5nBp7P5dZGy3wf8cWDvw/EvebxgqdgBBNi2s7RBT+dmgc5DEM6imLDqO8B11J
	WW0XntmN9blhEF0whYlc4/FwqU8ZBlsxEjltvVi4RqnHCj8aAEzAg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumuuumq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 11:16:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7nugO1406243;
	Tue, 10 Nov 2026 11:16:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfak6a63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 11:16:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AABGXl934472702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 11:16:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63D1F58051;
	Tue, 10 Nov 2026 11:16:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4ABC5805A;
	Tue, 10 Nov 2026 11:16:32 +0000 (GMT)
Received: from MacBookPro.localdomain (unknown [9.61.241.43])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 11:16:32 +0000 (GMT)
From: "Aaron M. Brown" <aaronmbr@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Nitya Khamar <nkhamar@linux.ibm.com>
Subject: [PATCH 4/6] KVM: s390: selftests: Add ucontrol helpers and instruction tests
Date: Tue, 10 Nov 2026 06:16:17 -0500
Message-ID: <20261110111619.61760-5-aaronmbr@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
References: <20261110111619.61760-1-aaronmbr@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX5UmtKvFmhcnY
 Q2syl1M+h5Lk5xDci+sG8oMNO6lqhCZSajzqcEgbT+/OqLoj8xXRvTbPisTge/3wa4KG1Em/5HM
 CGldeUjnfrgeLm3qNSQyRUhp75oKpgs=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af2fd14 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=3Pb-X4NI9fnZ4whSHBkA:9
X-Proofpoint-GUID: bKopjZH_gru6ZZjHuYTN8bpYiEDuS-L8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NCBTYWx0ZWRfX/zds8K87s5/1
 wgZXY3wT7fHxFsDh1s6jegJwSMiPYj4wqcfq9eq6OeYneZ+YV+LsY6fLq8RLa/5r2cMeHykEiB0
 Vq6e/fYyw5AZUvwgPLNv1U6D4gdA7OQwt22NVjykEvagnYp/Dlr3QCfxs+ef76Kv/p300Njasu7
 jcjUJWuwqJ/wkcA0TUG8wEZdHpmCnTlc4Y/yb3tHtMlzqxLItuFzxTmuTcCbe1dW4HTii2gXnCY
 iFwAhSq8nG0cJvVwX5e3QkRi75vB6g1LWJUX//jbZgYMLkBSYmBsoyx7dMY6BiJLM69LXU9ZjCD
 WLnhUhYqv/Rj7EPR9m4Zb5T7QxvcNv5Tnoup6oSiRpjGN5+ASnaKoR5lqICpnWrx3DrbPVEQbNR
 t4JXyyaZQ3rDZOs0KNw8jfEl7wpowBDv5cxWT63L0sBi2zVtf5kiWsOvo6+e3vWDQuoYIHEAtka
 ypJDoOWjTOKl4uaRXRQ==
X-Proofpoint-ORIG-GUID: bKopjZH_gru6ZZjHuYTN8bpYiEDuS-L8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100044

Add helpers to run a guest on a ucontrol VM and use them to test
instruction intercepts handled in userspace.

manual_kvm_creation_execution() creates the VM and vCPU, maps 4 MiB
with KVM_S390_UCAS_MAP, sets the PSW and r15, and runs the vCPU. r15
must be valid because C guest functions adjust it in their prologue.

ucontrol_available() checks KVM_CAP_S390_UCONTROL and CAP_SYS_ADMIN.
Tests that need it are skipped, with a reason from the new skip_reason
field.

Tests added: STSI, TSCH and STSCH. Each must cause ICPT_INST with the
expected opcode.

Co-developed-by: Nitya Khamar <nkhamar@linux.ibm.com>
Signed-off-by: Nitya Khamar <nkhamar@linux.ibm.com>
Signed-off-by: Aaron M. Brown <aaronmbr@linux.ibm.com>
---
 .../kvm/include/s390/kvm_lifecycle.h          |   8 +
 tools/testing/selftests/kvm/s390/kvm_exit.c   | 220 +++++++++++++++++-
 2 files changed, 227 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/s390/kvm_lifecycle.h b/tools/testing/selftests/kvm/include/s390/kvm_lifecycle.h
index 7dec11a6e214..8b17eff9cb3e 100644
--- a/tools/testing/selftests/kvm/include/s390/kvm_lifecycle.h
+++ b/tools/testing/selftests/kvm/include/s390/kvm_lifecycle.h
@@ -17,6 +17,7 @@
 struct kvm_lifecycle_testdef {
 	const char *name;
 	bool (*test)(void);
+	const char *skip_reason;
 };
 
 struct kvm_parameters {
@@ -28,7 +29,14 @@ struct kvm_parameters {
 	struct kvm_s390_irq *irq;
 	struct kvm_s390_irq_state *irq_state;
 	struct {
+		struct kvm_s390_sie_block *sie_block;
+		struct kvm_s390_ucas_mapping map;
 		bool immediate_exit_condition;
+		void *vm_mem;
+		int run_size;
+		int vcpu_fd;
+		int kvm_fd;
+		int vm_fd;
 	} manual_parameters;
 };
 
diff --git a/tools/testing/selftests/kvm/s390/kvm_exit.c b/tools/testing/selftests/kvm/s390/kvm_exit.c
index 2f73eae1954a..d0a3894daf0d 100644
--- a/tools/testing/selftests/kvm/s390/kvm_exit.c
+++ b/tools/testing/selftests/kvm/s390/kvm_exit.c
@@ -13,6 +13,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
+#include <linux/capability.h>
 #include "test_util.h"
 #include "kvm_util.h"
 #include "kselftest.h"
@@ -21,12 +22,21 @@
 #include "ucall_common.h"
 #include "sie.h"
 #include "kvm_lifecycle.h"
+#include <linux/sizes.h>
+
+/* capget() is used to check CAP_SYS_ADMIN without a libcap dependency */
+int capget(cap_user_header_t header, cap_user_data_t data);
 
 #define NUM_GPRS 16
 #define DIAG_ASSEMBLY_CODE 0x501
 #define IPA_DIAG 0x83
 #define PSW_MASK_64BIT_DAT_OFF  0x0000000180000000ULL
 #define PGM_CODE_SEGMENT_TRANSLATION 0x10
+#define CODE_GPA (3 * SZ_1M)
+#define MEM_SIZE (4 * SZ_1M)
+#define STSI_IPA 0xb27d
+#define TSCH_IPA 0xb235
+#define STSCH_IPA 0xb234
 #define PSW_WAIT_BIT_MASK (1ULL << (63 - 14))
 #define PGM_CODE_GPA_ADDRESS 0x8e
 #define PGM_CODE_MASK        0x7f
@@ -53,6 +63,96 @@ static void compare_regs(struct kvm_regs *regs, struct kvm_sync_regs *sregs)
 		TEST_ASSERT_EQ(regs->gprs[register_number], sregs->gprs[register_number]);
 }
 
+static struct kvm_parameters manual_kvm_creation_execution(struct kvm_parameters param)
+{
+	int rc;
+
+	param.manual_parameters.kvm_fd = open_kvm_dev_path_or_exit();
+	param.manual_parameters.vm_fd = ioctl(param.manual_parameters.kvm_fd,
+					      KVM_CREATE_VM, KVM_VM_S390_UCONTROL);
+
+	TEST_ASSERT(param.manual_parameters.vm_fd >= 0, "KVM_CREATE_VM failed (%d)", errno);
+	param.manual_parameters.vcpu_fd = ioctl(param.manual_parameters.vm_fd, KVM_CREATE_VCPU, 0);
+	TEST_ASSERT(param.manual_parameters.vcpu_fd >= 0, "KVM_CREATE_VCPU failed (%d)", errno);
+
+	param.manual_parameters.vm_mem = aligned_alloc(SZ_1M, MEM_SIZE);
+	TEST_ASSERT(param.manual_parameters.vm_mem, "aligned_alloc failed (%d)", errno);
+
+	param.manual_parameters.map.user_addr = (uintptr_t)param.manual_parameters.vm_mem;
+	param.manual_parameters.map.vcpu_addr = 0;
+	param.manual_parameters.map.length = MEM_SIZE;
+	rc = ioctl(param.manual_parameters.vcpu_fd, KVM_S390_UCAS_MAP,
+		   &param.manual_parameters.map);
+	TEST_ASSERT(rc == 0, "KVM_S390_UCAS_MAP failed (%d)", errno);
+
+	rc = ioctl(param.manual_parameters.vcpu_fd, KVM_S390_VCPU_FAULT, (void *)0);
+	TEST_ASSERT(rc == 0, "KVM_S390_VCPU_FAULT failed (%d)", errno);
+
+	/* Copy guest code to physical GPA */
+	memcpy((void *)((uintptr_t)param.manual_parameters.vm_mem + CODE_GPA),
+	       param.guest_code, PAGE_SIZE);
+
+	/* Map kvm_run */
+	param.manual_parameters.run_size = ioctl(param.manual_parameters.kvm_fd,
+						 KVM_GET_VCPU_MMAP_SIZE, NULL);
+	TEST_ASSERT(param.manual_parameters.run_size >= (int)sizeof(struct kvm_run),
+		    "KVM_GET_VCPU_MMAP_SIZE returned (%d) expected >= %zu",
+		    param.manual_parameters.run_size, sizeof(struct kvm_run));
+	param.run = mmap(NULL, param.manual_parameters.run_size,
+			 PROT_READ | PROT_WRITE, MAP_SHARED,
+			 param.manual_parameters.vcpu_fd, 0);
+	TEST_ASSERT(param.run != MAP_FAILED, "mmap kvm_run failed (%d)", errno);
+
+	/* Map SIE block and clear STOPPED flag - required for ucontrol VMs */
+	param.manual_parameters.sie_block = mmap(NULL, PAGE_SIZE,
+						 PROT_READ | PROT_WRITE, MAP_SHARED,
+						 param.manual_parameters.vcpu_fd,
+						 KVM_S390_SIE_PAGE_OFFSET << PAGE_SHIFT);
+	TEST_ASSERT(param.manual_parameters.sie_block != MAP_FAILED,
+		    "mmap sie_block failed (%d)", errno);
+	param.manual_parameters.sie_block->cpuflags &= ~CPUSTAT_STOPPED;
+
+	/* DAT off + 64-bit mode; PSW address = physical code GPA */
+	param.run->psw_mask = PSW_MASK_64BIT_DAT_OFF;
+	param.run->psw_addr = CODE_GPA;
+	param.run->kvm_dirty_regs |= KVM_SYNC_ARCH0;
+
+	/* Point r15 at a valid guest stack below the code page */
+	param.run->s.regs.gprs[15] = CODE_GPA - 160;
+	param.run->kvm_dirty_regs |= KVM_SYNC_GPRS;
+
+	rc = ioctl(param.manual_parameters.vcpu_fd, KVM_RUN, NULL);
+	TEST_ASSERT(rc == 0, "KVM_RUN failed (%d)", errno);
+
+	return param;
+}
+
+static void manual_cleanup(struct kvm_parameters param)
+{
+	munmap(param.manual_parameters.sie_block, PAGE_SIZE);
+	munmap(param.run, param.manual_parameters.run_size);
+	close(param.manual_parameters.vcpu_fd);
+	close(param.manual_parameters.vm_fd);
+	close(param.manual_parameters.kvm_fd);
+	free(param.manual_parameters.vm_mem);
+}
+
+static bool ucontrol_available(void)
+{
+	struct __user_cap_data_struct data[_LINUX_CAPABILITY_U32S_3];
+	struct __user_cap_header_struct hdr = {
+		.version = _LINUX_CAPABILITY_VERSION_3,
+	};
+	int rc;
+
+	rc = capget(&hdr, data);
+	if (rc < 0)
+		return false;
+	if (!(data->effective & CAP_TO_MASK(CAP_SYS_ADMIN)))
+		return false;
+	return kvm_has_cap(KVM_CAP_S390_UCONTROL);
+}
+
 static void guestcode_instruction_intercept(void)
 {
 	asm volatile("diag 0,0, 0x500\n" :::);
@@ -378,6 +478,113 @@ static bool test_vm_create_and_destroy(void)
 	return true;
 }
 
+/* Tests below require KVM_CAP_S390_UCONTROL and are skipped if absent. */
+
+static void guestcode_system_information_calls(void)
+{
+	static uint8_t stsi_buf[4096] __aligned(4096);
+
+	register uint8_t *ptr asm("r1") = stsi_buf;
+
+	asm volatile(
+		"lghi %%r0, 0x0302\n"
+		"stsi 0(%%r1)\n"
+		:
+		: "d"(ptr)
+		: "r0", "memory"
+	);
+	GUEST_DONE();
+}
+
+static bool test_system_information_calls(void)
+{
+	struct kvm_parameters parameters = {
+		.guest_code = guestcode_system_information_calls,
+		.manual_parameters.immediate_exit_condition = false,
+	};
+
+	if (!ucontrol_available())
+		return false;
+
+	ksft_print_msg("Testing System Information Call Exits\n");
+
+	parameters = manual_kvm_creation_execution(parameters);
+
+	TEST_ASSERT(parameters.run->exit_reason == KVM_EXIT_S390_SIEIC,
+		    "Expected KVM_EXIT_S390_SIEIC, got %u\n", parameters.run->exit_reason);
+	TEST_ASSERT(parameters.run->s390_sieic.icptcode == ICPT_INST,
+		    "Failed with icptcode of 0x%x\n", parameters.run->s390_sieic.icptcode);
+	TEST_ASSERT(parameters.run->s390_sieic.ipa == STSI_IPA,
+		    "Expected STSI opcode 0xb27d, got 0x%x\n", parameters.run->s390_sieic.ipa);
+	manual_cleanup(parameters);
+	return true;
+}
+
+static void guestcode_tsch(void)
+{
+	register uint64_t buf asm("r2") = 0x3000;
+
+	asm volatile(
+		"lgfi  %%r1, 0x00010000\n"
+		"tsch  0(%%r2)\n"
+		:
+		: "d"(buf)
+		: "r1"
+	);
+}
+
+static void guestcode_stsch(void)
+{
+	register uint64_t buffer asm("r2") = 0x3000;
+
+	asm volatile(
+		"lgfi  %%r1, 0x00010000\n"
+		"stsch 0(%%r2)\n"
+		:
+		: "d"(buffer)
+		: "r1"
+	);
+}
+
+static const struct {
+	void (*guest_code)(void);
+	uint16_t expected_ipa;
+} io_tests[] = {
+	{guestcode_tsch, TSCH_IPA},
+	{guestcode_stsch, STSCH_IPA},
+};
+
+static bool test_io_instruction_code(void)
+{
+	int i;
+
+	if (!ucontrol_available())
+		return false;
+
+	ksft_print_msg("Testing IO Instruction Exit for TSCH and STSCH\n");
+	for (i = 0; i < ARRAY_SIZE(io_tests); i++) {
+		struct kvm_parameters parameter = {
+			.guest_code = io_tests[i].guest_code,
+			.manual_parameters.immediate_exit_condition = false,
+		};
+
+		parameter = manual_kvm_creation_execution(parameter);
+
+		TEST_ASSERT(parameter.run->exit_reason == KVM_EXIT_S390_SIEIC,
+			    "Expected KVM_EXIT_S390_SIEIC, got %u\n",
+			    parameter.run->exit_reason);
+		TEST_ASSERT(parameter.run->s390_sieic.icptcode == ICPT_INST,
+			    "Failed with icptcode of 0x%x\n",
+			    parameter.run->s390_sieic.icptcode);
+		TEST_ASSERT(parameter.run->s390_sieic.ipa == io_tests[i].expected_ipa,
+			    "Expected opcode 0x%x, got 0x%x\n",
+			    io_tests[i].expected_ipa,
+			    parameter.run->s390_sieic.ipa);
+		manual_cleanup(parameter);
+	}
+	return true;
+}
+
 static void test(void)
 {
 	int i;
@@ -414,6 +621,16 @@ static void test(void)
 			.name = "Testing VM Create and Destroy",
 			.test = test_vm_create_and_destroy,
 		},
+		{
+			.name = "Testing System Information Calls",
+			.test = test_system_information_calls,
+			.skip_reason = "KVM_CAP_S390_UCONTROL unavailable or insufficient privilege"
+		},
+		{
+			.name = "Testing IO Instruction Exits",
+			.test = test_io_instruction_code,
+			.skip_reason = "KVM_CAP_S390_UCONTROL unavailable or insufficient privilege"
+		},
 	};
 
 	ksft_print_header();
@@ -423,7 +640,8 @@ static void test(void)
 		if (testlist[i].test())
 			ksft_test_result_pass("%s\n", testlist[i].name);
 		else
-			ksft_test_result_skip("%s\n", testlist[i].name);
+			ksft_test_result_skip("%s (%s)\n", testlist[i].name,
+					      testlist[i].skip_reason ?: "unsupported");
 	}
 }
 
-- 
2.50.1 (Apple Git-155)

