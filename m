Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863013;
	b=IyXuKOskHlEUjUqhTeHhu7SY0sn5ORsZMtzcgjvjaQXhtw2tx1qxfiIhushKM1B6I6mj
	 yMZt8idpEHHsqBrw4qoiD4mrkRD2QiPpQ2EmAl85xP5hj1vuB3BkhLupVaHtjmih4/J4r
	 1K79KpcjUYsnoRrUEaKd2X535yz074aS8kPnzcRhNSIik+QVaslBSRFa6Aigj13AjzawO
	 GAaUrbWYuz1h09kdUc/v00thpAh8WY4VndS8XzuUKSvzrln5V+SIoholkTHcPr9hj/aDj
	 +apoMaqJVHcJXf+YmIuXgDkmR7LZaY8fg7trXLUUFLa9QFPNo/NLEJhmnnA55njjrFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863013;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yklh8vYj0UXnqUyJIMwNZihY2Dzfm6RgE/a4D51hGLA=;
	b=qP302HvtFVcfbSNzZVZrMx1GUyUTvpkiawnn1BONwlVWGPMRhUna+cXLMyywQu37Zd1d
	 gorFXRUfxA82vvzHF+ewRIKyNkLbxpNR067k8Mc4aGKZwyQlU/EgmeAaAOWZvVFwshh7v
	 gugdwp/yQZe46yBzv2OeifJCsHgfRPRWG47cadNCen2pNNeabrYPfm31ERS1agqukwzY8
	 g2LSWVEVEovnRAlZ5o03mVnzCQCfei6H/FtKvzVq2aFDMoET708BlTXrxtxa3Ncx58wcJ
	 64XEzAbT+bnBpwfuQK8uBKnCwMF4RuTmHGfsGzqoGrA167HZN0BO99d8iLKCuhN+ZUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJVSDYyj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8E606A31B
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJVSDYyj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFD61F00919;
	Thu,  5 Nov 2026 07:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863012;
	bh=yklh8vYj0UXnqUyJIMwNZihY2Dzfm6RgE/a4D51hGLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cJVSDYyjPXxstNjrsuGugagaGgQ+jN6u/iQbhDVMB9vHl0dlcgSN//irWMcliniUf
	 DzqL0d2K923Rjhzg+kwmmwZACl0/K0gGEd8G+S6/nD15Zw41+/H5tHLm3cF5GmeQHf
	 67GOy6/LnCrqkiW7iuVGjcsAWdI4PdFnOzz95ntvua1ml/IVHo8QE9A53g/SxlcTEF
	 knGz6a9U12Xprvd6kccYTTnQGU34mEABNQEW6sxNE7ZeyzCy9bWxdQWrR/Qk+9XSQz
	 zkr1j3nYw3fAb67N72l9phZdDowwf2OF76J5UDIJZPmZEiv8DQTxscO2kJnoxKS0hN
	 ABx0DLIvEDEtw==
Message-ID: <sashiko-outbox-198654@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] mm/sparse-vmemmap: drop vmemmap_can_optimize()
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
In-Reply-To: <20261105061217.13302-5-songmuchun@bytedance.com>
References: <20261105061217.13302-1-songmuchun@bytedance.com>
 <20261105061217.13302-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 07:16:50 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm/vmemmap: undeclared vmemmap in section_vmemmap_optimization_disa=
ble()
--

commit f0544b0eb7001e7264ebe693d049cf0cf0631ccd
Author: Muchun Song <muchun.song@linux.dev>

mm/sparse-vmemmap: drop vmemmap_can_optimize()

This commit removes the DAX-specific vmemmap_can_optimize() helper and reli=
es
on section_vmemmap_optimizable() and section_vmemmap_optimization_disable()
to decide whether a section uses vmemmap optimization.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a060a71504015..2fa5ce73b382a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -38,7 +38,6 @@
>  #include <linux/bitops.h>
>  #include <linux/iommu-debug-pagealloc.h>
>  #include <linux/kcsan-checks.h>
> -#include <linux/vmemmap-optimization.h>

[Severity: Low]
Does this cause a build regression on LoongArch 64-bit configurations with
CONFIG_VMEMMAP_OPTIMIZATION enabled (such as loongson64_defconfig), or when
linux/vmemmap-optimization.h is included before asm/pgtable.h defines
vmemmap?

In arch/loongarch/include/asm/pgtable.h, asm/page.h (which pulls in
include/asm-generic/memory_model.h) is included first, defining:

    #define __page_to_pfn(page)	(unsigned long)((page) - vmemmap)

Later in arch/loongarch/include/asm/pgtable.h, linux/vmemmap-optimization.h
is included so MAX_FOLIO_VMEMMAP_ALIGN is available before defining vmemmap:

    #include <linux/mm_types.h>
    #include <linux/mmzone.h>
    #include <linux/vmemmap-optimization.h>
    ...
    #define VMEMMAP_ALIGN	max(PMD_SIZE, MAX_FOLIO_VMEMMAP_ALIGN)
    #define vmemmap		((struct page *)(ALIGN(VMALLOC_END, VMEMMAP_ALIGN)))

Because section_vmemmap_optimization_disable() in
include/linux/vmemmap-optimization.h is a static inline function that calls
page_to_pfn():

    static inline void section_vmemmap_optimization_disable(unsigned long s=
tart,
            unsigned long end)
    {
        unsigned long pfn =3D page_to_pfn((struct page *)start);

the preprocessor expands page_to_pfn() at the point where
linux/vmemmap-optimization.h is included, before the vmemmap macro is
defined, leaving an undeclared vmemmap identifier in the function body.

Additionally, removing the linux/vmemmap-optimization.h include from
include/linux/mm.h (where it was placed after linux/pgtable.h) means any
translation unit that includes linux/vmemmap-optimization.h before
asm/pgtable.h on architectures where vmemmap is defined in asm/pgtable.h wi=
ll
hit the same undeclared vmemmap error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105061217.1330=
2-1-songmuchun@bytedance.com?part=3D4
