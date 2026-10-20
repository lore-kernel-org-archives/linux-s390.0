Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506800;
	b=IhAWshgLXA1YC6NM6l/AHj1c17xLy/xrMyZOhA8ZuJB8OyGYTwPOvD6t+W+J494UB7Vo
	 qNXdig+mlYiVbvNUPSbtGRwBKoyakSt3dXm/Ns2q5MEtNwgonHLTKWHGDZ/T2cakW0pvA
	 /hcFXrmz7s6YKKMMFKFmkMOYsi56+L+bJVrOU8gttPpYtNJMSA+iSwJwaIK41uj9fSHb1
	 nZWaQPGGwlkm/twvHOWR+6TIBET/rCALAsfLw7Mj/MF2LpxNyRNqRjpTdXRoczDY6ml+y
	 kGuAcZsvLypv1t7zyUjmuFoeIkXGlULOvPhS4C4nmHCa/rZEchdCaj453vzgvcg73IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506800;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=KQb1UzLmSM3P9S0Qopm+woabLFiZrUIUlo8pXKzcQH8=;
	b=1KpfexoMKNv67AXpOPOA6FiH/MJucR5c1YH38qpjxLFXMQ5a6vZIp7uWEaHRl4j8vU6S
	 DVYe/1VoRlSu/xmooBcYNNd7NzJ3gjG2NA6mAB6RiyGXBbXYx0Pjn+txB2tbP+J6sPVem
	 0PnY5gXD/2JWMSwmIkZw7wfu5Nul0mB+T/Twg3I+v9gJ6oQTtUYdwEbTBljy7ZQS6C4dh
	 4yKs+c3IJnwj8I/5N2Lu8oDsgakyMIJeDkozn9BQfYyeskRz5MDyMV+bogaqEdIKaAig5
	 KQ5sOvEFQOjOvmxb/CA6H/YYh9O51LfLFTB6NX1XQ8zNEdcYgr0CKz1oVEsSkpqecUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JTE6Ddcx;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1FB606A31D;
	Tue, 20 Oct 2026 14:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E1FB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JTE6Ddcx
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDEBqu2568614;
	Tue, 20 Oct 2026 14:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KQb1UzLmSM3P9S0Qo
	pm+woabLFiZrUIUlo8pXKzcQH8=; b=JTE6DdcxlhA+Yt9eRjUUWwjCYhj3PQtgl
	zWQ8lpvh2A6Dm0IuROxDN6TvFh9LMsVsbsRauj7S4hdB4leGEdnVDPh0aghSBJCu
	U4UjF9+N37JipU8k1X/E4/wT08Bh9SjIo/ZTJnM830IAxtP+As3JNG04gRgMX0Hh
	N3KLWnTjpFz+uqcYg6aHbdJMj7r/kTUWDgs845VL1IcL8RlpuvBz8hZIeCWYmpnh
	QeS1RQS8fyI8cDfFC47XzAwtDFL1LEBTYWhXa7FJNC2X950zDniD85TUtd4jppkM
	WJFfeIWUvkmfOo6BXDSsNFxFcNC7/hhsN06orVhQUiLJ1mxsd33vw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw59u8me-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 14:33:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDJsgG1501031;
	Tue, 20 Oct 2026 14:33:15 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bs0kmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 14:33:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69KEXED632572152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 14:33:14 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2618458065;
	Tue, 20 Oct 2026 14:33:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B73505805E;
	Tue, 20 Oct 2026 14:33:12 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 14:33:12 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc: KVM <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH 2/2] KVM: selftests: Test that KVM_RUN fails for unresolvable host faults
Date: Tue, 20 Oct 2026 16:33:08 +0200
Message-ID: <20261020143308.228328-3-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020143308.228328-1-borntraeger@linux.ibm.com>
References: <20261020143308.228328-1-borntraeger@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfXzPPjm5YkPcLv
 Kk/9NTBIRtx8tjn+9oEc0aLpnPxkCY8ysTuyBCxeXdOPkVmRIveXEab7Ioflt0jQELV4WqFITPw
 tRsZQCkV2tHHxxU0ti/2VDbu5jghsdx1a0gobNIV3zbFlvDeeFD3A/u13uWKtX5iEF96pcG2iOS
 bVONtQYas0Qy58Qw8Q8MDO6AYskXpMmSCHTaPAZiyupFXL7xDdj028QwwQj8GbbKSKRCWHf/Mrj
 7VOMddTnXhA+lZ7qnL35BFNnpX3xJSrvvU8CmgMSCke3554nqL+//+16pqAgvxN0Vwqg73iPri5
 irlh5dpYmRA1UftDMDOKuxnBDAwgN3442KuAUhzMmT04nmhHCERWCDY6NIpzKNNsX0dg5VTqap6
 stLYr4QOTqgHGEPiU7NHK0XXU4SD9pkEu2BLQNO1qoyE3fuLVZaaDuYningbyRNumtFqNAKQQtq
 NYJFtRrhxUpWgI6xaOQ==
X-Proofpoint-ORIG-GUID: VVdIEu3EBdGoe2Afi9M5-_1whCJUkEYE
X-Proofpoint-GUID: MGI4jXDt3mDIP2eNYf-V4r4GZkq2eR_i
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfX7dRlvZC35a0n
 LpB3oBLxoSvie4MoOVu3n0+wn3hDRRiLjx+ORtFGJvGUxh7fTf90owCdmeYRLhBYhZ+duuF6vNf
 WUtGGgyiK+VE8hlmCauFPWRDjVNQars=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad77bac cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=uAgpx_3mnM5J1oN4MSkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200056

Add a test in which the guest writes to a shmem-backed memslot beyond
the end of the file.  KVM_RUN must fail with -EFAULT.

On x86 the guest enables interrupts, and on s390 the test sets up
pfault, so that KVM could handle the fault with an asynchronous page
fault.  If KVM mistakes the error for a fault that needs I/O, the vCPU
retries the access forever, and the test fails after a timeout.

The test is not built for LoongArch, which handles a failed mapping as
an MMIO access.

Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/faultin_sigbus_test.c       | 168 ++++++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/faultin_sigbus_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 68bcec3d0070..24fdfc3e0eba 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -59,6 +59,7 @@ TEST_PROGS_x86 += x86/nx_huge_pages_test.sh
 # Compiled test targets valid on all architectures with libkvm support
 TEST_GEN_PROGS_COMMON = demand_paging_test
 TEST_GEN_PROGS_COMMON += dirty_log_test
+TEST_GEN_PROGS_COMMON += faultin_sigbus_test
 TEST_GEN_PROGS_COMMON += guest_print_test
 TEST_GEN_PROGS_COMMON += irqfd_test
 TEST_GEN_PROGS_COMMON += kvm_binary_stats_test
diff --git a/tools/testing/selftests/kvm/faultin_sigbus_test.c b/tools/testing/selftests/kvm/faultin_sigbus_test.c
new file mode 100644
index 000000000000..b9d673260ed5
--- /dev/null
+++ b/tools/testing/selftests/kvm/faultin_sigbus_test.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * A guest access to memory whose host mapping cannot be faulted in (here: a
+ * shmem page beyond EOF, i.e. SIGBUS) must make KVM_RUN fail with -EFAULT.
+ *
+ * On architectures with asynchronous page faults, KVM first tries to fault
+ * the page in without waiting (FOLL_NOWAIT) and hands the fault to a worker
+ * if that would need I/O.  The error must not be mistaken for "needs I/O",
+ * otherwise the vCPU retries the access forever and KVM_RUN never returns.
+ * The architecture hooks below make sure that the async path is actually
+ * possible, i.e. that the error would be misclassified if KVM got it wrong.
+ */
+#include <signal.h>
+#include <unistd.h>
+#include <linux/sizes.h>
+#include <linux/stringify.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+#include "ucall_common.h"
+
+#define TEST_SLOT	10
+#define TEST_SIZE	SZ_1M
+#define TIMEOUT_SECS	10
+
+#ifdef __s390x__
+#define __LC_EXT_NEW_PSW		0x1b0
+#define __LC_SAVED_PSW			0x200	/* free for the OS */
+#define __LC_WAIT_PSW			0x210	/* free for the OS */
+#define PSW_MASK_EXT			0x0100000000000000ULL
+#define PSW_MASK_DAT			0x0400000000000000ULL
+#define PSW_MASK_WAIT			0x0002000000000000ULL
+#define CR0_SERVICE_SIGNAL_SUBMASK	BIT_ULL(63 - 54)
+
+/*
+ * Handle pfault like Linux does: on the init interrupt (ext cpu address
+ * 0x0600) remember the interrupted PSW and wait until the done interrupt
+ * (0x0680), then retry the access.  A guest that retried at once would
+ * fill up KVM's queue of async page faults and get the synchronous fault
+ * path.  Runs with DAT off, so lowcore is addressed by real addresses:
+ * 0x84 is the ext cpu address, 0x130 the ext old PSW.  Done differs from
+ * init only in bit 0x80 of 0x85, test it like Linux tests PF_COMPLETE.
+ */
+extern char ext_int_handler[];
+asm(".pushsection .text\n"
+	"ext_int_handler:\n"
+	"	tm	0x85,0x80\n"
+	"	jo	1f\n"
+	"	mvc	" __stringify(__LC_SAVED_PSW) "(16),0x130\n"
+	"	lpswe	" __stringify(__LC_WAIT_PSW) "\n"
+	"1:	lpswe	" __stringify(__LC_SAVED_PSW) "\n"
+	".popsection\n");
+
+static void arch_enable_async_pf(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	u64 *lowcore = addr_gpa2hva(vm, 0);
+	struct kvm_sregs sregs;
+	gva_t token_gva;
+	gpa_t handler;
+	int flic;
+
+	flic = kvm_create_device(vm, KVM_DEV_TYPE_FLIC);
+	kvm_device_attr_set(flic, KVM_DEV_FLIC_APF_ENABLE, 0, NULL);
+
+	/* The DIAG 0x258 handshake, with masks that match any guest PSW. */
+	token_gva = vm_alloc_page(vm);
+	vcpu_set_reg(vcpu, KVM_REG_S390_PFTOKEN, addr_gva2gpa(vm, token_gva));
+	vcpu_set_reg(vcpu, KVM_REG_S390_PFSELECT, 0);
+	vcpu_set_reg(vcpu, KVM_REG_S390_PFCOMPARE, 0);
+
+	vcpu_sregs_get(vcpu, &sregs);
+	sregs.crs[0] |= CR0_SERVICE_SIGNAL_SUBMASK;
+	vcpu_sregs_set(vcpu, &sregs);
+	vcpu->run->psw_mask |= PSW_MASK_EXT;
+
+	handler = addr_gva2gpa(vm, (gva_t)ext_int_handler);
+	lowcore[__LC_EXT_NEW_PSW / 8] = vcpu->run->psw_mask &
+					~(PSW_MASK_EXT | PSW_MASK_DAT);
+	lowcore[__LC_EXT_NEW_PSW / 8 + 1] = handler;
+	lowcore[__LC_WAIT_PSW / 8] = (vcpu->run->psw_mask & ~PSW_MASK_DAT) |
+				     PSW_MASK_WAIT;
+	lowcore[__LC_WAIT_PSW / 8 + 1] = handler;
+}
+#else
+/* x86 needs guest interrupts on, see guest_code(); nothing to do elsewhere. */
+static void arch_enable_async_pf(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+}
+#endif
+
+static void guest_code(u64 gva, u64 size)
+{
+#ifdef __x86_64__
+	/* KVM does async #PF, or its halt fallback, only with IRQs enabled. */
+	sti_nop();
+#endif
+	/* Within EOF: must work, proves that the mapping is set up right. */
+	WRITE_ONCE(*(u64 *)gva, 1);
+	GUEST_SYNC(0);
+
+	/* Beyond EOF: KVM_RUN must fail with -EFAULT. */
+	WRITE_ONCE(*(u64 *)(gva + size - sizeof(u64)), 1);
+	GUEST_FAIL("Store beyond EOF succeeded");
+}
+
+static void sig_alarm(int sig)
+{
+}
+
+int main(void)
+{
+	struct sigaction sa = { .sa_handler = sig_alarm };	/* no SA_RESTART */
+	struct userspace_mem_region *region;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	gpa_t gpa;
+	gva_t gva;
+	u64 npages;
+	int r;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	/* After slot 0 and the page that some architectures use for ucalls. */
+	region = memslot2region(vm, 0);
+	gpa = align_up(region->region.guest_phys_addr +
+		       region->region.memory_size + vm->page_size, TEST_SIZE);
+	npages = TEST_SIZE / vm->page_size;
+
+	vm_mem_add(vm, VM_MEM_SRC_SHMEM, gpa, TEST_SLOT, npages, 0, -1, 0);
+	region = memslot2region(vm, TEST_SLOT);
+	/* Only the first host page is backed, everything behind it is SIGBUS. */
+	TEST_ASSERT(!ftruncate(region->fd, getpagesize()), "ftruncate() failed");
+
+	gva = vm_unused_gva_gap(vm, TEST_SIZE, KVM_UTIL_MIN_VADDR);
+	virt_map(vm, gva, gpa, npages);
+	vcpu_args_set(vcpu, 2, gva, TEST_SIZE);
+
+	arch_enable_async_pf(vm, vcpu);
+
+	vcpu_run(vcpu);
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_SYNC:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	default:
+		TEST_FAIL("Unexpected ucall %lu", uc.cmd);
+	}
+	TEST_ASSERT_EQ(*(u64 *)region->host_mem, 1);
+
+	TEST_ASSERT(!sigaction(SIGALRM, &sa, NULL), "sigaction() failed");
+	alarm(TIMEOUT_SECS);
+	r = __vcpu_run(vcpu);
+	alarm(0);
+
+	TEST_ASSERT(!(r == -1 && errno == EINTR),
+		    "KVM_RUN did not return within %d seconds: the fault on the SIGBUS page is retried forever",
+		    TIMEOUT_SECS);
+	TEST_ASSERT(r == -1 && errno == EFAULT,
+		    "Expected KVM_RUN to fail with EFAULT, got r = %d, errno = %d (%s), exit reason %s",
+		    r, errno, strerror(errno), exit_reason_str(vcpu->run->exit_reason));
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.53.0

