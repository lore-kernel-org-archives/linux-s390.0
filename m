Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0075326BA;
	Wed, 23 Sep 2026 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176711; cv=none; b=owLfqacsrStA77++uuoHOTpAPCLJ2krkx+JCh0vFC93GiLixVx9yI0pk2OPq2nvbqb97LSwxBcD5jWZZoJ2W0tYlpxqT9X98eYhK1CF6VbLuDSizOTNoia/LlYgzklgVVgusyPmyS98ELxUTlDFHgPJ4PrajVAuSF0a3ZT0B4Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176711; c=relaxed/simple;
	bh=pwb7m+JMMGFK4QoLwOuaaWYCgLb/P2i+Xk183VYpbVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kLQ7qaIHGIUIFPqzLhTqrQY31nIRhrOmOeh9LcCp0h564Iezl+4e3tb/tYkaTxEXxXSZ/Ue7PaY9OYxm4V+m99fOb6/DClBXNEON5S8kK4WHTMGCYTSNiQq3ekDaA2KcqE9RqjICWgtnsM3LP8AAyIds2PsWo86GXGbaHLjhknE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv4b806C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv4b806C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4081F000FF;
	Wed, 23 Sep 2026 15:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790176709;
	bh=2v2YbnomS/etrByxgWkxWrN53HyS63O9T0c7UVuhAyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Dv4b806CkmaaHhNR9TRuhkpGRbDT7e5eYdRSipKhGHchC2aAH9hYB9J/4pF+cgqvQ
	 3bY6ceK1JTpQLylvXOfunBzU+Lif7OU+INhh9VBuTt6+L+pZBgkZSZNglTrHmV2bqT
	 pcUL49TT3FokIsukH+LccEzymLJGQ7OKTkfge2waFHgtwS+TkHpHmzL+zXHY9de6F8
	 V5QEPPE0FzOTdPrH/QzwBNqnGTnrp/LpyIJRBMBM1VrjrBjh+2p50u8xTG+swxwzeb
	 H0S8CgrUNLso3EuMDSz/1AV5Qvx9rcf4Q3qsyjAWJ8lPwYMlBijgixo7ISSZoEDFZF
	 6ttl+gezHTJdQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 23 Sep 2026 16:15:57 +0100
Subject: [PATCH v4 14/14] KVM: selftests: Add nested pre-fault test for
 arm64
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-kvm-arm-prefault-v4-14-d4b0b4dfa8c3@kernel.org>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
In-Reply-To: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Randy Dunlap <rdunlap@infradead.org>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jack Thomson <jackabt@amazon.com>, 
 Jack Thomson <jackabt.amazon@gmail.com>, 
 Alexandru Elisei <alexandru.elisei@arm.com>, 
 Vincent Donnefort <vdonnefort@google.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Sean Christopherson <seanjc@google.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Leo Soares Passos <Leo.Bras@arm.com>, Wei-Lin Chang <weilin.chang@arm.com>, 
 linux-s390@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6362; i=ljs@kernel.org;
 h=from:subject:message-id; bh=pwb7m+JMMGFK4QoLwOuaaWYCgLb/P2i+Xk183VYpbVo=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI2v9XLOH502VOXR6f+X2XXarc54z5LtFc47lJl5dY6q
 Rs6E8ybOkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCR1OkM/2td7brP+jLsfr4l
 4G6Fi62FqEG0hmhgYdSCn04OgVVqBxkZeqVS5sc9dTfROfEmtWPpnk9n2pz+Myz439X4KeF45fV
 ILgA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Add an arm64 nested-virtualisation selftest for KVM_PRE_FAULT_MEMORY.

The guest enters vEL2, sets up its EL2 translation configuration into the
real EL1 registers then ERETs to vEL1 and exits to userspace so its vCPU
last-run context is nested backed by a shadow stage 2 MMU.

The test then asserts that pre-faulting ignores that and instead targets
the canonical stage 2 page tables only.

Userspace cannot observe a mistargeted pre-fault, so simply assert that the
pre-faulting works correctly when the last-run context was nested.

Based on a patch by Jack Thomson with gratitude. The test here is
simplified and focused on what can be asserted.

Link: https://lore.kernel.org/kvmarm/20260612162354.73378-6-jackabt.amazon@gmail.com/
Reviewed-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 .../selftests/kvm/arm64/nv_pre_fault_memory_test.c | 158 +++++++++++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 874ff9097384..908bdc7cf4f5 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -178,6 +178,7 @@ TEST_GEN_PROGS_arm64 += arm64/debug-exceptions
 TEST_GEN_PROGS_arm64 += arm64/hello_el2
 TEST_GEN_PROGS_arm64 += arm64/host_sve
 TEST_GEN_PROGS_arm64 += arm64/hypercalls
+TEST_GEN_PROGS_arm64 += arm64/nv_pre_fault_memory_test
 TEST_GEN_PROGS_arm64 += arm64/external_aborts
 TEST_GEN_PROGS_arm64 += arm64/mmio_sign_ext
 TEST_GEN_PROGS_arm64 += arm64/page_fault_test
diff --git a/tools/testing/selftests/kvm/arm64/nv_pre_fault_memory_test.c b/tools/testing/selftests/kvm/arm64/nv_pre_fault_memory_test.c
new file mode 100644
index 000000000000..09c1db303856
--- /dev/null
+++ b/tools/testing/selftests/kvm/arm64/nv_pre_fault_memory_test.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nv_pre_fault_memory_test - Test KVM_PRE_FAULT_MEMORY on a vCPU whose
+ * last-run context is nested.
+ *
+ * The guest enters vEL2, sets up its EL2 translation configuration into the
+ * real EL1 registers then ERETs to vEL1 and exits to userspace so its vCPU
+ * last-run context is nested backed by a shadow stage 2 MMU.
+ *
+ * Assert that pre-faulting ignores that and targets the canonical stage-2
+ * page tables only.
+ */
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+#include "ucall.h"
+
+#include <asm/sysreg.h>
+#include <linux/sizes.h>
+
+#define TEST_MEM_SLOT		10
+#define TEST_MEM_SIZE		SZ_2M
+#define TEST_MEM_GPA		SZ_1G
+
+static void guest_el1_code(void)
+{
+	u64 offset;
+
+	GUEST_ASSERT_EQ(get_current_el(), 1);
+
+	/* Exit to userspace with the vEL1 (nested) context live. */
+	GUEST_SYNC(1);
+
+	/*
+	 * Touch the prefaulted range. vstage-2 is disabled, so the shadow
+	 * stage-2 is a 1:1 view of the canonical IPA space.
+	 */
+	for (offset = 0; offset < TEST_MEM_SIZE; offset += SZ_4K)
+		READ_ONCE(*(u64 *)(TEST_MEM_GPA + offset));
+
+	GUEST_DONE();
+}
+
+static void guest_code(void)
+{
+	u64 sp;
+
+	GUEST_ASSERT_EQ(get_current_el(), 2);
+
+	/*
+	 * Mirror the EL2 translation regime into the real EL1 registers so
+	 * that vEL1 runs on the test's stage-1 page tables. With E2H=1, the
+	 * _EL1 accessors read the EL2 registers, and the _EL12 accessors
+	 * write the real EL1 registers.
+	 */
+	write_sysreg_s(read_sysreg(sctlr_el1), SYS_SCTLR_EL12);
+	write_sysreg_s(read_sysreg(tcr_el1), SYS_TCR_EL12);
+	write_sysreg_s(read_sysreg(ttbr0_el1), SYS_TTBR0_EL12);
+	write_sysreg_s(read_sysreg(mair_el1), SYS_MAIR_EL12);
+	write_sysreg_s(read_sysreg(cpacr_el1), SYS_CPACR_EL12);
+
+	/* Run vEL1 on the same stack. */
+	asm volatile("mov %0, sp" : "=r"(sp));
+	write_sysreg(sp, sp_el1);
+
+	/*
+	 * Drop TGE so that vEL1 is a nested context rather than host EL0.
+	 * KVM backs it with a shadow stage-2 MMU even though vstage-2 is
+	 * disabled (HCR_EL2.VM=0).
+	 */
+	write_sysreg(read_sysreg(hcr_el2) & ~HCR_EL2_TGE, hcr_el2);
+	isb();
+
+	write_sysreg(PSR_MODE_EL1h | PSR_F_BIT | PSR_I_BIT | PSR_A_BIT |
+		     PSR_D_BIT, spsr_el2);
+	write_sysreg((u64)guest_el1_code, elr_el2);
+	asm volatile("eret");
+
+	GUEST_ASSERT(false);
+}
+
+static void pre_fault(struct kvm_vcpu *vcpu, u64 gpa, u64 size)
+{
+	struct kvm_pre_fault_memory range = {
+		.gpa = gpa,
+		.size = size,
+	};
+	int ret;
+
+	do {
+		ret = __vcpu_ioctl(vcpu, KVM_PRE_FAULT_MEMORY, &range);
+	} while ((!ret && range.size) ||
+		 (ret < 0 && (errno == EINTR || errno == EAGAIN)));
+
+	TEST_ASSERT(!ret, "KVM_PRE_FAULT_MEMORY failed, ret: %d errno: %d",
+		    ret, errno);
+	TEST_ASSERT_EQ(range.size, 0);
+}
+
+int main(void)
+{
+	struct kvm_vcpu_init init;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	u64 npages;
+
+	TEST_REQUIRE(test_supports_el2());
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_PRE_FAULT_MEMORY));
+
+	vm = vm_create(1);
+
+	kvm_get_default_vcpu_target(vm, &init);
+	init.features[0] |= BIT(KVM_ARM_VCPU_HAS_EL2);
+	vcpu = aarch64_vcpu_add(vm, 0, &init, guest_code);
+	kvm_arch_vm_finalize_vcpus(vm);
+
+	npages = TEST_MEM_SIZE / vm->page_size;
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, TEST_MEM_GPA,
+				    TEST_MEM_SLOT, npages, 0);
+	virt_map(vm, TEST_MEM_GPA, TEST_MEM_GPA, npages);
+
+	/* Run the guest until it has ERET'd from vEL2 to vEL1. */
+	vcpu_run(vcpu);
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_SYNC:
+		TEST_ASSERT_EQ(uc.args[1], 1);
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	default:
+		TEST_FAIL("Unhandled ucall: %ld", uc.cmd);
+	}
+
+	/*
+	 * The vCPU's last-run context is vEL1, so its hw_mmu is a shadow
+	 * stage-2 MMU.
+	 *
+	 * Pre-faulting must ignore that and populate the canonical stage-2.
+	 */
+	pre_fault(vcpu, TEST_MEM_GPA, TEST_MEM_SIZE);
+
+	/* Resume at vEL1 and touch the prefaulted range. */
+	vcpu_run(vcpu);
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_DONE:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	default:
+		TEST_FAIL("Unhandled ucall: %ld", uc.cmd);
+	}
+
+	kvm_vm_free(vm);
+	return 0;
+}

-- 
2.55.0

