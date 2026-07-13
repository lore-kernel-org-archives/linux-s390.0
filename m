Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F948276038
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953026; cv=none; b=TfwAbmBI4N1+scTTnuAOgEUgT6Ah58HtXJn4eV2TSPMtlDhI0/xw+fjALPA2po/Lfq4rUx9lgFJObKhp6kLiuGb0KcfQ+dFrqYfi6ChMReiwRl70whdF/99B5CTYaoffsWBCtvkOrGDr1hgv1V8/WYo+mC5+n69mx0Rb7fk9hBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953026; c=relaxed/simple;
	bh=BjH2Un7lmr0+75Y7kghhuw+R/0WwFN5y4wsaiWiG/kE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NfgPG9QhLMqcpI2yf+/R53pi3bksVwLhwyCU/tbwqoZIGptUXLOxa1EmY1nTcylrv8S3OieCOI2y4fchNun/donlBSCbLf0vQxezMcnuKwuucFyrgEhiYpynHztEuqFFq8IAYrE7MNhtYqec6P6A71HwcJFrdHe+4gGG8qjOAd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0w3NGvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0w3NGvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA041F000E9;
	Mon, 13 Jul 2026 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783953024;
	bh=i6tYAEV6lYNphvW2m0AAf9ygEjtiM5pzR4Ti7nf43EA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U0w3NGvsJA0e+30xoyBEHKtXI++ubTEJI0ziLPDUbPQzeVdq+SypjjNtW2G1cknFx
	 9qKFToXYd/E0L25aPptjfiG/cnBME2YddhLmXeh1JXANKidzPfuOWCgNMWVOOH2Hzv
	 WWHIFCpzy+ni4Ztn82WNFndHEh5+K0wu23ttohSqNlGgzu/ofeBs/GwHobb2DLco2y
	 8W4sDnFXzT211gFJ6BvAJFS6EK0++EpnsoeuPP6qwrBN2HQk354vRbk36943xbI5jG
	 5Q+AcfEUUteXStqnOnm00IwU+MtsC4Ww24JkffyLwjM4k6RTDmSkHOSAj8H7vWuvPt
	 TsgpuXO6gdOKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] mm/kasan: Introduce helpers for lazy MMU mode
 sanitizer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <38a663eeccd060d961990baf65338e2f2550e580.1783945507.git.agordeev@linux.ibm.com>
References: <cover.1783945507.git.agordeev@linux.ibm.com>
 <38a663eeccd060d961990baf65338e2f2550e580.1783945507.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 14:30:23 +0000
Message-Id: <20260713143024.5EA041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The newly introduced KASAN PTE helpers lack `EXPORT_SYMBOL`, whi=
ch will cause module build failures when utilized in inline page table acce=
ssors.
- [Medium] The generic `kasan_[un]poison_pte` API inherently conflicts with=
 KASAN tracking requirements on architectures where `sizeof(pte_t) < KASAN_=
GRANULE_SIZE` (e.g., 32-bit architectures), causing WARN_ON splats and sile=
nt shadow memory corruption.
- [Medium] KASAN poisoning of PTEs during lazy MMU mode fundamentally break=
s concurrent lockless PTE readers (e.g., GUP-fast), causing false-positive =
KASAN splats.
--

--- Patch [3]: [PATCH v5 3/4] mm/kasan: Introduce helpers for lazy MMU mode=
 sanitizer ---
commit ad7a1a1292ef9676ee173915cfe50c0da8ea27a4
Author: Alexander Gordeev <agordeev@linux.ibm.com>

mm/kasan: Introduce helpers for lazy MMU mode sanitizer

This commit introduces KASAN helpers to allow architectures to catch
illegitimate direct PTE accesses while lazy MMU mode is enabled. It provides
kasan_poison_pte() and kasan_unpoison_pte() routines, along with a new
KASAN_LAZY_MMU_PTE shadow bug type.

> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index b7d05c2a6d93d..cbf68680614e5 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
[ ... ]
> @@ -163,6 +163,16 @@ void __kasan_poison_slab(struct slab *slab)
>  		     KASAN_SLAB_REDZONE, false);
>  }
> =20
> +void __kasan_poison_pte(pte_t *pte, int nr)
> +{
> +	kasan_poison(pte, sizeof(*pte) * nr, KASAN_LAZY_MMU_PTE, false);
> +}

[Severity: Medium]
Since lazy MMU mode is generally a per-thread or per-CPU state, but KASAN
shadow memory is a globally shared mapping, will poisoning a live PTE page
here trigger false-positive KASAN splats for concurrent legitimate lockless
page table walkers?

For instance, if get_user_pages_fast() or handle_pte_fault() executes a
READ_ONCE() on another CPU against this PTE, it seems they would hit the
globally poisoned shadow memory.

[Severity: Medium]
On 32-bit architectures where sizeof(pte_t) is 4 bytes, kasan_poison() will
receive a size of 4 when nr is 1.

Since generic KASAN enforces an 8-byte alignment constraint, will this trig=
ger
the WARN_ON(size & KASAN_GRANULE_MASK) check?

[Severity: Medium]
If architectures call this helper from inline page table accessors like
ptep_get() or set_pte() in header files, will loadable modules fail to build
with undefined symbol errors?

It looks like this function and __kasan_unpoison_pte() are missing an
EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() declaration.

> +
> +void __kasan_unpoison_pte(pte_t *pte, int nr)
> +{
> +	kasan_unpoison(pte, sizeof(*pte) * nr, false);
> +}

[Severity: Medium]
kasan_unpoison() implicitly rounds the size up to the nearest
KASAN_GRANULE_SIZE, which is 8 bytes.

On 32-bit architectures with 4-byte PTEs, could unpoisoning a single PTE
inadvertently unpoison the adjacent PTE and corrupt its tracking state?

> +
>  void __kasan_unpoison_new_object(struct kmem_cache *cache, void *object)
>  {
>  	kasan_unpoison(object, cache->object_size, false);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783945507.gi=
t.agordeev@linux.ibm.com?part=3D3
