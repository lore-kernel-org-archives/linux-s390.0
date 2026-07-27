Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E573B14AB;
	Mon, 27 Jul 2026 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166402; cv=none; b=NNjCF8MNtHuKajEXQbxyX1EPudnEqJjlEs4OkjI0C8W82fLIKcE4nfloRf1T2/re6ze/c9s3FDFOHAY8G7JDlNU6o6dDkhTTPWCpvpRAvkwCJgW23eA27aDo8PjtOKIgOoNIOxlfk7pvyh+rvVfj1XHRBMHbL/83Bp7NkZ4vVow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166402; c=relaxed/simple;
	bh=QRhaqkCDMzGPa4T5O8Qvf9ifwZpVai9NHyBVSgFg/ok=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bdp+leyiN5TSTEELQfmPEGCU6NuvZTOnd3YT3dwguiixQ1afLfnFgbpOJ4uq2fr27PAEeuozaQ0p65Q++AHw1+KcA/3nSzy8GYNQCk+6/5SxahnkrAAwUBdbuewENJ0MvJH5QG2rCWrH+98s2QO3RWkB5KeZlgVePDP28lEnbyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJEkGT1d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJEkGT1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6828E1F00A3A;
	Mon, 27 Jul 2026 15:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166400;
	bh=1yIixYSgcEDKJq/MK6cbIRlTuiOpoM+dcE++pgRZh48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MJEkGT1dZ3SoMPyaL61bDmqEUnDm6PmlHNX5pLzZMjSyoVQIsv9oSoALZeqJvzWsw
	 3OaVnz6419OoYr4HkN6Es64BLQeSjlTIHSuuKe3Fxmvaw6LFwULsqHjfxtU8aFrFAq
	 uR8UPu/sJU9dj5zkUbdh3kvxqbLNftooH66YhW+HkISbgovQCZs/EnIAPX6YalgSXn
	 ndRNPWGvZurrnbYS3cyL3sooJx9cEjqRBBtwK0+oJR3HmPZywfmNYq+SnVmPBlrMXi
	 SzXs/ph2K5BLtRJOii2THHmxCcGf4oDSh0wNBoXohIYkAss+5vP7vaPl5Ohs74Weci
	 PAD+evlzZpGkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] KVM: s390: Fix leaking of PGM_ADDRESSING to
 userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727150254.236021-3-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
 <20260727150254.236021-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 15:33:20 +0000
Message-Id: <20260727153320.6828E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the `kvm_s390_se=
t_skeys` ioctl handler contains an O(N^2) retry loop that executes with pre=
emption disabled, which can trigger a hard lockup or RCU stall.
--

--- Patch [2]: [PATCH v3 02/10] KVM: s390: Fix leaking of PGM_ADDRESSING to=
 userspace ---
commit 175d33190557729485ae32f46f8a61bb29680d52
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix leaking of PGM_ADDRESSING to userspace

This commit fixes an issue where kvm_s390_set_cmma_bits() and several
storage key operations return positive error values (like PGM_ADDRESSING)
to userspace instead of standard negative error codes. It updates the
return logic to convert these positive values to -EFAULT.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index eff0644b8517d..8b7e7da354a25 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c

[ ... ]

> @@ -2274,7 +2274,7 @@ static int kvm_s390_set_skeys(struct kvm *kvm, stru=
ct kvm_s390_skeys *args)

[Severity: High]
This isn't a bug introduced by this patch, but looking at the loop just
above this return statement in kvm_s390_set_skeys():

	do {
		r =3D kvm_s390_mmu_cache_topup(mc);
		if (r =3D=3D -ENOMEM)
			break;
		scoped_guard(read_lock, &kvm->mmu_lock) {
			for (i =3D 0 ; i < args->count; i++) {
				r =3D dat_set_storage_key(mc, kvm->arch.gmap->asce,
							args->start_gfn + i, keys[i], 0);
				if (r)
					break;
			}
		}
	} while (r =3D=3D -ENOMEM);

Can this loop trigger a hard lockup or RCU stall?

When dat_set_storage_key() depletes the MMU cache and returns -ENOMEM, the
inner loop breaks. The outer loop will then refill the cache and restart
the inner loop completely from i =3D 0.

For large unmapped memory ranges, does this result in O(N^2) behavior where
the kernel re-traverses previously mapped pages over and over?

Since this entire process happens under scoped_guard(read_lock, &kvm->mmu_l=
ock)
which disables preemption, an unprivileged guest calling KVM_S390_SET_SKEYS
with a large count could potentially cause a local denial of service.

>  	kvm_s390_free_mmu_cache(mc);
>  out:
>  	kvfree(keys);
> -	return r;
> +	return r <=3D 0 ? r : -EFAULT;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727150254.2360=
21-1-imbrenda@linux.ibm.com?part=3D2
