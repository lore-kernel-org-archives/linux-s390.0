Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C8442131;
	Wed, 29 Jul 2026 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344917; cv=none; b=jsxP0MYh6qvoOXTKIs5lKND4hMqCR2mEW/WTtExBgbNsxg1wJkQrWV6VAB/urdNe6Tc5++HxKq57jhBUbKl8OyPdnxbuE0UfEvbk+Hjb9ZBN5mYNFhY2tz+YL/U3VyDcQVamflC5e/WaqXGOycyrgo//r0trD7v0a38NIX4kZQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344917; c=relaxed/simple;
	bh=OAwvz7VUj4y9kVLsdtrA1rBz0MZbfWXYCPWERDZnUas=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EmkZf6djROQr5xgsmL567L5Pltg6WDLGoHEgIJm32Aph7119NoiKHtFGCV80lwnyMAU7sJgtt8VoB7ZgsSQvGoXIqL7lF9Go8Vbr9EY6FGl4syNWqPjjNTHVbbil1V2MZd4VWmqY6923osxhJ6QMcbWZa6Hpnp/uDUydaubPPLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd66pdug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd66pdug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFD31F000E9;
	Wed, 29 Jul 2026 17:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785344916;
	bh=hBh13dXyn04HxHOd7b4uZQ2mshdf/ibYTa3XnlWIu8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zd66pduglQQ4AUVImOfWP6jhxsi7k1PrR8VQobZWKJYbqqXyMAbfQeRD6uyL8mj1Q
	 bfhot5lSAQXmaKOAXHJYzVc6YJChBAZ/WWqawrDIwAm2q97TT/Olk4UZWvVg4Owumu
	 l9t9TVMn7/1mm4M+hkT1BVoqVLI52i6FikBYVM30NuRp8jofjuQ9e1ktH9act3FAEo
	 gR9gvHF0bQvWhA7pAIl1cLbvLw0yrF/vQUqgOlh9oM0FBEChqdUKecjWMRHxl4rF7S
	 OF594Xh0glH5SK673HwAe549cyVnqe71w8NI30nUqIjvBEIn2Intv9cUFs6TxvtsmI
	 cAw9GRS7WQ0cA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/13] KVM: s390: Fix leaking of PGM_ADDRESSING to
 userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260729152938.782383-6-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
 <20260729152938.782383-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 17:08:35 +0000
Message-Id: <20260729170835.AAFD31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] O(N^2) execution and potential soft lockup in `kvm_s390_set_skeys`=
 and `kvm_s390_set_cmma_bits` due to restarting the iteration from `0` on e=
very MMU cache top-up.
--

--- Patch [5]: [PATCH v5 05/13] KVM: s390: Fix leaking of PGM_ADDRESSING to=
 userspace ---
commit 89e2ddf835cf981fcd7459eaa6f4853002045254
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix leaking of PGM_ADDRESSING to userspace

This commit fixes KVM operations like kvm_s390_set_skeys and
kvm_s390_set_cmma_bits by converting positive error codes (such as
PGM_ADDRESSING) to -EFAULT. This ensures negative error values are properly
returned to userspace.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c

[ ... ]

> @@ -2274,7 +2274,7 @@ static int kvm_s390_set_skeys(struct kvm *kvm, stru=
ct kvm_s390_skeys *args)
>  	kvm_s390_free_mmu_cache(mc);
>  out:
>  	kvfree(keys);
> -	return r;
> +	return r <=3D 0 ? r : -EFAULT;
>  }

[Severity: High]
This is a pre-existing issue, but does the iteration in kvm_s390_set_skeys()
risk a soft lockup?

If dat_set_storage_key() returns -ENOMEM because the MMU cache is depleted,
the outer do-while loop tops up the cache and retries. However, the inner
for-loop unconditionally restarts from i =3D 0:

        scoped_guard(read_lock, &kvm->mmu_lock) {
                for (i =3D 0 ; i < args->count; i++) {
                        r =3D dat_set_storage_key(mc, kvm->arch.gmap->asce,
                                                args->start_gfn + i, keys[i=
], 0);

If userspace passes a large count (up to KVM_S390_SKEYS_MAX), restarting fr=
om
0 on every page table allocation could result in O(N^2) execution time.=20

Since this is done while holding the mmu_lock with preemption disabled, cou=
ld
this trigger RCU stalls or kernel panics?

[ ... ]

> @@ -2384,7 +2384,7 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
> =20
>  	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
> =20
> -	return r;
> +	return r <=3D 0 ? r : -EFAULT;
>  }

[Severity: High]
This is also a pre-existing issue, but does kvm_s390_set_cmma_bits() have
the same quadratic restart problem?

Similar to the skeys function above, if dat_set_cmma_bits() returns -ENOMEM,
the loop tops up the cache and restarts processing from args->start_gfn:

        do {
                r =3D kvm_s390_mmu_cache_topup(mc);
                if (r)
                        return r;
                scoped_guard(read_lock, &kvm->mmu_lock) {
                        r =3D dat_set_cmma_bits(mc, kvm->arch.gmap->asce, a=
rgs->start_gfn,
                                              args->count, args->mask, bits=
);
                }
        } while (r =3D=3D -ENOMEM);

Should these loops advance the starting address/index so they resume where
they left off instead of starting over?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729152938.7823=
83-1-imbrenda@linux.ibm.com?part=3D5
