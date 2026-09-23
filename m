Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B385540A0;
	Wed, 23 Sep 2026 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176660; cv=none; b=TEW4f/xp7mmlY5jVyqqv0dd4uWtCx0pKOdZCAfF83MIDrypwwGELNnKU+ZB+NptGom4scp0J8jfAMceakbmG07OWsMmkjdQOjLcaarDCNdi2LcyQc5Orlz2bLKSKifo/BhDwgGgBKqShDYjh7MvntIefbFG6oyQO6tHKX6XkJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176660; c=relaxed/simple;
	bh=3jNmX2L0KPAyNxJEsL2NZ7ih8eaJGSFbnXSbhQF4vow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GEkosjyiD4Q3BPiY6YgXVGDefpjERGvK9j4CibuAZSpOWlz9jrP+hzJxop53xopQzAKwSPlUrHcPN+w4b6meQBcsf4k3vASyXxNtPaLwR/zT39x7fv2HnPWnO1EwfjAcPY0xrY0eaAymv3tZRJAJDven8RgQAexTHgj6JgiD4i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXtbzQ7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXtbzQ7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE141F00898;
	Wed, 23 Sep 2026 15:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790176659;
	bh=9vm32az2LnuV8WaiAacxm+CnjVstWYf+Y/eufVTbi0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MXtbzQ7I1JHpjbHGy0JZp3RUIguxeDgIO3H3rII9bJogVlw+XyPbgOpxl9U7FoQYi
	 eQSr8qILD04P6lR7UnN5QIM1ACiCrnY0g5NDVY9Cit73pYHbOz3YeJf1rEnDWXwGDn
	 j4XtfuHD+FAAsA6Nyo2nLuD1JukBTCu+EKKi6TD0i/Zt30Fy41f0DUu1KW2NpRABy+
	 SPcoQe8NPmByOeaU4ao/uufEfcK+2xPR/l0CRzf2rIEghFOXLliluBVsJxeO1e9gWn
	 062fvxKab7VdxkpFLEl27ifUqIXs7KPcvJwxFZymyIyyZ4nCytPiqeTu1bNzODnKm6
	 c2n98XdRm8TRQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 23 Sep 2026 16:15:52 +0100
Subject: [PATCH v4 09/14] KVM: arm64: Pass walk flags to
 kvm_pgtable_get_leaf()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-kvm-arm-prefault-v4-9-d4b0b4dfa8c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6199; i=ljs@kernel.org;
 h=from:subject:message-id; bh=/7gESZ5TmmiQJgL7YNm2fLECXkI/ScMMb7OHCu5WcGA=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLI2v9UNC8/jbLj5TPbrriO2PitLPf4eTEzblit97F/U5
 pc3A9P2dpSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAiZ3sZGT5l2wRWp5x7+fdj
 4eKYmdpGE70TOl49eyD4gSk8UNc6vIaR4eb8+IO3J635/9lJM+DtlG0r5C4t1RRjk1p2SefX3g2
 ar9kA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Jack Thomson <jackabt@amazon.com>

Allow callers of kvm_pgtable_get_leaf() to specify the page-table walk
flags, in preparation for performing walks under the MMU read lock.

Reading a stage-2 leaf while only holding the read lock requires
KVM_PGTABLE_WALK_SHARED: parallel faults (which also only hold the read
lock) can unlink table pages and free them via RCU, so the walker must
be inside an RCU read-side critical section, which the shared walk flag
provides via kvm_pgtable_walk_begin().

All existing callers either hold the write lock, walk with interrupts
disabled, or run at hyp where shared walks are rejected; they keep the
current behaviour by passing no flags.

No functional change intended.

Signed-off-by: Jack Thomson <jackabt@amazon.com>
[ljs: fixup new kvm_pgtable_get_leaf() invocation]
Reviewed-by: Oliver Upton <oupton@kernel.org>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/arm64/include/asm/kvm_pgtable.h  |  5 ++++-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 10 +++++-----
 arch/arm64/kvm/hyp/nvhe/mm.c          |  2 +-
 arch/arm64/kvm/hyp/pgtable.c          |  5 +++--
 arch/arm64/kvm/mmu.c                  |  2 +-
 arch/arm64/kvm/nested.c               |  2 +-
 6 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 20d12da3d28e..589db1d6405f 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -859,6 +859,8 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
  * @addr:	Input address for the start of the walk.
  * @ptep:	Pointer to storage for the retrieved PTE.
  * @level:	Pointer to storage for the level of the retrieved PTE.
+ * @flags:	Flags to control the page-table walk
+ *		(see struct kvm_pgtable_visit_ctx).
  *
  * The offset of @addr within a page is ignored.
  *
@@ -869,7 +871,8 @@ int kvm_pgtable_walk(struct kvm_pgtable *pgt, u64 addr, u64 size,
  * Return: 0 on success, negative error code on failure.
  */
 int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
-			 kvm_pte_t *ptep, s8 *level);
+			 kvm_pte_t *ptep, s8 *level,
+			 enum kvm_pgtable_walk_flags flags);
 
 /**
  * kvm_pgtable_stage2_pte_prot() - Retrieve the protection attributes of a
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index a6a47c1e058b..443ee433119e 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -540,7 +540,7 @@ static int host_stage2_adjust_range(u64 addr, struct kvm_mem_range *range)
 	int ret;
 
 	hyp_assert_lock_held(&host_mmu.lock);
-	ret = kvm_pgtable_get_leaf(&host_mmu.pgt, addr, &pte, &level);
+	ret = kvm_pgtable_get_leaf(&host_mmu.pgt, addr, &pte, &level, 0);
 	if (ret)
 		return ret;
 
@@ -930,7 +930,7 @@ static int get_valid_guest_pte(struct pkvm_hyp_vm *vm, u64 ipa, kvm_pte_t *ptep,
 	s8 level;
 	int ret;
 
-	ret = kvm_pgtable_get_leaf(&vm->pgt, ipa, &pte, &level);
+	ret = kvm_pgtable_get_leaf(&vm->pgt, ipa, &pte, &level, 0);
 	if (ret)
 		return ret;
 	if (guest_pte_is_poisoned(pte))
@@ -979,7 +979,7 @@ int __pkvm_vcpu_in_poison_fault(struct pkvm_hyp_vcpu *hyp_vcpu)
 	ipa |= FAR_TO_FIPA_OFFSET(kvm_vcpu_get_hfar(&hyp_vcpu->vcpu));
 
 	guest_lock_component(vm);
-	ret = kvm_pgtable_get_leaf(&vm->pgt, ipa, &pte, &level);
+	ret = kvm_pgtable_get_leaf(&vm->pgt, ipa, &pte, &level, 0);
 	if (ret)
 		goto unlock;
 
@@ -1335,7 +1335,7 @@ static int host_stage2_get_guest_info(phys_addr_t phys, struct pkvm_hyp_vm **vm,
 		return -EPERM;
 	}
 
-	ret = kvm_pgtable_get_leaf(&host_mmu.pgt, phys, &pte, &level);
+	ret = kvm_pgtable_get_leaf(&host_mmu.pgt, phys, &pte, &level, 0);
 	if (ret)
 		return ret;
 
@@ -1564,7 +1564,7 @@ static int __check_host_shared_guest(struct pkvm_hyp_vm *vm, u64 *__phys, u64 ip
 	s8 level;
 	int ret;
 
-	ret = kvm_pgtable_get_leaf(&vm->pgt, ipa, &pte, &level);
+	ret = kvm_pgtable_get_leaf(&vm->pgt, ipa, &pte, &level, 0);
 	if (ret)
 		return ret;
 	if (!kvm_pte_valid(pte))
diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index 29ab5ee9d57f..bcf2fd1ddd75 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -486,7 +486,7 @@ static int check_page_ownership(phys_addr_t phys)
 			return -EPERM;
 	}
 
-	ret = kvm_pgtable_get_leaf(&host_mmu.pgt, phys, &pte, NULL);
+	ret = kvm_pgtable_get_leaf(&host_mmu.pgt, phys, &pte, NULL, 0);
 	if (ret)
 		return ret;
 
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index b74dd5ce1efd..347eec3957d6 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -298,12 +298,13 @@ static int leaf_walker(const struct kvm_pgtable_visit_ctx *ctx,
 }
 
 int kvm_pgtable_get_leaf(struct kvm_pgtable *pgt, u64 addr,
-			 kvm_pte_t *ptep, s8 *level)
+			 kvm_pte_t *ptep, s8 *level,
+			 enum kvm_pgtable_walk_flags flags)
 {
 	struct leaf_walk_data data;
 	struct kvm_pgtable_walker walker = {
 		.cb	= leaf_walker,
-		.flags	= KVM_PGTABLE_WALK_LEAF,
+		.flags	= flags | KVM_PGTABLE_WALK_LEAF,
 		.arg	= &data,
 	};
 	int ret;
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 476a98cbe05d..5bfc4cf76f22 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -895,7 +895,7 @@ static int get_user_mapping_size(struct kvm *kvm, u64 addr)
 	 * IPI-ing threads).
 	 */
 	local_irq_save(flags);
-	ret = kvm_pgtable_get_leaf(&pgt, addr, &pte, &level);
+	ret = kvm_pgtable_get_leaf(&pgt, addr, &pte, &level, 0);
 	local_irq_restore(flags);
 
 	if (ret)
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index ec754a865a00..cd868af63b1b 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -662,7 +662,7 @@ static u8 get_guest_mapping_ttl(struct kvm_s2_mmu *mmu, u64 addr)
 		return 0;
 
 	tmp &= ~(sz - 1);
-	if (kvm_pgtable_get_leaf(mmu->pgt, tmp, &pte, NULL))
+	if (kvm_pgtable_get_leaf(mmu->pgt, tmp, &pte, NULL, 0))
 		goto again;
 	if (!(pte & PTE_VALID))
 		goto again;

-- 
2.55.0

