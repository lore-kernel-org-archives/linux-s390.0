Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B7448AE15
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040981; cv=none; b=P+rsw793uEbfdS0MJfeiToHn19XIBqK4IGk5dr439QQOBbiuHfmJadRfyOgHoegDF67fMoboja0eeYbvSiRBrQ46Uam+3jbNj4qyx7RJUy2W+jIivIaYlu/FhnF/eyd3cgQdogoa0FPVSlvPOjeKAr2LVj43DqBmVq3Cdgz1R2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040981; c=relaxed/simple;
	bh=5JfPAWKh6vT8PkEJtBPviRvgp/CPC9N8IJ6cdJdxrEM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pSWCW7S3ssefMWUNoAz1C7yyiPmJoLV7irnNtqjJLh164zjQm2NDnnR7SHzW4nTQaXc2o7buTrwi2A1E6Y4iDQ/xyYGKTPzw9gVBKbcGz+bdTirh6csycQpUMGy/OhjD+g3yMh4bAPPxtVy4QTom2KhZ0yEhuIqg4tK3aGAabac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEXpWRqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEXpWRqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049841F00A3A;
	Tue, 14 Jul 2026 14:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784040980;
	bh=2RYdTq+gYczVW4aA6jRxLIWaR+XvVyXXFBQrwM7LaFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AEXpWRqnDGKhRZWfAINAmnXIb6iYCjDiEaZQmO6Ygqqih4+1v89CtENAZuPiuWCgA
	 GnA9d5E1nH6MNWvJISBSNuRtEEy3BYe/CIJBgVtqgt6JoqLHQpt4r8sveZRJnrLnSG
	 s4aRUq0Q/pQfgF7cZIHKhONz5VRymrrHva5JyAL9luX8+KT5QHTeHIQ8nBeJosZ9Zv
	 iKgJRXC0+hZVMHqEQBYtUuNNG1rPKuAbX+xzUaW1beCtePyBpthRUNvyv0mUDht12j
	 yB5HBYaD0xgBsB23dXwKcCLBggliBqbvtcPFE5jLbPu9SndG0USw1z/cP8H8XC3wIx
	 JzIsbBhbid+Gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 20/22] arm64: mm: drop ctor/dtor calls for kernel page
 tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kevin Brodsky" <kevin.brodsky@arm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-20-44be8a7685d7@arm.com>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-20-44be8a7685d7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 14:56:19 +0000
Message-Id: <20260714145620.049841F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Kernel page tables allocated during memory hotplug leak the NR_PAG=
ETABLE stat and retain the PG_pgtable flag when freed, causing a buddy allo=
cator BUG on reallocation.
--

--- Patch [20]: [PATCH 20/22] arm64: mm: drop ctor/dtor calls for kernel pa=
ge tables ---
commit eb398eca88012b977463df47eaf81e1fcd66213d
Author: Kevin Brodsky <kevin.brodsky@arm.com>

arm64: mm: drop ctor/dtor calls for kernel page tables
   =20
This patch removes pagetable constructor and destructor calls for kernel
page tables, under the assumption that they no longer perform necessary wor=
k.
It also removes the pgtable level callback arguments from the early
allocation wrappers.

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index f723bcf68174f..f1400c6f68ba7 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c

[ ... ]

> @@ -1445,7 +1410,6 @@ static void free_hotplug_page_range(struct page *pa=
ge, size_t size,
> =20
>  static void free_hotplug_pgtable_page(struct page *page)
>  {
> -	pagetable_dtor(page_ptdesc(page));
>  	free_hotplug_page_range(page, PAGE_SIZE, NULL);
>  }

[Severity: High]
Does this cause the buddy allocator to reject the physical page and leak the
NR_PAGETABLE statistic during memory hot-remove?

By dropping the destructor call here, the PG_pgtable flag is no longer
cleared. Since free_hotplug_page_range() eventually calls __free_pages()
directly rather than using pagetable_free(), the required cleanup is entire=
ly
skipped.

If the buddy allocator later reallocates this page, check_new_page_bad()
will detect the leftover PG_pgtable flag, trigger a bad_page() warning,
and permanently leak the page.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-remove_pgt=
able_cdtor-v1-0-44be8a7685d7@arm.com?part=3D20
