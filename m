Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF21F30D41F
	for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296388; cv=none; b=fQmd6LutWltdlnjRbcSQW26Q+drtxWMouPYYl80IjRNa408+rnKnsk5WG6DC5e4L9pMLSa5TAtvedyyPN7dh1MnEiBndQH8uVWcw0WN1o55PM6sWKtA1LYqn/BhXu6pJ2HEwvSDdQAGmZuYvTsFYRxbuzRphmUHGvv6YnlHqVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296388; c=relaxed/simple;
	bh=5sHkKiGPoIRcqSBmSx/ZL/CoK3AO7T+uDPngD9+9bwY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jvl4Txmau8yfhi4u0HXcFGqWdDK6+b51f3VL/OpkxgQaGMtMTMAzqEGxYrEDyqR/NK8Nm0avO1h/2VuxyZ4Rb6JLP3PubjEeyAYaNlEoL7z34kzUFfGU52t++XxdOMs+YXBKZo5IeyPlRY90xtW0cdtPiWi8eqxsylzr5rHyEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM5H0p9H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM5H0p9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C571F000E9;
	Fri, 17 Jul 2026 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784296387;
	bh=lRz11oMvPbPyA1p8kBomcj8NGrvv0//PypVAULJ3zvs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SM5H0p9HRKw2ST8nrZU/+AQoMu2J7fvt5VGvyJk9gSDk7oCNCWU8ssP3ylvtAE3gY
	 L2p8yW2n5+5bxEFKfbN1+MRYjemmTJKVCGssKHa46tOi7aCPD11gqt9a+wlGkWLcDl
	 cF/frJsurCwI3gJFRhx1BVB6BrLOAhsweuk5BaALbEUFbn3sONU2z/iAzMbSulUy8s
	 TJJHydqLUoQ8wLoZ96zilHeIBj6WcI0Kdf44xtcd91h+M4VPl40i1SWlWQXYf7AxHJ
	 R+amAxW8JsM3XLiOH+cup7QwpCCHxOAhWvQp/+NOeDZorF9eWWirAZl7kDzFLIig0B
	 7KKTcAtmOAZ6Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/4] mm: use proper PTE accessors in madvise() and
 mremap()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <3c4d3c768ebf9cc7bbc7667e0e08bf5ad2fe8729.1784292223.git.agordeev@linux.ibm.com>
References: <cover.1784292223.git.agordeev@linux.ibm.com>
 <3c4d3c768ebf9cc7bbc7667e0e08bf5ad2fe8729.1784292223.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:53:06 +0000
Message-Id: <20260717135306.E8C571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Calling `set_pte()` on an uninitialized stack variable causes =
undefined behavior, stack memory reads, and potential kernel panics.
--

--- Patch [1]: [RFC PATCH 1/4] mm: use proper PTE accessors in madvise() an=
d mremap() ---
commit 75c34d0a3dcbb3f5f12f6bd64e11ac6572b6f8f8
Author: Alexander Gordeev <agordeev@linux.ibm.com>

mm: use proper PTE accessors in madvise() and mremap()

This commit converts direct page table entry pointer dereferences to use
the proper accessors in madvise() and mremap().

> diff --git a/mm/madvise.c b/mm/madvise.c
> index 07a21ca31bad4..77508ef1c1836 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1106,7 +1106,7 @@ static int guard_install_set_pte(unsigned long addr=
, unsigned long next,
>  	unsigned long *nr_pages =3D (unsigned long *)walk->private;
> =20
>  	/* Simply install a PTE marker, this causes segfault on access. */
> -	*ptep =3D make_pte_marker(PTE_MARKER_GUARD);
> +	set_pte(ptep, make_pte_marker(PTE_MARKER_GUARD));

[Severity: Critical]
Is it safe to use set_pte() here?  In this code path, ptep is an out-parame=
ter
pointing to an uninitialized stack variable rather than a live page table
entry.  This can be seen in the caller walk_pte_range_inner() in mm/pagewal=
k.c:

	pte_t new_pte;
	err =3D ops->install_pte(addr, addr + PAGE_SIZE, &new_pte, walk);

Because ptep points to the stack and not a live page table, this violates t=
he
architectural API contracts of set_pte().  For example, on arm64, set_pte()
calls __ptep_get() which reads the uninitialized stack memory and passes it=
 to
WARN_ON_ONCE(). On other architectures like Xen PV or PowerPC, set_pte() ex=
pects
a live page table mapping and can trigger hypercalls or specific cache flus=
hes
using a stack address, potentially leading to crashes or unpredictable beha=
vior.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784292223.gi=
t.agordeev@linux.ibm.com?part=3D1
