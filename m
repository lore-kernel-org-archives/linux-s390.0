Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426A84156E9;
	Mon,  3 Aug 2026 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777139; cv=none; b=fIUkVaZRb+Ddsa4K3rc+iXbWi3J+djijARo64YwQG6xUVboSVf/FBDE/eJ++L4Qc3CUS5dnN9a64zjQs/drFkJxIOstq0H8DSZ6yA45b9d1umyUpNQcSyq/oG9+YdyJQuOASuBe1pwEM2HtKHYef3HfB1fKcQRldwvPiZq45B2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777139; c=relaxed/simple;
	bh=8AubUCwyZCXMPyv16OVR5FAkeYaucDfyMhhKZoi2sC4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MKqtsvZqWQTvyOrK/ZIJ/I2LehEf/tdqrDz49DcxlZ/7G0nJWXeFdlBTc77qAP7wfNAzFizRzyRiIQd26xdPujAB3fVpxl4imvLKAQsfOiRh8Bugp1N5z//w6eeHidrflFKcjQrU10LQP8/Ir3uDPRgU+k/OPPbFJq/ZZFACGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwA7UPj5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwA7UPj5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880EE1F000E9;
	Mon,  3 Aug 2026 17:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785777138;
	bh=V5cOi49fp92wCr6MeVijSfU8f7dme53hfcZ5eT1o99I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZwA7UPj5+fuh8X4hCabYAonVTFvwARvjlyt+DMsJLToLLfWfjMWrSQpu48AbLrKBr
	 gpKGh/ve4CsPtsNkUaw6Qq3t7+gKi4qhjxa+1FSSX9bCcZ9FtUS3tqP61M2ww2x6+U
	 XYjYwgtrgSHYiwvIbKKo+dahInhjMva6hgpchDcVsQ9k7cDONLTL7X9BNZT6fcjXBY
	 5v5l8bX9J4lq3sW2I8OjgkscQCOLxKY85X9poQXjuCJz08k0Qe0bX7BjP+8KXRa6VC
	 IQN48khSFTHp4a3SfUuwLBTk0mkbXY8wyQbImjn4mDjD0RWW2G0AXI8cczTzdkfFkJ
	 tK824xGA8yBLg==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 18/23] KVM: s390: cmma: Fix dirty tracking when
 removing memslot
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260803160924.236807-19-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-19-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 17:12:17 +0000
Message-Id: <20260803171217.880EE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Mixing of `goto`-based error handling with scope-based cleanups =
(`__free()` and `guard()`).
--

--- Patch [18]: [GIT PULL v1 18/23] KVM: s390: cmma: Fix dirty tracking whe=
n removing memslot ---
commit b4b4bb1a465e2a5c28c8cf71b60ac80548c5f396
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: cmma: Fix dirty tracking when removing memslot

This patch fixes CMMA dirty tracking when a memslot is removed during
migration mode. It also opportunistically updates the memory region commit
path to use the __free() cleanup helper for the MMU cache.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index e5c5e9f61cb24..ba811f0673d10 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
>  void kvm_arch_commit_memory_region(struct kvm *kvm,
>  				struct kvm_memory_slot *old,
>  				const struct kvm_memory_slot *new,
>  				enum kvm_mr_change change)
>  {
> -	struct kvm_s390_mmu_cache *mc =3D NULL;
> +	const struct dat_walk_ops ops =3D { .pte_entry =3D cmma_d_count_pte, };
> +	struct kvm_s390_mmu_cache *mc __free(kvm_s390_mmu_cache) =3D NULL;
>  	int rc =3D 0;
> =20
> +	guard(mutex)(&kvm->slots_arch_lock);

[Severity: Medium]
Does this code mix goto-based error handling with scope-based cleanups?

According to the guidelines in include/linux/cleanup.h, functions should
convert all resources that need a goto cleanup to scope-based cleanup,
or convert none of them. This function introduces guard() and __free()
declarations here, but it still retains the `out:` label and the `goto out;`
error path when kvm_s390_new_mmu_cache() fails.

Also, is it possible to combine the __free() declaration and initialization=
 of
mc at the point of allocation? Declaring it at the top as =3D NULL and
assigning it later makes LIFO ordering mistakes more likely. Could the goto
path be replaced with a direct return, and the mc variable be defined where
it is first allocated?

[ ... ]
> @@ -5851,7 +5873,6 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
>  out:
>  	if (rc)
>  		pr_warn("failed to commit memory region\n");
> -	kvm_s390_free_mmu_cache(mc);
>  	return;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D18
