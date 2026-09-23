Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB4B53C3A5;
	Wed, 23 Sep 2026 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176580; cv=none; b=TO66bzudeH04m2PetBZHEN8KkTuoocNeLRXg1jS9cA1zQ9/cvia9GswNpL+3W2voev8Aujt5+gpQywylRPylR+k3Y0cpU1YsdnXTOnl6aREak5qMlZuO0rzl+oxg6H9f13Qyo8kTE+Nc68mmoSxrQ6hNLUbIHE41pGvVolNe3Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176580; c=relaxed/simple;
	bh=ZwWYk6PSclRbCMM/4KyRdFN56IXZ5zZBC+oPi0Tho/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQ7UBdUA/6k6F4sv/tG5dh3HrmGCyV25F6FZmyQq3u6TzXDQmT7MdX/JKOgG/F0ZuMTsYjh3K/hscepquT5Js8r865MWOg+BwjNXF8QWSHrZ+tNJk3g+o6D3LpWr2uiSAqU8JyZpOmf94VEL5lA9Z734OSChGjt8WOe1C+UdqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj6GEbQ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj6GEbQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D171F00893;
	Wed, 23 Sep 2026 15:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790176578;
	bh=xB36sriidKZjRSzeuEDk6PUSKpyNqCdc/eDuq5n0ym4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Yj6GEbQ5nbMxdOlmj+BxJoZZKIiJRx4KTCKp+f81vmfP2RaFIrTcdBe6zva1pC2db
	 MpH/wSoddyBQ6eWiCV96IgAg/FR6vlZVARrFTsTfu6wCCzkG26SOvrhTzzrSvC+hkq
	 LM8dCdUmmSGbOjrPQY0x0ZkMNkp4k0NMf5auj2P9vP/LAFwINSL/6L21ojdY+qcM+Z
	 ucWNMR8Qek8zwxReXkZvKnHWPetUgqTmH9CCd6i6vynrdZSVE/NYs5Barx9YPVUYPJ
	 TgOXvp8kgTUMHdH0W2tBHhQUV09knvB4f4h7M1mHxdzqO3lU5FH5ExZYiJ2LO/n6EW
	 SGVbnlZoDoFkw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 23 Sep 2026 16:15:44 +0100
Subject: [PATCH v4 01/14] KVM: Allow architectures to disallow pre-fault
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-kvm-arm-prefault-v4-1-d4b0b4dfa8c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4247; i=ljs@kernel.org;
 h=from:subject:message-id; bh=ZwWYk6PSclRbCMM/4KyRdFN56IXZ5zZBC+oPi0Tho/4=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI2v9VZ6vH+h11L59zYFa9djz1gragvy7n/xqyHI01sr
 f48j28mHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZjInReMDI+eCb2ry1vudGL5
 o3vlYVtSQ7LjEp4+nXmhbrukv4f3nHJGhg0PZhxrka7Z2vHimmwtB7sC70HX+tXxccsOzFPcuMD
 4CR8A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

All existing architectures which implement KVM pre-fault (x86, s390) have
mechanisms for disallowing pre-faulting.

Currently these are open coded as part of kvm_arch_vcpu_pre_fault_memory().

Formalise this by moving them into a new kvm_arch_pre_fault_allowed() hook,
which every architecture selecting CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY must
implement, returning an error code if the operation is disallowed or 0
otherwise.

The hook is called early in the generic code, allowing architectures to
disallow the operation prior to vCPU load.

This is important, as kvm_vcpu_pre_fault_memory() is the only place where
generic code can call vcpu_load() on a vCPU that has not yet been
initialised.

This lays the foundation for a future change which implements pre-faulting
for arm64 which needs to disallow the mechanism for uninitialised vCPUs.

Suggested-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/s390/kvm/s390/s390.c | 11 ++++++++---
 arch/x86/kvm/mmu/mmu.c    | 11 ++++++++---
 include/linux/kvm_host.h  |  1 +
 virt/kvm/kvm_main.c       | 10 +++++++++-
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index 5c73f43782a7..47fe032444f4 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -5784,6 +5784,14 @@ void kvm_arch_commit_memory_region(struct kvm *kvm, struct kvm_memory_slot *old,
 	s390_kvm_mmu_commit_memory_region(kvm, old, new, change);
 }
 
+int kvm_arch_pre_fault_allowed(struct kvm_vcpu *vcpu)
+{
+	if (kvm_is_ucontrol(vcpu->kvm))
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * kvm_arch_vcpu_pre_fault_memory() -- pre-fault and link gmap dat tables
  * @vcpu: the vcpu that shall appear to have generated the fault-in.
@@ -5810,9 +5818,6 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu, struct kvm_pre_fault_
 	gpa_t end;
 	int rc;
 
-	if (kvm_is_ucontrol(vcpu->kvm))
-		return -EINVAL;
-
 	rc = kvm_s390_faultin_gfn(vcpu, NULL, &f);
 	if (rc == PGM_ADDRESSING)
 		return -ENOENT;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 064ecc33b926..c35fd2868c20 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5086,6 +5086,14 @@ static int kvm_tdp_page_prefault(struct kvm_vcpu *vcpu, gpa_t gpa,
 	}
 }
 
+int kvm_arch_pre_fault_allowed(struct kvm_vcpu *vcpu)
+{
+	if (!vcpu->kvm->arch.pre_fault_allowed)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 				    struct kvm_pre_fault_memory *range)
 {
@@ -5095,9 +5103,6 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 	u64 end;
 	int r;
 
-	if (!vcpu->kvm->arch.pre_fault_allowed)
-		return -EOPNOTSUPP;
-
 	if (kvm_is_gfn_alias(vcpu->kvm, gpa_to_gfn(range->gpa)))
 		return -EINVAL;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6..39a4d345aeca 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2643,6 +2643,7 @@ void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range
 #endif
 
 #ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
+int kvm_arch_pre_fault_allowed(struct kvm_vcpu *vcpu);
 long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 				    struct kvm_pre_fault_memory *range);
 #endif
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..41356577bee7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4353,7 +4353,7 @@ static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
 static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 				     struct kvm_pre_fault_memory *range)
 {
-	int idx;
+	int idx, err;
 	long r;
 	u64 full_size;
 
@@ -4365,6 +4365,14 @@ static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 	    range->gpa + range->size <= range->gpa)
 		return -EINVAL;
 
+	/*
+	 * Certain architectures (e.g. arm64) need to reject the ioctl 'early'
+	 * before vcpu_load().
+	 */
+	err = kvm_arch_pre_fault_allowed(vcpu);
+	if (err)
+		return err;
+
 	vcpu_load(vcpu);
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 

-- 
2.55.0

