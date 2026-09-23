Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DFD53A394;
	Wed, 23 Sep 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176610; cv=none; b=X5ZQNcDcAQh56tjxZYTCq5tzjf1owStHUw46rQ7vuz9wdOBxOc00sG0UNuNIoCu++xbMATE3TBBXpo/vbGuiJr1TtUQnGzdWK/B6AxqO+KNvfTZNRRzrKmn8ixdcYAv0UPsB84Igd8guhKXTiB5EslmQMb9L8FaxdQmuJHHib2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176610; c=relaxed/simple;
	bh=HPdImb64PDH+ZisiIURUzc+NKXAVj6r6zQyPTld8vVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Amw/t6eEqueIEbfFGyXz7N/9x1n1DTx0eXw2ECo8qEKKlGstrFBRgN7pU173JhK9HqZAy7XhsY+HYzJcLN8BDp4E4arBZPxBMsKJji41VUxU/xXCJSuIwB4fgvcSpgjLu6hdv7ByWpr6RpbJaeewGu4zbBvQzVzIT63ljBpf8ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdFRwP5s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdFRwP5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A1F1F00898;
	Wed, 23 Sep 2026 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790176608;
	bh=W+dJkKEhYPFMGXFWM/cPd6V0/H5s5A3iRfAUA4bwjj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kdFRwP5s8fVUrzsN7JG9nbI6GTzKbPoDf5DJVzuYtuZc/3IW0nQNJVpA9wnq3BBuJ
	 nOJ05C6XrZpTt3QSTJcLbra5L9EPYuEaP5vJzxYo4AT5dOas40Io8ingK8iy5uAws7
	 mdYacwVj7Ktxns/ZWT7sXBS7Wxb6io50KhdEcQkXSm70+zfKBnY15qt3OTDO8ariSt
	 hM6ZcS0t494fUeo0gAJZxSVgy8OJ+dDcgH5q7uFSMyxtFMJ1o5bx6TB3V4abl5o8JV
	 0BbBeeTm+p/e7RQn6Y/HT7RDRc/BXBFgvfmxbBqhn3ryinquGIxnzS6X0y5WJ/Wocg
	 VdWRYbvQuuGTQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 23 Sep 2026 16:15:47 +0100
Subject: [PATCH v4 04/14] KVM: arm64: Propagate and use esr in s2fd when
 handling guest aborts
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-kvm-arm-prefault-v4-4-d4b0b4dfa8c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2936; i=ljs@kernel.org;
 h=from:subject:message-id; bh=HPdImb64PDH+ZisiIURUzc+NKXAVj6r6zQyPTld8vVQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI2v9Up21Dh/iAt98qBbykmG4/ci2sXjn239Eyr7jrzp
 9kXSgt3d5SyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiSpKMDIvbV6q9uWjYU+n+
 8trM4Jd8dgZmS5etSNeLS8xp+srxbCHDf38b1SuTjqsp6M+QEs1dJ/jgmMP2K1rO213/ixf8FX4
 dxAUA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

kvm_handle_guest_abort() establishes a kvm_s2_fault_desc data structure,
s2fd, to store and propagate state to either pkvm_mem_abort(), gmem_abort()
or user_mem_abort() handlers.

Each of these, however, examines the Exception Syndrome Register (ESR) via
s2fd->vcpu.

Introduce an s2fd->esr field to abstract this and propagate it to callers.

The value of this (beyond refactoring) is to be able to later generate
faults with a synthetic esr, specifically to implement stage 2 page table
pre-faulting.

Abort handlers which use kvm_s2_fault_desc - gmem_abort() and
user_mem_abort() - now only reference s2fd->esr and do not look it up in
any other way, which makes it safe to pass a synthetic s2fd->esr value to
these functions.

No functional change intended.

Reviewed-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/arm64/kvm/mmu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 5e10a4cd31ea..cb677ab76484 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1655,21 +1655,22 @@ struct kvm_s2_fault_desc {
 	struct kvm_s2_trans	*nested;
 	struct kvm_memory_slot	*memslot;
 	unsigned long		hva;
+	unsigned long		esr;
 };
 
 static bool kvm_s2_fault_is_perm(const struct kvm_s2_fault_desc *s2fd)
 {
-	return esr_fsc_is_permission_fault(kvm_vcpu_get_esr(s2fd->vcpu));
+	return esr_fsc_is_permission_fault(s2fd->esr);
 }
 
 static bool kvm_s2_fault_is_exec(const struct kvm_s2_fault_desc *s2fd)
 {
-	return esr_abt_is_exec_fault(kvm_vcpu_get_esr(s2fd->vcpu));
+	return esr_abt_is_exec_fault(s2fd->esr);
 }
 
 static bool kvm_s2_fault_is_write(const struct kvm_s2_fault_desc *s2fd)
 {
-	return esr_abt_is_write_fault(kvm_vcpu_get_esr(s2fd->vcpu));
+	return esr_abt_is_write_fault(s2fd->esr);
 }
 
 static u64 kvm_s2_perm_fault_granule(const struct kvm_s2_fault_desc *s2fd)
@@ -1678,7 +1679,7 @@ static u64 kvm_s2_perm_fault_granule(const struct kvm_s2_fault_desc *s2fd)
 
 	if (!kvm_s2_fault_is_perm(s2fd))
 		return 0;
-	level = kvm_vcpu_get_esr(s2fd->vcpu) & ESR_ELx_FSC_LEVEL;
+	level = s2fd->esr & ESR_ELx_FSC_LEVEL;
 	return BIT(ARM64_HW_PGTABLE_LEVEL_SHIFT(level));
 }
 
@@ -2067,7 +2068,7 @@ static int kvm_s2_fault_compute_prot(const struct kvm_s2_fault_desc *s2fd,
 	 * and trigger the exception here. Since the memslot is valid, inject
 	 * the fault back to the guest.
 	 */
-	if (esr_fsc_is_excl_atomic_fault(kvm_vcpu_get_esr(s2fd->vcpu))) {
+	if (esr_fsc_is_excl_atomic_fault(s2fd->esr)) {
 		kvm_inject_dabt_excl_atomic(s2fd->vcpu, kvm_vcpu_get_hfar(s2fd->vcpu));
 		return 1;
 	}
@@ -2518,6 +2519,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 		.nested		= nested,
 		.memslot	= memslot,
 		.hva		= hva,
+		.esr		= esr,
 	};
 
 	if (kvm_vm_is_protected(vcpu->kvm)) {

-- 
2.55.0

