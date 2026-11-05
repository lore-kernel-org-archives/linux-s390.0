Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863010;
	b=w2tHfVA44flZ1KmEsAAo3PNCseqew0+OuW1J/NgGszO4QLXgq1wdVhR6clxVrHi2ldj/
	 uIsF+M0ETLiNisRSplupEkrGJ7yEVjbsvgPjdyLq57MLDrGdpe8GFk1px7R/qlqc8qNOG
	 4/V/u2RpF3Br2kK4Fjsoc7uWnP+KSXH9mn+D1Qq/gyV6rwr1x20dLHUoMDpvifGX8IAbp
	 V1m78aqNybsAdltnAZg/N8EFYTTwcTu/Tcae8iEbP78j4E2iqkfr9yk7kv3NeBXK4ne7G
	 pR65Un0eNSTiP8MZczCfk9diF13GGchBX4g/2DaU3obKESRqNxZJi6Z7j6nHVSsTftw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863010;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oejeWNhQX2tZnGny/UGddApTW2mUljlFgEnUYOZYHz8=;
	b=mBrFbDBThgea0Vf29BbMMycmJD4aoA1+oGr9KPGTRHg3IQJqben+VNermd7/1YjHAFhG
	 1S1qZjl5z+HEfYyNWS6mCkDBzPVDPziTDXNyD+IlapmUCZ0Lmd6Jv1Ra44H2SQ8p7kg9S
	 RD9ZmkK9Kf/gE8/YNKmb5maw+zYc2LPfzMVzrdVDI+OPUqqhEhrsDZwTHlNFDgGPT/wRW
	 aaypsPf3AC6ZzfnzukXUexeK6sYADInwej+Mfc+2ytDs8MnzFdHQPDFElKevD1JeOfDWE
	 /hg8Jjmgqamvoy/6ivzD6aMdgUB6womH9QZdtzqTMKU5HawtqtBDT+7d7M68ZrIpw0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZ0sycGB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C24606A328
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZ0sycGB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7871F00919;
	Thu,  5 Nov 2026 07:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863010;
	bh=oejeWNhQX2tZnGny/UGddApTW2mUljlFgEnUYOZYHz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nZ0sycGBAxvzOQlpEE7wGvPoWFX47ogBO3TANDIIIASrSXAWHfkI03irpSQJBlT9M
	 SRXGKWD3UGa8Qx82oEwpRONezuJHT0Jr+TchBCAVYZWQk7aRlUkWyQ17uq9prjVoHs
	 hJIXwzhVlYTpJjbzA/cOl62UUhhgYPRgYKF3clJzAhV35amMKiSrE8i0zxE+cSq74F
	 s4+agZEUsAPtrBTUeomgbDUYtFM4P1zMbL1H03fScBw5DIUkyS3qmO4AkMuedkxyC6
	 9afUAsOdzMuDSVQa0bonkIsJCPD7hxJo6SX38zin9378io5fUiOI2pm1rWzsuOfKxS
	 PnuUPH6GN5I/Q==
Message-ID: <sashiko-outbox-198652@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] powerpc/mm: drop powerpc vmemmap_can_optimize()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muchun Song" <songmuchun@bytedance.com>, "David Hildenbrand" <david@kernel.org>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Mike Rapoport" <rppt@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>
Cc: "Lance Yang" <lance.yang@linux.dev>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy" <chleroy@kernel.org>, "Ritesh
 Harjani" <ritesh.list@gmail.com>, "Shrikanth Hegde" <sshegde@linux.ibm.com>, "Oscar
 Salvador" <osalvador@suse.de>, "Qi Zheng" <qi.zheng@linux.dev>, "Muchun
 Song" <muchun.song@linux.dev>, "Huacai Chen" <chenhuacai@kernel.org>, "WANG
 Xuerui" <kernel@xen0n.name>, linux-mm@kvack.org, x86@kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105061217.13302-3-songmuchun@bytedance.com>
References: <20261105061217.13302-1-songmuchun@bytedance.com>
 <20261105061217.13302-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:16:48 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] mm: undeclared vmemmap in section_vmemmap_optimization_disable()
- [Low] mm: define vmemmap_optimizable_order() before section_vmemmap_optim=
izable()
--

commit e51c76b2ae2d335e25edd03780c815eb467b564b
Author: Muchun Song <muchun.song@linux.dev>

powerpc/mm: drop powerpc vmemmap_can_optimize()

This commit adds section_vmemmap_optimization_disable() to disable vmemmap
optimization in architecture fallback paths such as PowerPC Hash MMU, and
removes the PowerPC-specific vmemmap_can_optimize() override.

[ ... ]

> diff --git a/include/linux/vmemmap-optimization.h b/include/linux/vmemmap=
-optimization.h
> index 858311a71b0cc..5c09da4df4d83 100644
> --- a/include/linux/vmemmap-optimization.h
> +++ b/include/linux/vmemmap-optimization.h
> @@ -57,6 +57,27 @@ static inline void section_set_compound_order_range(un=
signed long pfn,
>  		section_set_compound_order(__nr_to_section(section_nr + i), order);
>  }
> =20
> +static inline bool section_vmemmap_optimizable(const struct mem_section =
*section)
> +{
> +	return vmemmap_optimizable_order(section_compound_order(section));
> +}

[Severity: Low]
Will moving section_vmemmap_optimizable() here break the build at this
commit when CONFIG_VMEMMAP_OPTIMIZATION is enabled?

At this point in include/linux/vmemmap-optimization.h,
vmemmap_optimizable_order() has not been declared yet and is only defined at
the end of the header after the #endif for CONFIG_VMEMMAP_OPTIMIZATION:

include/linux/vmemmap-optimization.h:
    static inline bool vmemmap_optimizable_order(unsigned int order)
    {
        if (!IS_ENABLED(CONFIG_VMEMMAP_OPTIMIZATION))
            return false;
        ...
    }

Compiling translation units that include linux/vmemmap-optimization.h with
CONFIG_VMEMMAP_OPTIMIZATION=3Dy fails with an implicit declaration of
vmemmap_optimizable_order() followed by a static declaration following a
non-static declaration.

A later commit in the series ("mm/sparse-vmemmap: drop
vmemmap_can_optimize()") moves vmemmap_optimizable_order() above the
#ifdef CONFIG_VMEMMAP_OPTIMIZATION block. Could that move of
vmemmap_optimizable_order() be done in this patch instead to keep the series
bisectable?

> +
> +static inline void section_vmemmap_optimization_disable(unsigned long st=
art,
> +		unsigned long end)
> +{
> +	unsigned long pfn =3D page_to_pfn((struct page *)start);

[Severity: Low]
Could calling page_to_pfn() inside section_vmemmap_optimization_disable()
cause a build failure on architectures such as LoongArch that include
linux/vmemmap-optimization.h before defining vmemmap?

When CONFIG_VMEMMAP_OPTIMIZATION (and therefore CONFIG_SPARSEMEM_VMEMMAP) is
enabled, page_to_pfn() in include/asm-generic/memory_model.h expands to
reference vmemmap:

    #define __pfn_to_page(pfn)	(vmemmap + (pfn))
    #define __page_to_pfn(page)	(unsigned long)((page) - vmemmap)

However, include/linux/vmemmap-optimization.h does not include a header that
defines vmemmap, and arch/loongarch/include/asm/pgtable.h includes
linux/vmemmap-optimization.h to obtain MAX_FOLIO_VMEMMAP_ALIGN before it
defines the vmemmap macro:

arch/loongarch/include/asm/pgtable.h:
    #include <linux/mm_types.h>
    #include <linux/mmzone.h>
    #include <linux/vmemmap-optimization.h>
    #include <asm/fixmap.h>
    #include <asm/sparsemem.h>
    ...
    #define VMEMMAP_ALIGN	max(PMD_SIZE, MAX_FOLIO_VMEMMAP_ALIGN)
    #define vmemmap		((struct page *)(ALIGN(VMALLOC_END, VMEMMAP_ALIGN)))

Because section_vmemmap_optimization_disable() is a static inline function
parsed before the vmemmap macro is defined, doesn't vmemmap remain an
undeclared identifier in page_to_pfn() when compiling on LoongArch with
CONFIG_VMEMMAP_OPTIMIZATION enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105061217.1330=
2-1-songmuchun@bytedance.com?part=3D2
