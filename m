Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEBF348C44;
	Wed,  1 Jul 2026 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922996; cv=none; b=oYfI9EX5dzO1DzmYOaOnng9NJ5/FYLa3mk4M1M1M2clf6vse1Jp4+i1FqP/OE0aMa3zI6MetvEn3l2ogUCAhVRI+y6HJvRuL6l4kbD3UFuVbxWUCNhuBHZ0sV5WFjOi9m2KGtg5RJOSo0dgUorA8LexzgOI0/wPHIYgws3mB4Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922996; c=relaxed/simple;
	bh=hDNpUu0PEHWS+pXEvSCdFkOmGMeGTtH7aHGP7brArgc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FhbVfbOUqGl3JmjcXClJyUyrb0dGATHoF9so5PereKJhaCYecaALKZU+8PZZ1a/rKBH9Fy0WOdcCoaakq+eWAjTa9Tbt0EfCQQwSXoENo1iZ5GX+jx0UyYQMl4R0qC2KMusSw0R/Ov3nOgtjRakklPh7WjrP/j2Q7ulroNb4EY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpG365Ps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpG365Ps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15631F000E9;
	Wed,  1 Jul 2026 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782922995;
	bh=JTCkUv13zxIAsMp8wRkdQ73fPrEsj5+zVAss7I7F4V8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VpG365PsaP05DeBjwCNh+lUts2w2jad54ZVYWobeza5qrfa6tpns9KbkyyrY4rHvN
	 LvwqkvPnQr5AGJa+oVsGshTLlhp/QroxNdPcXUQVbZflWZOpmoMQJvaKwyr/r5J6+0
	 spkm6to62lBXGGPOsjiHCCINdq1AYhO02rovynXm79JrL40ycCcd9dCOX1cEZqkXut
	 I6PXAa6CFtsztg2rNX3z3fu6CX8jt73YrYvsNS6UWitkbAtD7mWiBKJSC5q9FxNBJ0
	 32eQGuUPH5soNc87T8d1qqZR09DLPtdaNKVWHIPFnp0DjtIdLQ4iy5WfTTXdDIpkPU
	 8WEd0vf0niAGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/11] arm64/mm: Add set_memory_device() and
 set_memory_normal()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260701-tegra-vpr-v3-4-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-4-d80f7b871bb4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:23:14 +0000
Message-Id: <20260701162314.A15631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Misuse of aggregate PROT_* macros as masks corrupts memory typ=
es, permissions, and page table block structures.
- [High] Modifying live memory attributes (type/cacheability) without a Bre=
ak-Before-Make (BBM) sequence violates ARM64 architecture invariants.
- [High] Bypasses `can_set_direct_map()`, alignment checks, and boundary va=
lidation, leading to crashes on non-splittable linear maps.
--

commit 4153df151684415d2f2a476b7fbb71cc99c64650
Author: Chun Ng <chunn@nvidia.com>

arm64/mm: Add set_memory_device() and set_memory_normal()

Add helpers to swap PROT_NORMAL and PROT_DEVICE_nGnRnE protection bits
on a kernel-linear-map range.

> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index bbe98ac9ad8c6..871b59a6c9eaf 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -251,6 +251,22 @@ int set_memory_valid(unsigned long addr, int numpage=
s, int enable)
>  					__pgprot(PTE_PRESENT_VALID_KERNEL));
>  }
> =20
> +int set_memory_device(unsigned long addr, int numpages)
> +{

[Severity: High]
Does this bypass necessary linear map validation checks?

Unlike other helpers such as set_direct_map_invalid_noflush(), these functi=
ons
do not call can_set_direct_map(). If the kernel is booted with configuratio=
ns
preventing page-level splitting (like rodata=3Doff), the modification could=
 fail
or corrupt perfectly aligned PMD block mappings.

Additionally, should this validate address alignment and check __is_lm_addr=
ess()
before modifying the memory, similar to change_memory_common()?

> +	return __change_memory_common(addr, PAGE_SIZE * numpages,
> +				__pgprot(PROT_DEVICE_nGnRnE),
> +				__pgprot(PROT_NORMAL));

[Severity: Critical]
Will passing aggregate PROT_* macros as clear_mask and set_mask corrupt mem=
ory
types and page table structures?

When __change_memory_common() uses the clear_mask, it clears the bits prese=
nt in
the mask. PROT_NORMAL contains memory type index 0 (MT_NORMAL). Clearing 0
leaves existing memory type bits intact, meaning the subsequent OR of
PROT_DEVICE_nGnRnE (index 3) will combine with the old bits, potentially
resulting in an invalid memory type index.

Also, both PROT_NORMAL and PROT_DEVICE_nGnRnE include PROT_DEFAULT, which h=
as
PTE_TYPE_PAGE (binary 11). If this is applied to a PMD or PUD block mapping
(which has descriptor type PMD_TYPE_SECT, binary 01), clearing and setting
these bits will mutate a valid block descriptor into a table descriptor, ca=
using
a translation fault. Should this use explicit PTE_ATTRINDX masks instead?

[Severity: High]
Does changing the memory type from Normal to Device require a Break-Before-=
Make
(BBM) sequence?

The ARM Architecture Reference Manual requires a BBM sequence when updating
a live page table entry to change its memory attributes. __change_memory_co=
mmon()
modifies PTEs in-place via read-modify-write (update_range_prot) and issues
a TLB invalidation only after the writes complete.

Skipping the intermediate invalidation step (writing an invalid entry, issu=
ing
DSB/TLBI, and a second DSB before writing the new attribute) can cause hard=
ware
coherency issues and TLB Conflict Aborts.

> +}
> +EXPORT_SYMBOL_GPL(set_memory_device);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tegra-vpr-=
v3-0-d80f7b871bb4@nvidia.com?part=3D4
