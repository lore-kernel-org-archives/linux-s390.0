Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823C93FA5C8;
	Fri, 31 Jul 2026 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504768; cv=none; b=MfNHZGU2SX7hbsswOSTmrxFoJvwXeUEKHUJyuCXS01DkSC70pMmLH4YNhNIZB0SiBwYC/UuVEaHkcfjiLUAZwUSyzgS42/U+fvM5YJSusylJUuBbI9e88m0WTUltWA2DgO1HXRws1nNt9+MgdIeBTP8t68vUSw6ISQ1E4CDRhpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504768; c=relaxed/simple;
	bh=S7TfkWEt2P7H218UvUuBP4EJWc+Ui3py0YHUZaJyP3U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KjiHUinisGFRKo5avlp+F1E46zD3wvWqlOJR53M6PzC9/oXeMKueCE6UqMsYytC4lOCm89If/Yl2GpxLFSihujWwxp7t+tn4X0KBTM/TIisQSpLEOqIGSXBz680iGXSknS2dO9VieeTTyjU3JDgURGNu0Ji2+VciQ+6iK2GuYRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaGKm2Tx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaGKm2Tx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1FE1F000E9;
	Fri, 31 Jul 2026 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504767;
	bh=wFS0PI8SJR4fJevaIIJy076X2myWtNh4jmG24z8eY7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UaGKm2TxiicFnu9ws17F++G/XiusqZsEIGVqgr6T9WvZLZyTE/olUdkhIAmK1lVrB
	 +4j1LTSVHmn7vJ2i+q3mezcnvgWE6I84GVThB9dFIZv/YP9LdsdAPVuyydn1sEWD/M
	 qZkISX1ZpUzwDbFW2x2QGyL9pRc+DL3Ve73LEdsEFn8UMVCiBzUScYK4a//+gRccF7
	 lcd6/L0YdfNto6pgST9lbk3oTNohY440vuDIJY9Jk7JKBHSDvSpONrZshp/u2MHpKE
	 m5ZGUvZCvtTaw0QLAFfZ++3JubzE3pGyw8QoXxB/uWYxTOOT+jG8lk0LoQGi4EaIEv
	 1X7+/Fe1qyqmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/14] KVM: s390: Fix kvm_arch_commit_memory_region()
 when low on memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260731130138.173983-15-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
 <20260731130138.173983-15-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:32:46 +0000
Message-Id: <20260731133246.AD1FE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dropping `kvm->mmu_lock` during the retry loop allows vCPUs to fau=
lt in memory that will be subsequently overwritten, destroying guest storag=
e keys.

Pre-existing issues:
- [Medium] Missing VM Kill on memory allocation failure leaves VM in an inc=
onsistent state.
--

--- Patch [14]: [PATCH v7 14/14] KVM: s390: Fix kvm_arch_commit_memory_regi=
on() when low on memory ---
commit 7328596d47af3b280bf92a137aeed10b8bbc3124
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix kvm_arch_commit_memory_region() when low on memory

When low on memory, kvm_arch_commit_memory_region() might not perform
the required action completely, leaving the VM in an inconsistent state.
This patch fixes it by refilling the struct kvm_s390_mmu_cache and trying
again.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 518a69c55e85c..fd8badb0d571c 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c

[ ... ]

> @@ -5838,11 +5838,9 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  		return;
> =20
>  	mc =3D kvm_s390_new_mmu_cache();
> -	if (!mc) {
> -		rc =3D -ENOMEM;
> +	if (!mc)
>  		goto out;
> -	}
> -
> +retry:
>  	scoped_guard(write_lock, &kvm->mmu_lock) {
>  		if (kvm->arch.migration_mode && kvm->arch.use_cmma && old) {
>  			_dat_walk_gfn_range(old->base_gfn, old->base_gfn + old->npages,

[Severity: High]
Since kvm_set_memory_region() makes the new memslot visible to vCPUs before
calling kvm_arch_commit_memory_region(), can a guest vCPU fault in the new
memslot while KVM is committing it?

If dat_create_slot() hits -ENOMEM due to a large memslot exhausting the MMU
cache during KVM_MR_CREATE, the retry loop drops kvm->mmu_lock to top up the
cache. During this unlocked window, the guest vCPU could install valid page
tables and storage keys.

When the retry loop reacquires the lock, it restarts dat_create_slot() from
the beginning of the memslot.

If this happens, wouldn't the callback blindly overwrite the guest's valid
PTEs with an empty token and permanently destroy the valid storage keys?

arch/s390/kvm/dat.c:_dat_slot_pte() {
    ...
    pgste =3D pgste_get_lock(ptep);
    pgste =3D __dat_ptep_xchg(ptep, pgste, new_pte, gfn, walk->asce, false);
    pgste.cmma_d =3D 0;
    pgste_set_unlock(ptep, pgste);
    ...
}

[ ... ]

> @@ -5865,9 +5863,15 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  		case KVM_MR_FLAGS_ONLY:
>  			break;
>  		default:
> +			rc =3D 0;
>  			WARN(1, "Unknown KVM MR CHANGE: %d\n", change);
>  		}
>  	}
> +	if (rc =3D=3D -ENOMEM) {
> +		rc =3D kvm_s390_mmu_cache_topup(mc);
> +		if (!rc)
> +			goto retry;
> +	}
>  out:
>  	if (rc)
>  		pr_warn("failed to commit memory region\n");

[Severity: Medium]
This is a pre-existing issue, but if kvm_s390_mmu_cache_topup() fails and
returns -ENOMEM when host memory is exhausted, doesn't the code fall through
to the out label and only log a warning via pr_warn?

The commit message states that such a failure should kill the VM. Does this
actually kill the VM, or does it leave the VM running with partially deleted
or corrupted memory slot mappings since no KVM kill mechanism is invoked
here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130138.1739=
83-1-imbrenda@linux.ibm.com?part=3D14
