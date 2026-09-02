Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F5639150B;
	Wed,  2 Sep 2026 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788329748; cv=none; b=PUBsy3Hb+QMa/FgccHdJg2QlG1mxVhQYVmJovBfMJmj6O7bv+eT806b8xXGtuzxFOTqnBBxm/HMYZY/A/oVmdlAlL+RUI2h61cSwNzpeQ3ZVuOEyv688M7AGkrYmSVS7PDjWT6rY6x92684Ot3Sv9HEy51cWt8rLQZy2gSGZxMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788329748; c=relaxed/simple;
	bh=eYs7PvvK7m/4Bc+5SPo3ABQ7DJyDZT859glz5SE+vWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uGOxyDe08EAWvE/ypL1NxwAOX1RiCgBI22lM8LEhSun+uf+b71zWaT1UiblOC24xMr5+LLVkQ10BR7ONizltHDBZvaWY86DOVumaPZghyRpBSHPLcZRcIu92E5rurR8aFACLIsApmPe3UBx/gccbq6rAx0GwLmE8qQIxzYfGBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LB8X6Imi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LB8X6Imi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986D31F00A3F;
	Wed,  2 Sep 2026 06:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788329744;
	bh=C0109/Wqd8Wh+hWY6seDc3gIIuk1v7uuHz7s+qR/LBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LB8X6ImiwS+pRQhGYycXxWsTA/zbb8cKaDcKn7YY1YKr2eugSoSh8+GdnbU8Hm97m
	 FiQzurLzDonqCYHy6zm2G6/LjiwrvFvk7hfm5tTxrdrmbmYGOGDTSdgoNb0r8l8ycw
	 7ULkXAgHk0+8nXyq2/BFo5fzyfI9gyQgfcBNj88H8uPF4CCODMBCEzlyvKyPE/mmKj
	 oo8CZGVdYQMpVr1NgWCBveFt9ua7AkWHky6f0DmhzE8vepYpQl4m151HINIhTHBris
	 SXMfxdDFveWSrSeRL/G+vWD2zz1/0Is5/lWKXpqNmO2r7UQBhyfpaO2tDPrxpwe7F/
	 xTZgbOC/BjT4Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 02 Sep 2026 09:15:16 +0300
Subject: [PATCH 4/4] KVM: s390: Replace get_zeroed_page() with kzalloc()
 for sie_page2 and CMMA
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-s390-kvm-v1-4-3bc0986550b1@kernel.org>
References: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
In-Reply-To: <20260902-s390-kvm-v1-0-3bc0986550b1@kernel.org>
To: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@kernel.org>, 
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-s390@vger.kernel.org
X-Mailer: b4 0.17-dev

kvm_arch_init_vm() allocates struct sie_page2 that holds the facility
list and the crypto control block of a VM and kvm_s390_vcpu_setup_cmma()
allocates the CMMA collaborative memory management block referenced by
the SIE control block. Both are passed to the hardware as physical
addresses and must be page aligned.

kmalloc() guarantees that a power of two sized allocation is aligned to
its size, so a PAGE_SIZE allocation is page aligned as well.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

The sie_page allocated in kvm_arch_vcpu_create() is left alone because it
is mapped to userspace with virt_to_page() in kvm_arch_vcpu_fault() and
therefore really needs a struct page.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/kvm/s390/s390.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
index b0839e887221e..8ec505060f8c0 100644
--- a/arch/s390/kvm/s390/s390.c
+++ b/arch/s390/kvm/s390/s390.c
@@ -3273,8 +3273,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		goto out_err;
 
 	BUILD_BUG_ON(sizeof(struct sie_page2) != 4096);
-	kvm->arch.sie_page2 =
-	     (struct sie_page2 *) get_zeroed_page(GFP_KERNEL_ACCOUNT | GFP_DMA);
+	kvm->arch.sie_page2 = kzalloc_obj(*kvm->arch.sie_page2,
+					  GFP_KERNEL_ACCOUNT | GFP_DMA);
 	if (!kvm->arch.sie_page2)
 		goto out_err;
 
@@ -3369,7 +3369,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 	return 0;
 out_err:
-	free_page((unsigned long)kvm->arch.sie_page2);
+	kfree(kvm->arch.sie_page2);
 	debug_unregister(kvm->arch.dbf);
 	sca_dispose(kvm);
 	KVM_EVENT(3, "creation of vm failed: %d", rc);
@@ -3427,7 +3427,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 		mmu_notifier_unregister(&kvm->arch.pv.mmu_notifier, kvm->mm);
 
 	debug_unregister(kvm->arch.dbf);
-	free_page((unsigned long)kvm->arch.sie_page2);
+	kfree(kvm->arch.sie_page2);
 	kvm_s390_destroy_adapters(kvm);
 	kvm_s390_clear_float_irqs(kvm);
 	kvm_s390_vsie_destroy(kvm);
@@ -3657,13 +3657,13 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.sie_block->cbrlo)
-		free_page((unsigned long)phys_to_virt(vcpu->arch.sie_block->cbrlo));
+		kfree(phys_to_virt(vcpu->arch.sie_block->cbrlo));
 	vcpu->arch.sie_block->cbrlo = 0;
 }
 
 int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu)
 {
-	void *cbrlo_page = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
+	void *cbrlo_page = kzalloc(PAGE_SIZE, GFP_KERNEL_ACCOUNT);
 
 	if (!cbrlo_page)
 		return -ENOMEM;

-- 
2.53.0

