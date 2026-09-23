Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2721A53A89D;
	Wed, 23 Sep 2026 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176570; cv=none; b=reAaz34kFgsZp8E7OSPir7Wxgx3up5yXugdcXLi5jgL4fCvzzPoNLuUqvCEodS6XffrY8H9Ipz5j41K6KvBbkhpmegTv22UaAGt4Xzrl1pMjvqGWvXXivtegWJ+myin57IF2WypY8bWWmEYoqLs3iPR8DYMJUBbHo+rVM/aWkBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176570; c=relaxed/simple;
	bh=GYWfUnTkP0gJvKMOUL5QKcvgb16vDu9ahPAgFk+I10Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N71gEIwrNQ/nHIdBLYnJeCeGkaxA5wfFZzN+oA4Mefn/81ovad8SwGFQT3pusHyNDZuXTcntMp6/cfVe83Te/Xhk+0GZeYOeRw1WmQPYL2M1nY7YLP8fZSN2zt6NVxwdkbYHCcaMPy3TNVA7+74B+7ZGMp1epmhHyPdcBeFJAgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6ycILeq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6ycILeq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5FC1F000FF;
	Wed, 23 Sep 2026 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790176568;
	bh=uhiHK1xeWjLCIGW0E7V8+Nj+NJaq2mGJkeRGTcZrb+o=;
	h=From:Subject:Date:To:Cc;
	b=M6ycILeqX2bnA28NGWauthBqCcvcc+tcb8zJK7Ndba5O+RSX0CtL5D5yFN5w/mVzj
	 k+wUHP6VuKf51xLT4IHwBLKQrgvYkrTruJv8l2XMpIOGFNFxiiV2moX2rcym3hWbsj
	 KRkEjZmyUTN/M6+mRXqGFes3H9GGEFiNCYfAxotRimDrjKLs6hDQsiQ/AcSYfVRoP4
	 vc9tgtCgOjIl1G4WN+B+qMUNB1nDYUmFcLYhdJh4567CB1Rs0ZtDzeLZ+1fvpapfp5
	 rlFuNFzQuMYTTssAJzEohJsA2t8LyHh+T60VgqM5Z3OLTd2x6YzgRCoUh0JZAHZ0PQ
	 a2jOKWz0NBE6A==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH v4 00/14] KVM: arm64: Add KVM_PRE_FAULT_MEMORY support
Date: Wed, 23 Sep 2026 16:15:43 +0100
Message-Id: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NwQ6CMAyA4VchOzvDuknBk+9hPDDoYAHBDFw0h
 Hd3EBM1cvzb9OvEBnKWBnaMJubI28H2XQi1i1hR511F3JahGcSQxKk48MZfee6u/ObI5Pd25Jn
 WSgidpBmWLJwtC/tYyfMldG2HsXfP9YMXy/SNwQbmBY+5JkNpphBjoFNDrqN237uKLZqHj5AJt
 SFAECAxWqFBpVH+CfJLANgQZBAwRV1KXSBJ8yPM8/wCvukZ6zUBAAA=
X-Change-ID: 20260815-kvm-arm-prefault-9bb411b6897d
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9264; i=ljs@kernel.org;
 h=from:subject:message-id; bh=GYWfUnTkP0gJvKMOUL5QKcvgb16vDu9ahPAgFk+I10Q=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI2v9Xhmbk3oeyYjrxGw5V2a4XDC2ZHqqg4B35oiJTNf
 mNXpJnUUcrCIMbFICumyPL8i/j+IJGweZ0X/N1g5rAygQxh4OIUgIl4CjIyXD65xFPafGtM4PJT
 c8t3zZtx3XO95qXKttJ/htP4ZOzcZRgZFto/F0/YHJf45JOmjMJzl/mX27/99nv3/8/XFd4Owo0
 sPAA=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

This series implements the KVM stage 2 page table pre-faulting feature for
arm64.

== Foundations ==

1. Providing a generic kvm_arch_pre_fault_allowed() hook.

This allows arm64 to reject an uninitialised vCPU from being specified on
pre-fault, avoiding loading a vCPU that is not correctly initialised yet.

2. Updating kvm_s2_fault_desc to independently store the exception syndrome
   register (ESR) value, and updating all code paths to use this value
   exclusively.

This is needed so we can later generate a synthetic fault to perform the
pre-faulting - we need to be sure the code doesn't grab an incorrect ESR
from elsewhere.

3. Updating kvm_s2_fault_desc to independently store the kvm_s2_mmu and
   updating all code paths to use this value exclusively.

Similarly this is needed so we can generate a synthetic fault against the
canonical stage 2 MMU (it would make no sense for it to touch nested shadow
page tables) - we need to be sure that the code doesn't grab an incorrect
MMU from elsewhere.

4. Updating the abort paths which consume kvm_s2_fault_desc to also return
   a kvm_s2_fault_result data structure.

To perform pre-faulting the code must know the granule size of what was
just walked. So the abort paths have to tell us what that was.

5. Pass walk flags to kvm_pgtable_get_leaf() to permit walking page tables
   under the MMU read lock.

This is Jack's patch which allows the use of the KVM_PGTABLE_WALK_SHARED
flag to walk page tables under the MMU read lock.

Pre-faulting requires it to be able to work in parallel as specified by the
API. The read lock precludes page tables being torn down behind our back.

== Implementation ==

Pre-faulting is implemented in kvm_arch_vcpu_pre_fault_memory() whose job
is to pre-fault the stage 2 page tables which map a specific GPA (which,
for arm64, is the guest's IPA).

This function is called by kvm_vcpu_pre_fault_memory() for each GPA in the
range, which itself is ultimately invoked by userland via the
KVM_PRE_FAULT_MEMORY ioctl.

The implementation is simple - try to walk to the stage 2 page table
mapping the GPA - if unmapped, fault it in through a synthetic page fault.

pKVM is not supported regardless of whether the VM is protected or
not.

This is because pKVM instantiates vCPUs upon run, but pre-faulting is
typically performed before a vCPU is run. It would be confusing and
inconsistent to error out on non-running vCPUs but to pre-fault running
ones.

Additionally, in pKVM mode, the stage 2 page tables are owned by the
hypervisor rather than the host - the host can neither walk them nor
populate them directly, so it's not clear that the pre-fault mechanism
correctly maps onto pKVM.

== Credits ==

This series is based, with gratitude, on Jack Thomson's series and their
respins (links provided below) as well as the feedback he received.

The series includes Jack's v5 "KVM: arm64: Pass walk flags to
kvm_pgtable_get_leaf()" patch (verbatim bar a one-line rebase fixup) and
two of his test patches (with minor fixups), plus a nested pre-fault test
based on his.

Link: https://patch.msgid.link/20260612162354.73378-1-jackabt.amazon@gmail.com/
Link: https://patch.msgid.link/20260113152643.18858-1-jackabt.amazon@gmail.com/
Link: https://patch.msgid.link/20251119154910.97716-1-jackabt.amazon@gmail.com/
Link: https://patch.msgid.link/20251013151502.6679-1-jackabt.amazon@gmail.com/
Link: https://patch.msgid.link/20250911134648.58945-1-jackabt.amazon@gmail.com/

== Reviewer Notes ==

I synced with maintainers on this who asked me to take a look, as there hadn't
been progress on the series for some time.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
v4:
* Added tags, thank you everybody! (dropped Oliver's from 1/14 as new code,
  and Fuad's Tested-by tags as he hasn't tested the latest version yet).
* Reworked patch 1/14 to implement kvm_arch_pre_fault_allowed() to return
  an error number and added x86, s390 implementations, as per Oliver.
* Made implementing kvm_arch_pre_fault_allowed() a requirement in 1/14 if
  pre-fault enabled for arches, as per Sean.
* Updated 2/14 to move esr_abt_is_s1ptw() and esr_abt_is_exec_fault()
  (which relies on it) into kvm_emulate.h as per Oliver.
* Updated 3/14 to use the ESR_ELx_EC() macro instead of a wrapper for it,
  as per Oliver.
* Fixed 5/14 to gate the kvm_guest_s2_mapping allocation on s2fd->mmu,
  as per Fuad.
* Made gmem_abort() skip kvm_prepare_memory_fault_exit() when pre-faulting
  in 6/14, as per Fuad.
* Updated 10/14 to move the pKVM -EOPNOTSUPP check into the
  kvm_arch_pre_fault_allowed() hook, as per Fuad.
* Extended pKVM reasoning in the 10/14 commit message, based on
  discussions with Aneesh.

v3:
* Rebased on next, fixed up a new caller to kvm_pgtable_get_leaf() to
  account for additional parameter passed.
* Adjusted: cover letter, added [ljs: ...] note to commit msg for 9/14 to
  reflect the fixup.
* Introduced and wired up kvm_arch_vcpu_allow_pre_fault_memory() as a
  separate commit at the start of the series, as per Oliver.
* Updated the pre-fault implementation to disallow uninitialised vCPU on
  pre-fault as per Oliver, and updated cover letter to reflect it.
* Extended pKVM reasoning in cover letter, commit message.
https://lore.kernel.org/r/20260922-kvm-arm-prefault-v3-0-787bd3bc7e3f@kernel.org

v2:
* Split series - Added 1/13 for the esr.h helpers, 2/13 for converting
  callers to use them, and move what was 1/8 to 3/13 to propagate
  s2fd->esr, as per Marc.
* Made esr helpers __always_inline as per Marc.
* Renamed esr_trap_get_class() -> esr_get_ec() + dropped churn as per Marc.
* Updated 5/13 (was 3/8) to drop the kvm_s2_fault_result.mapped flag.
* Also updated 5/13 so abort handlers return -EAGAIN instead of swallowing, as
  per Marc.
* Split implementation patch further -> topup_mmu_memcache() change to 6/13,
  EHWPOISON change -> 7/13 and docs change -> 10/13, as per Marc.
* No longer mkyoung existing walked ranges, updated docs to reflect, as per
  Marc.
* Eliminated s2fd->pre_fault as per Marc.
* Eliminated the redundant page table level in pre_fault_s2() as per Marc.
* Put the commit message for 9/13 on a diet as per Marc.
* Fixed up commit message for 11/13 (was 6/8) to correct reasoning about
  exit-reason assert, as per Fuad.
* Simplified: nested test 13/13 (was 8/8), dropping the empty nested-S2
  setup and using test_supports_el2() to handle NV=0 opt-out, as per
  Wei-Lin and Fuad.
* Re-authored patch 13/13 to me as the changes are substantial enough to
  require it. Updated commit message to give Jack credit for original.
https://lore.kernel.org/r/20260914-kvm-arm-prefault-v2-0-26fb47f74b73@kernel.org

v1:
https://lore.kernel.org/r/20260825-kvm-arm-prefault-v1-0-befe8947702e@kernel.org

---
Jack Thomson (3):
      KVM: arm64: Pass walk flags to kvm_pgtable_get_leaf()
      KVM: selftests: Enable pre_fault_memory_test for arm64
      KVM: selftests: Add option for different backing in pre-fault tests

Lorenzo Stoakes (ARM) (11):
      KVM: Allow architectures to disallow pre-fault
      arm64: Add ESR fault helpers
      KVM: arm64: Use ESR helpers in guest abort handling
      KVM: arm64: Propagate and use esr in s2fd when handling guest aborts
      KVM: arm64: Propagate and use mmu in s2fd when handling guest aborts
      KVM: arm64: Propagate and use kvm_s2_fault_result on S2 fault
      KVM: arm64: Size the stage-2 memcache from the fault MMU
      KVM: arm64: Propagate EHWPOISON in kvm_s2_fault_pin_pfn()
      KVM: arm64: Implement KVM_PRE_FAULT_MEMORY
      Documentation: KVM: document arm64 KVM_PRE_FAULT_MEMORY
      KVM: selftests: Add nested pre-fault test for arm64

 Documentation/virt/kvm/api.rst                     |  19 +-
 arch/arm64/include/asm/esr.h                       |  29 ++
 arch/arm64/include/asm/kvm_emulate.h               |  60 ++--
 arch/arm64/include/asm/kvm_pgtable.h               |   5 +-
 arch/arm64/include/asm/kvm_pkvm.h                  |   2 +-
 arch/arm64/kvm/Kconfig                             |   1 +
 arch/arm64/kvm/arm.c                               |   1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c              |  10 +-
 arch/arm64/kvm/hyp/nvhe/mm.c                       |   2 +-
 arch/arm64/kvm/hyp/pgtable.c                       |   5 +-
 arch/arm64/kvm/mmu.c                               | 313 +++++++++++++++++----
 arch/arm64/kvm/nested.c                            |   2 +-
 arch/s390/kvm/s390/s390.c                          |  11 +-
 arch/x86/kvm/mmu/mmu.c                             |  11 +-
 include/linux/kvm_host.h                           |   1 +
 tools/testing/selftests/kvm/Makefile.kvm           |   2 +
 .../selftests/kvm/arm64/nv_pre_fault_memory_test.c | 158 +++++++++++
 .../testing/selftests/kvm/pre_fault_memory_test.c  | 152 ++++++++--
 virt/kvm/kvm_main.c                                |  10 +-
 19 files changed, 646 insertions(+), 148 deletions(-)
---
base-commit: 23ddf997ab16b5f4aa9f948f5a68f5b35e4e398f
change-id: 20260815-kvm-arm-prefault-9bb411b6897d

Best regards,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

