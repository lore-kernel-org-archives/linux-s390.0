Received: from mta1.migadu.com (out-35.mta1.migadu.com [95.215.58.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8C423E9F
	for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187916; cv=none; b=nl3t5xImj924TqpftpxKeW2GFjYy2yyKY4kpGy2iKCMR5qqWK99nwx8Ou3LpKqV1htu0nj7RGoSle4N/F3yDU83YvmKomjIMUOD9ikKHtQ79IuRPI6dNrcU1JhZqO7iVr6wrcGRwznfakpPYnziNVw6Fa256268ljcHcO4LPTIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187916; c=relaxed/simple;
	bh=icKpVwDolFVv+1u7uqlBuvsRyBBd3V2KuR/bENnyVWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qC7SuK0rEf6dR+dDuZR6cdPWonYY9CSr1MfvddXyx5ZFHGQ9XQzYgtu7OJpvoNa4xhfTABD4PPi7YcwQjpLzaNOKs11DDxEw9sDZW8rmUp2cF/MS2YDO/Urmb6ByLZQPlABRP2Usz87Z6WPZ4+3rTdiAQzkdp0jdp+W6/t+xMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FwIKj185; arc=none smtp.client-ip=95.215.58.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FwIKj185"
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=icKpVwDolFVv+1u7uqlBuvsRyBBd3V2KuR/bENnyVWA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790187909; v=1; x=1790792709;
 b=FwIKj185xMUxfmgRh6urcMGXUUBp+ge8dOnAiWmGkbMPwM4oi4N45g6F7UCBzEuGn2cPERQ6
 LWF7l60yURxnjla8ntn3Y0JQk8s3oxXXICz+abBjZnyZ6C+/J170MFSMTwa5CU0tajYbTS6AVFn
 YYRQwxLmawzJ0lfEXJpAV9Ws=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0864c42a8e49d7e9;
	Wed, 23 Sep 2026 18:25:09 +0000
X-Mizu-Trace-ID: 0864c42a8e49d7e9
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b83c1421ecso1004e87.1
        for <linux-s390@vger.kernel.org>; Wed, 23 Sep 2026 11:25:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz39R23W0uwtnivaIW574tmhXGXU5Vp/mJZD4rmI3QppLYMr0olkoHM7YM1uZ5XDZybleWqSjU/rEDf@vger.kernel.org
X-Gm-Message-State: AFuF++lzX4T0oqfqbdxdMP3Xy5bmioBxUbGbsIgSe/8h5EQWXSUFrtJE
	doJHGxJAE0po/WkQjmhKF//HlXFVn3l9CP4OkIwgrbcOmaN1vFiAghcdrgs3PVNaacMIeBZxbVn
	3IP+Gx1tbAicZwxFdBw1f3dMUi8U/ICfQJq12GS1S
X-Received: by 2002:a05:6512:2348:b0:5b8:c8f2:16c4 with SMTP id
 2adb3069b0e04-5b8dda16356mr41989e87.10.1790187904131; Wed, 23 Sep 2026
 11:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org> <20260923-kvm-arm-prefault-v4-5-d4b0b4dfa8c3@kernel.org>
In-Reply-To: <20260923-kvm-arm-prefault-v4-5-d4b0b4dfa8c3@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 23 Sep 2026 19:24:27 +0100
X-Gmail-Original-Message-ID: <CA+EHjTwP60W9Hbh+QXnzO0jp2WLuBDFHgAMpOh7NJjtBPvMHMA@mail.gmail.com>
X-Gm-Features: AclHuK9tcjGuGMhNzNDTCbr0CDkbARnDYHgYTOmN_66FCQTilOlmgllNeI6N8aU
Message-ID: <CA+EHjTwP60W9Hbh+QXnzO0jp2WLuBDFHgAMpOh7NJjtBPvMHMA@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] KVM: arm64: Propagate and use mmu in s2fd when
 handling guest aborts
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jack Thomson <jackabt@amazon.com>, 
	Jack Thomson <jackabt.amazon@gmail.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Vincent Donnefort <vdonnefort@google.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Leo Soares Passos <Leo.Bras@arm.com>, Wei-Lin Chang <weilin.chang@arm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Sept 2026 at 16:17, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
> kvm_handle_guest_abort() establishes a kvm_s2_fault_desc data structure,
> s2fd, to store and propagate state to either pkvm_mem_abort(), gmem_abort()
> or user_mem_abort() handlers.
>
> Each of these, however, examines the state of the stage 2 MMU via
> vcpu->arch.hw_mmu.
>
> Introduce an s2fd->mmu field to abstract this and propagate it to callers.
>
> Similar to adding the esr field, this allows injection of synthetic faults
> with the ultimate intention of implementing stage 2 page table
> pre-faulting.
>
> No functional change intended.
>
> Reviewed-by: Oliver Upton <oupton@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

> ---
>  arch/arm64/kvm/mmu.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index cb677ab76484..9d799f7c1e62 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1656,6 +1656,7 @@ struct kvm_s2_fault_desc {
>         struct kvm_memory_slot  *memslot;
>         unsigned long           hva;
>         unsigned long           esr;
> +       struct kvm_s2_mmu       *mmu;
>  };
>
>  static bool kvm_s2_fault_is_perm(const struct kvm_s2_fault_desc *s2fd)
> @@ -1689,7 +1690,7 @@ static int gmem_abort(const struct kvm_s2_fault_desc *s2fd)
>         bool perm_fault = kvm_s2_fault_is_perm(s2fd);
>         enum kvm_pgtable_walk_flags flags = KVM_PGTABLE_WALK_SHARED;
>         enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
> -       struct kvm_pgtable *pgt = s2fd->vcpu->arch.hw_mmu->pgt;
> +       struct kvm_pgtable *pgt = s2fd->mmu->pgt;
>         struct kvm_guest_s2_mapping *mapping = NULL;
>         unsigned long mmu_seq;
>         struct page *page;
> @@ -1805,7 +1806,7 @@ static int pkvm_mem_abort(const struct kvm_s2_fault_desc *s2fd)
>  {
>         unsigned int flags = FOLL_HWPOISON | FOLL_LONGTERM | FOLL_WRITE;
>         struct kvm_vcpu *vcpu = s2fd->vcpu;
> -       struct kvm_pgtable *pgt = vcpu->arch.hw_mmu->pgt;
> +       struct kvm_pgtable *pgt = s2fd->mmu->pgt;
>         struct mm_struct *mm = current->mm;
>         struct kvm *kvm = vcpu->kvm;
>         void *hyp_memcache;
> @@ -2121,7 +2122,7 @@ static int kvm_s2_fault_map(const struct kvm_s2_fault_desc *s2fd,
>         gfn_t gfn;
>         int ret;
>
> -       if (kvm_is_nested_s2_mmu(kvm, s2fd->vcpu->arch.hw_mmu)) {
> +       if (kvm_is_nested_s2_mmu(kvm, s2fd->mmu)) {
>                 mapping = kmalloc_obj(struct kvm_guest_s2_mapping,
>                                       GFP_KERNEL_ACCOUNT);
>                 if (!mapping) {
> @@ -2131,7 +2132,7 @@ static int kvm_s2_fault_map(const struct kvm_s2_fault_desc *s2fd,
>         }
>
>         kvm_fault_lock(kvm);
> -       pgt = s2fd->vcpu->arch.hw_mmu->pgt;
> +       pgt = s2fd->mmu->pgt;
>         ret = -EAGAIN;
>         if (mmu_invalidate_retry(kvm, s2vi->mmu_seq))
>                 goto out_unlock;
> @@ -2363,6 +2364,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>  {
>         struct kvm_s2_trans nested_trans, *nested = NULL;
>         unsigned long esr = kvm_vcpu_get_esr(vcpu);
> +       struct kvm_s2_mmu *mmu = vcpu->arch.hw_mmu;
>         phys_addr_t fault_ipa; /* The address we faulted on */
>         phys_addr_t ipa; /* Always the IPA in the L1 guest phys space */
>         struct kvm_memory_slot *memslot;
> @@ -2392,7 +2394,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>                 }
>
>                 /* Falls between the IPA range and the PARange? */
> -               if (fault_ipa >= BIT_ULL(VTCR_EL2_IPA(vcpu->arch.hw_mmu->vtcr))) {
> +               if (fault_ipa >= BIT_ULL(VTCR_EL2_IPA(mmu->vtcr))) {
>                         fault_ipa |= FAR_TO_FIPA_OFFSET(kvm_vcpu_get_hfar(vcpu));
>
>                         return kvm_inject_sea(vcpu, is_iabt, fault_ipa);
> @@ -2429,8 +2431,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>          * nothing to walk and we treat it as a 1:1 before going through the
>          * canonical translation.
>          */
> -       if (kvm_is_nested_s2_mmu(vcpu->kvm,vcpu->arch.hw_mmu) &&
> -           vcpu->arch.hw_mmu->nested_stage2_enabled) {
> +       if (kvm_is_nested_s2_mmu(vcpu->kvm, mmu) &&
> +           mmu->nested_stage2_enabled) {
>                 u32 esr;
>
>                 ret = kvm_walk_nested_s2(vcpu, fault_ipa, &nested_trans);
> @@ -2505,7 +2507,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>         }
>
>         /* Userspace should not be able to register out-of-bounds IPAs */
> -       VM_BUG_ON(ipa >= kvm_phys_size(vcpu->arch.hw_mmu));
> +       VM_BUG_ON(ipa >= kvm_phys_size(mmu));
>
>         if (esr_fsc_is_access_flag_fault(esr)) {
>                 handle_access_fault(vcpu, fault_ipa);
> @@ -2520,6 +2522,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>                 .memslot        = memslot,
>                 .hva            = hva,
>                 .esr            = esr,
> +               .mmu            = mmu,
>         };
>
>         if (kvm_vm_is_protected(vcpu->kvm)) {
>
> --
> 2.55.0
>
