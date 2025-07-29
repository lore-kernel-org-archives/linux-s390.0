Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777EC296158
	for <linux-s390@vger.kernel.org>; Tue, 29 Jul 2025 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810963; cv=none; b=l2H5wODVVz54jfxcQgaZE+PVJ79mLZMrVYpBfjmjBbdF3d2YTSJcJCXDxTzHNFjCiNa2v4jUfQcSa2wHmsytFlhyB+uac3+jIcNAZKDsoF2ZQQ+kCnJuH4UHOBB0RhYZ+xCd+5ZZVIP6TA7MVQplxnDBAjsMTgOF1XNDezrXQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810963; c=relaxed/simple;
	bh=e7H65OUTTySjbVhc8bnRw+W3Xmwc3ESREGLczzyVkRw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WS6K76fBx0A9oDPtODnIF7W/dGqYVvQ+DJT7FaGDS14V8WdwCVY7j2MosTqHV2vWLEWXU0eVuQBj43NDKG8UWVSOYjtjeEaiMBf2SONBjiaWsccMEp/ns2zhFWsCAnv+6g1fsiAY05M0ppzbUCJ1+UKoxVUeFATNdNOuFS5O5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WfY9QwPH; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WfY9QwPH"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b0e0c573531so4284602a12.3
        for <linux-s390@vger.kernel.org>; Tue, 29 Jul 2025 10:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753810962; x=1754415762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82FN5fIR/hwkzJS9jFM+jcYFsAggMEElUtfqK1j0Xxw=;
        b=WfY9QwPHJqv44DDZg8rn1HPRVvqXwh9yW5HyAIfwtGlCia0288vmNLJ4ciqz0JJ8mq
         CqqxwdW7ZP2h/4NLLQA2a/9v4V0UWJqYQJh+M+aFpBsKleXZDdnfYXQA4EAdAslL+fOw
         AKL8qrVk5e6yCLCHA/oIjZF+hRcXayYl+ge33hcC5bi6ypKeBZMRqrtMPvr8UP6WE75f
         NCSW6QMc2ZxFMyQV8tElakyt8ROfsid+fbS3D6Ji435frphI1XEsD7RsTRGwuDmHYNbA
         tGoNVQFw8nIQ5VRv9tER7LrAKGqAhlncOY7WNnkaKB2ExNG249JUbLFPuasyyIOKYc0M
         f5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753810962; x=1754415762;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82FN5fIR/hwkzJS9jFM+jcYFsAggMEElUtfqK1j0Xxw=;
        b=U/39bl80Ab2FqeG3N14Mo24nE7uof3Rj4AJ6VcYZQaaC1cVOoroJnddBejUh6hlaLQ
         UadJ4W8IkJW7bvhfzBjAwwrllLzJ8t0ToDU8pagU3Gyy4UY0n9f6aO81VVOmwShj1yjb
         toCReerluT6scCxRJc7/1zqaOBcGKRsDSfkYUIWIVdMHaNP4Eqr+5d8M4xFj3Pc5CcDs
         3fujcSAIsFg5sA4pN9PhiOoj5V6p/Dg7sCAlxhZby7cNTmiU6LSY6/Je1/n4wwkc/OIL
         6I9uvVP7iVC+sxCQhkGEg1AvW633gbu+gNeYawk8zw0Nf2UpwWJ/IRSqmT1aiAPeef+1
         Hy6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkIzcOZMeXUtDNVSg7zybaca+3jrbFEGJJp3h2y6OhMeSMNoywUQVcLosxnErqzXBe8sn7j6o4CI/X@vger.kernel.org
X-Gm-Message-State: AOJu0YzgG1jEGk6sHhL73SUb4qq1Tn3HXcHznVytx/R/HHPtEeBorWve
	IHKxGk5cloVMxtpymRPCSc8/5qlJbRjw+5KibNW31eXCIzUDML4/YkcKpaNcWQbXdDPCeLZTU0E
	skD7I/Q==
X-Google-Smtp-Source: AGHT+IHL9uyOCJhKfXzpWPYdk2ktpEDltn10+YA1InNR0RiEZWVGuenP/JjoNtMCTI8JhTdD+YDYzrbjaOw=
X-Received: from pjv8.prod.google.com ([2002:a17:90b:5648:b0:31f:37f:d381])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e706:b0:312:daf3:bac9
 with SMTP id 98e67ed59e1d1-31f5de69a49mr434036a91.34.1753810961444; Tue, 29
 Jul 2025 10:42:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Jul 2025 10:42:32 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729174238.593070-1-seanjc@google.com>
Subject: [PATCH 0/6] KVM: Export KVM-internal symbols for sub-modules only
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Andy Lutomirski <luto@kernel.org>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
	Jason Herne <jjherne@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-sgx@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use the newfangled EXPORT_SYMBOL_GPL_FOR_MODULES() along with some macro
shenanigans to export KVM-internal symbols if and only if KVM has one or
more sub-modules, and only for those sub-modules, e.g. x86's kvm-amd.ko
and/or kvm-intel.ko.

Patch 5 gives KVM x86 the full treatment.  If anyone wants to tackle PPC,
it should be doable to restrict KVM PPC's exports as well.

Patch 6 is essentially an RFC; it compiles and is tested, but it probably
should be chunked into multiple patches.  The main reason I included it
here is to get feedback on using kvm_types.h to define the "for KVM" macros.
For KVM itself, kvm_types.h is a solid choice, but it feels a bit awkward
for non-KVM usage, and including linux/kvm_types.h in non-KVM generic code,
e.g. in kernel/, isn't viable at the moment because asm/kvm_types.h is only
provided by architectures that actually support KVM.

Based on kvm/queue.

Sean Christopherson (6):
  KVM: s390/vfio-ap: Use kvm_is_gpa_in_memslot() instead of open coded
    equivalent
  KVM: Export KVM-internal symbols for sub-modules only
  KVM: x86: Move kvm_intr_is_single_vcpu() to lapic.c
  KVM: x86: Drop pointless exports of kvm_arch_xxx() hooks
  KVM: x86: Export KVM-internal symbols for sub-modules only
  x86: Restrict KVM-induced symbol exports to KVM modules where
    obvious/possible

 arch/powerpc/include/asm/kvm_types.h |  15 ++
 arch/s390/include/asm/kvm_host.h     |   2 +
 arch/s390/kvm/priv.c                 |   8 +
 arch/x86/entry/entry.S               |   7 +-
 arch/x86/entry/entry_64_fred.S       |   3 +-
 arch/x86/events/amd/core.c           |   5 +-
 arch/x86/events/core.c               |   7 +-
 arch/x86/events/intel/lbr.c          |   3 +-
 arch/x86/events/intel/pt.c           |   7 +-
 arch/x86/include/asm/kvm_host.h      |   3 -
 arch/x86/include/asm/kvm_types.h     |  15 ++
 arch/x86/kernel/apic/apic.c          |   3 +-
 arch/x86/kernel/apic/apic_common.c   |   3 +-
 arch/x86/kernel/cpu/amd.c            |   4 +-
 arch/x86/kernel/cpu/bugs.c           |  17 +--
 arch/x86/kernel/cpu/bus_lock.c       |   3 +-
 arch/x86/kernel/cpu/common.c         |   7 +-
 arch/x86/kernel/cpu/sgx/main.c       |   3 +-
 arch/x86/kernel/cpu/sgx/virt.c       |   5 +-
 arch/x86/kernel/e820.c               |   3 +-
 arch/x86/kernel/fpu/core.c           |  21 +--
 arch/x86/kernel/fpu/xstate.c         |   7 +-
 arch/x86/kernel/hw_breakpoint.c      |   3 +-
 arch/x86/kernel/irq.c                |   3 +-
 arch/x86/kernel/kvm.c                |   5 +-
 arch/x86/kernel/nmi.c                |   5 +-
 arch/x86/kernel/process_64.c         |   5 +-
 arch/x86/kernel/reboot.c             |   5 +-
 arch/x86/kernel/tsc.c                |   1 +
 arch/x86/kvm/cpuid.c                 |  10 +-
 arch/x86/kvm/hyperv.c                |   4 +-
 arch/x86/kvm/irq.c                   |  34 +----
 arch/x86/kvm/kvm_onhyperv.c          |   6 +-
 arch/x86/kvm/lapic.c                 |  70 ++++++---
 arch/x86/kvm/lapic.h                 |   4 +-
 arch/x86/kvm/mmu/mmu.c               |  36 ++---
 arch/x86/kvm/mmu/spte.c              |  10 +-
 arch/x86/kvm/mmu/tdp_mmu.c           |   2 +-
 arch/x86/kvm/pmu.c                   |   8 +-
 arch/x86/kvm/smm.c                   |   2 +-
 arch/x86/kvm/x86.c                   | 211 +++++++++++++--------------
 arch/x86/lib/cache-smp.c             |   9 +-
 arch/x86/lib/msr.c                   |   5 +-
 arch/x86/mm/pat/memtype.c            |   3 +-
 arch/x86/mm/tlb.c                    |   5 +-
 arch/x86/virt/vmx/tdx/tdx.c          |  65 +++++----
 drivers/s390/crypto/vfio_ap_ops.c    |   2 +-
 include/linux/kvm_types.h            |  39 ++++-
 virt/kvm/eventfd.c                   |   2 +-
 virt/kvm/guest_memfd.c               |   4 +-
 virt/kvm/kvm_main.c                  | 126 ++++++++--------
 51 files changed, 457 insertions(+), 378 deletions(-)
 create mode 100644 arch/powerpc/include/asm/kvm_types.h


base-commit: beafd7ecf2255e8b62a42dc04f54843033db3d24
-- 
2.50.1.552.g942d659e1b-goog

