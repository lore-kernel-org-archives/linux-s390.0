Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C69953D0D4;
	Wed, 23 Sep 2026 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176630; cv=none; b=ngT0tFK0MNDbUVqW3wXU7TtYC5lsLJ6glZcozoYSS52gGAotkZl16kgYmiPeJgrKQWXd+C7U3tducEV4bQN919dFZCOBigIVkoWgai1fyhqgNGz31orJVQr3bngtN/WG0/U+hm7wMTqlXnhh5MiwV0toqqdVCdfn/QtgzOKMvi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176630; c=relaxed/simple;
	bh=d2RtnpecLVAubBY7OqtG18bcfCdBXcTO5lSZ4rwDIMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SDytCKXjc99qumjHviNc5dFW4LogWarLjT60bk4jeYU5xd7cspJT6ZIqrmYRM66r6WcC98PVF1fw8n5GnkYY08CRs3JLrwqgfi8pGdtRUWy6XV+aBAHjaKOnuYz9HHeQk7DfX6ES5u8RBxHUYPJSoGJRQhSVkxDCcslJ3QuXSlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kit6ohZ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kit6ohZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622E51F00893;
	Wed, 23 Sep 2026 15:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790176628;
	bh=O7DkT3TdNlYpOfcIlfLZN1+Hxti+S/5tyGjgvbR9yuI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kit6ohZ7PI8mOuQZZV6g+wXFRJYU1FjyzoCoatj4b+McSVr/K2BiN7FksX6q/JI9r
	 GyM9QSeiosz9jIKQDcSnCuQNZqjkmrkB3UAATrefKIqye7GoUts8XhtylBLIY2B//f
	 HmZDm3corcyHWKo5x2rIN5NbWsK457Kr53rpAxEhs/2VjgOWRuRURkUSY1O7pbY7nt
	 hh4NY+yro5v5xTmhQ7Hk+bLmSsSS8/h1GvZawcVbu8isEvhN24mJ01TCFKbcqs4Pec
	 vgu1EZoOAYFo/f7Epfkhp7PhNyQjJBUPaCUnV+t7qLqqfBC2qcq8/3yxKqGKDlg0Cc
	 lpPj/hlmfMnQw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 23 Sep 2026 16:15:49 +0100
Subject: [PATCH v4 06/14] KVM: arm64: Propagate and use kvm_s2_fault_result
 on S2 fault
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-kvm-arm-prefault-v4-6-d4b0b4dfa8c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4957; i=ljs@kernel.org;
 h=from:subject:message-id; bh=d2RtnpecLVAubBY7OqtG18bcfCdBXcTO5lSZ4rwDIMo=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI2v9VdqXd4ocH7mN/ia9OuXZ+X1NPuvNj5X9WneRFJC
 4VrTzDpdJSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAi8ckMf/jFr2ycF99Zflv5
 qpHc/BXv5M4U3Wp5bPVH4XjFievWjt8ZGbqCly5OkH/9WKNf3u4VV1VT+Zfm8o2nsqsCb237KFt
 RyAsA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

When stage 2 page tables fault the net result may either be that a page is
mapped, an error occurred or the fault should be retried (-EAGAIN).

When a fault succeeds it may be upgraded to a PMD size via
transparent_hugepage_adjust().

In order to support KVM pre-faulting the outcome of the fault and the
mapping size must be recorded.

Track the mapping size via new kvm_s2_fault_result struct, which is
threaded through gmem_abort(), user_mem_abort() and kvm_s2_fault_map().

PKVM and SEA aren't relevant to synthetic pre-faulting so neither
kvm_inject_sea() nor pkvm_mem_abort() are altered.

Actual hardware faulting doesn't require this information, so
kvm_handle_guest_abort() simply passes NULL kvm_s2_fault_result to
gmem_abort() and user_mem_abort().

A non-NULL result also tells the abort handlers that the caller is
pre-faulting rather than a vcpu, in which case -EAGAIN is propagated to the
caller to allow the pre-fault to be retried.

Likewise, only prepare a KVM_EXIT_MEMORY_FAULT in gmem_abort() when a real
fault is being handled, as this updates vcpu state.

No functional change intended.

Suggested-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Oliver Upton <oupton@kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/arm64/kvm/mmu.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 9d799f7c1e62..ee2a4f0faa14 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1659,6 +1659,10 @@ struct kvm_s2_fault_desc {
 	struct kvm_s2_mmu	*mmu;
 };
 
+struct kvm_s2_fault_result {
+	unsigned long mapping_size;
+};
+
 static bool kvm_s2_fault_is_perm(const struct kvm_s2_fault_desc *s2fd)
 {
 	return esr_fsc_is_permission_fault(s2fd->esr);
@@ -1684,7 +1688,8 @@ static u64 kvm_s2_perm_fault_granule(const struct kvm_s2_fault_desc *s2fd)
 	return BIT(ARM64_HW_PGTABLE_LEVEL_SHIFT(level));
 }
 
-static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
+static int gmem_abort(const struct kvm_s2_fault_desc *s2fd,
+		      struct kvm_s2_fault_result *result)
 {
 	bool write_fault, exec_fault;
 	bool perm_fault = kvm_s2_fault_is_perm(s2fd);
@@ -1728,8 +1733,10 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 
 	ret = kvm_gmem_get_pfn(kvm, s2fd->memslot, gfn, &pfn, &page, NULL);
 	if (ret) {
-		kvm_prepare_memory_fault_exit(s2fd->vcpu, s2fd->fault_ipa, PAGE_SIZE,
-					      write_fault, exec_fault, false);
+		/* If result is non-NULL this is a synthetic fault. */
+		if (!result)
+			kvm_prepare_memory_fault_exit(s2fd->vcpu, s2fd->fault_ipa, PAGE_SIZE,
+						      write_fault, exec_fault, false);
 		kfree(mapping);
 		return ret;
 	}
@@ -1784,7 +1791,13 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
 	if ((prot & KVM_PGTABLE_PROT_W) && !ret)
 		mark_page_dirty_in_slot(kvm, s2fd->memslot, gfn);
 
-	return ret != -EAGAIN ? ret : 0;
+	if (ret == -EAGAIN)
+		return result ? ret : 0;
+
+	if (result && !ret)
+		result->mapping_size = PAGE_SIZE;
+
+	return ret;
 }
 
 struct kvm_s2_fault_vma_info {
@@ -2108,7 +2121,8 @@ static int kvm_s2_fault_compute_prot(const struct kvm_s2_fault_desc *s2fd,
 static int kvm_s2_fault_map(const struct kvm_s2_fault_desc *s2fd,
 			    const struct kvm_s2_fault_vma_info *s2vi,
 			    enum kvm_pgtable_prot prot,
-			    void *memcache)
+			    void *memcache,
+			    struct kvm_s2_fault_result *result)
 {
 	enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_SHARED;
 	struct kvm_guest_s2_mapping *mapping = NULL;
@@ -2209,12 +2223,17 @@ static int kvm_s2_fault_map(const struct kvm_s2_fault_desc *s2fd,
 		mark_page_dirty_in_slot(kvm, s2fd->memslot,
 					gpa_to_gfn(canonical_ipa));
 
-	if (ret != -EAGAIN)
-		return ret;
-	return 0;
+	if (ret == -EAGAIN)
+		return result ? ret : 0;
+
+	if (result && !ret)
+		result->mapping_size = mapping_size;
+
+	return ret;
 }
 
-static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd)
+static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd,
+			  struct kvm_s2_fault_result *result)
 {
 	bool perm_fault = kvm_s2_fault_is_perm(s2fd);
 	struct kvm_s2_fault_vma_info s2vi = {};
@@ -2253,7 +2272,7 @@ static int user_mem_abort(const struct kvm_s2_fault_desc *s2fd)
 		return ret;
 	}
 
-	return kvm_s2_fault_map(s2fd, &s2vi, prot, memcache);
+	return kvm_s2_fault_map(s2fd, &s2vi, prot, memcache, result);
 }
 
 /* Resolve the access fault by making the page young again. */
@@ -2532,9 +2551,9 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 				!kvm_s2_fault_is_exec(&s2fd));
 
 		if (kvm_slot_has_gmem(memslot))
-			ret = gmem_abort(&s2fd);
+			ret = gmem_abort(&s2fd, NULL);
 		else
-			ret = user_mem_abort(&s2fd);
+			ret = user_mem_abort(&s2fd, NULL);
 	}
 
 	if (ret == 0)

-- 
2.55.0

