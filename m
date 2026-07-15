Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98273330656
	for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2026 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123631; cv=none; b=TyyW7MxhQfKaVJgWdJ6P6wKlOWUxk8tULMjP/LjI0irVPWBKVNDPVPAo4MgVdpnP4EvUsb/WHkY4XtpYClenihdm4TGfv53Yh9aI7Gh3pkxgKc0XQG7xrdlH3gbcGJieSUm/NHxM/AAp90JreXZMrshae/koq3N8A2z+f/x31BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123631; c=relaxed/simple;
	bh=xR5GrUQO8cS718UiAZEgzs3RlVSXphXnlBSWfQ6Iorw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hcz+iPudu3sv93p5HffmjdoZN/N3CmAToSUePa64hPBe96NmdqcfcuYDiDg0mUbLnAdXM+5E9wAH3wM6HIf17ZLeli+BdX4C+iZWT6gDCT2wLHDOPDviRoN2nvFiFPJk0kD6+51xLRYK9NRxDUQkTuj6ILl+iE9YAGDYZLjyYTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaerzoGu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaerzoGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9F61F000E9;
	Wed, 15 Jul 2026 13:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784123630;
	bh=DT0iNnWK4kiR4lgtc0EArnSgq1lwT0z2hCluUU2utnk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iaerzoGu4TX8WaXluzWy2XFy5vX50mvC3GbblXJeGxHd+b+1N1MphmQQgOrWPqLm6
	 qkYksPHOB49/cSzl5/I7R72MrkO8I/2kpAZcUBisiHnDdw1yI2SLllMYGN/Q6Xgyte
	 bUTkAN+8a8LZIc3q8sGd2eBRxZUyqFvM9bdfeKZzwfJymS464XPagP82fmE+RvAYZt
	 jmSEnbsdCzQ00fyFgqUGTJ+KpPPXFhoDYvo7ak2B7rh2a/BbykuFQ840KeROhZo4c6
	 h4LhFd90oXan+Yz/hFzhJx3EPEfdg/ksyNIP0SPO542tHtGQuKD71A70ti98BBV+3f
	 5o0jxHHk5RoZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] mm/kasan: Introduce helpers for lazy MMU mode
 sanitizer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <a5bf7ac327864193bb7c95d8575d6ce1f6a9576c.1784121418.git.agordeev@linux.ibm.com>
References: <cover.1784121418.git.agordeev@linux.ibm.com>
 <a5bf7ac327864193bb7c95d8575d6ce1f6a9576c.1784121418.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 13:53:49 +0000
Message-Id: <20260715135350.3B9F61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Use of undeclared architecture-specific type `pte_t` in uncondition=
ally compiled function prototypes causes a build failure when KASAN is disa=
bled or HW tags are used.
--

--- Patch [3]: [PATCH v6 3/4] mm/kasan: Introduce helpers for lazy MMU mode=
 sanitizer ---
commit 347acc32deb780b8050b3a731ff67d7198bd0478
Author: Alexander Gordeev <agordeev@linux.ibm.com>

mm/kasan: Introduce helpers for lazy MMU mode sanitizer

This patch provides new KASAN helpers that allow architectures to implement
and sanitize direct PTE accesses while lazy MMU mode is enabled. It is
specifically intended to address direct PTE accesses on s390.

> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index bf233bde68c7e..deadf566b84ad 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -134,6 +134,20 @@ static __always_inline void kasan_poison_slab(struct=
 slab *slab)
>  		__kasan_poison_slab(slab);
>  }
> =20
> +void __kasan_poison_pte(pte_t *pte, int nr);
> +static __always_inline void kasan_poison_pte(pte_t *pte, int nr)
> +{
> +	if (kasan_enabled())
> +		__kasan_poison_pte(pte, nr);
> +}

[Severity: Low]
Does this introduce a build failure when CONFIG_KASAN is disabled or when
hardware tags are used?

include/linux/kasan.h uses pte_t in the prototypes for kasan_poison_pte()
and kasan_unpoison_pte(), but it does not appear to include
<linux/pgtable.h> or <asm/page.h> beforehand.

If a C file includes <linux/kasan.h> (for example, indirectly via
<linux/ioremap.h>) before the page table headers, the compiler will fail
with an undeclared type error for pte_t. This will affect both these
declarations and the dummy stubs defined further down in the file.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784121418.gi=
t.agordeev@linux.ibm.com?part=3D3
