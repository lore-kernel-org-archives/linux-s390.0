Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790033F5AA
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787081870; cv=none; b=ira7KGzREhj6wEQsCZ67RahOGSg37w80RcZJ6X4AmGGFVsLV6aAlzWrK0URRw3RasoxWdFafng3/cKRc80GUTntHdiylJfnNwsY9VARQdGgyXqhr2M6huDpwleEjjlwmaGXpgE8s6Gys0F0xMpRPzSKx4vuhO2E7IiqbWywfR1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787081870; c=relaxed/simple;
	bh=uZpWAWPEvKFu155IN2h1xBan0S2+zcq0NwtyknPYZFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ras9aukPQmrV7NFPvb65YrDnK5KIs3Vx9FtQQrc0HJGQInAZ49DvYAqzTSGDHdQH00pkeVGJ6edCIChNYQJDNCskj7Q5kW6OfivaEB3F1sqMdfbGbAxS/kGJLGMo3thc5LtMrE3t5fnqMdCqytdCwULn0NuyZp5p2DMP8kAwPf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9ZxcV/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9ZxcV/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B503E1F000E9;
	Tue, 18 Aug 2026 19:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787081869;
	bh=0A/Gyk0okcb2ExFAYDhyy48euWubFHi5tvgcnRuVOPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A9ZxcV/S4/rt/O5u+vJYclR0FQksu6f6iVxYYD6uo9fAyt7WVgZIlGIJ8YEFz2KSJ
	 W/ULz9G6BViTnIaxfx7JWYqeM6yWIS+A5MrEkGqqYQo6D06RbUMoQ+BNlSn5TIMmV0
	 vwOKpdx6KbfxA03uMLcUkMcwWJTxLCgiPlspPYMGMtsK+GHFcoc3siLor0Sr8rNaAi
	 wUPKOQohFyHctDAtzKg4S27S8F8tZwUE0GhcrmQCPbjm60SrD9pxVflXKoSVeFy3tR
	 PHzmOdoKU6jUqcn/J4YtQv7AEBzVtweNfBeMkZulDakWwqXZS5xcdz7yZbNVDXYJw4
	 onLwfTcb6hsBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] iommu/s390: Fix NULL dereference in iova_to_phys() with
 ZPCI_TABLE_TYPE_RFX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260818-iommu_fix_iova_to_phys-v1-1-1cd76d2a55b8@linux.ibm.com>
References: <20260818-iommu_fix_iova_to_phys-v1-1-1cd76d2a55b8@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 19:37:48 +0000
Message-Id: <20260818193748.B503E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Intermediate IOMMU translation tables are dynamically allocated du=
ring map/unmap but never freed when empty, allowing an attacker to exhaust =
kernel memory.
- [High] IOMMU unmap operations needlessly allocate page tables with GFP_AT=
OMIC when unmapping unmapped regions, which wastes memory and causes unmap =
failures if allocation fails.
--

--- Patch [1]: [PATCH] iommu/s390: Fix NULL dereference in iova_to_phys() w=
ith ZPCI_TABLE_TYPE_RFX ---
commit 87f13b9b4d2f1a6021028f52263833bccd842526
Author: Niklas Schnelle <schnelle@linux.ibm.com>

iommu/s390: Fix NULL dereference in iova_to_phys() with ZPCI_TABLE_TYPE_RFX

When using a 5-level translation table via ZPCI_TABLE_TYPE_RFX,
get_rso_from_iova() can return NULL when the region-first entry is invalid.
This patch prevents a NULL pointer dereference by adding a missing NULL
check for the region-second origin before accessing it.

> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index f148f559ac564..58ca7727b7f24 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -974,6 +974,8 @@ static unsigned long *get_rto_from_iova(struct s390_d=
omain *domain,
>  	case ZPCI_TABLE_TYPE_RFX:
>  	case ZPCI_TABLE_TYPE_RSX:
>  		rso =3D get_rso_from_iova(domain, iova);
> +		if (!rso)
> +			return NULL;
>  		rsx =3D calc_rsx(iova);
>  		rse =3D READ_ONCE(rso[rsx]);
>  		if (!reg_entry_isvalid(rse))

[Severity: High]
This is a pre-existing issue, but is it possible to exhaust kernel memory
with intermediate IOMMU translation tables?

Looking at dma_walk_cpu_trans() in drivers/iommu/s390-iommu.c:

drivers/iommu/s390-iommu.c:dma_walk_cpu_trans() {
    ...
    sto =3D dma_get_seg_table_origin(&rto[rtx], gfp);
    if (!sto)
        return NULL;

    sx =3D calc_sx(dma_addr);
    pto =3D dma_get_page_table_origin(&sto[sx], gfp);
    ...
}

These intermediate tables are dynamically allocated unconditionally, but
they appear to only be freed during domain destruction:

drivers/iommu/s390-iommu.c:dma_cleanup_tables() {
    ...
        for (rtx =3D 0; rtx < ZPCI_TABLE_ENTRIES; rtx++)
            if (reg_entry_isvalid(domain->dma_table[rtx]))
                dma_free_seg_table(domain->dma_table[rtx]);
    ...
}

Can an unprivileged user with VFIO access repeatedly map and unmap pages
at large strides across a huge IOVA aperture to leak these dynamically
allocated intermediate tables and cause an out of memory condition?


[Severity: High]
This is a pre-existing issue, but does unmapping an unmapped region
needlessly allocate page tables?

Looking at s390_iommu_invalidate_trans() in drivers/iommu/s390-iommu.c:

drivers/iommu/s390-iommu.c:s390_iommu_invalidate_trans() {
    ...
    for (i =3D 0; i < nr_pages; i++) {
        entry =3D dma_walk_cpu_trans(s390_domain, dma_addr, GFP_ATOMIC);
        if (unlikely(!entry)) {
            rc =3D -EINVAL;
            break;
        }
    ...
}

When encountering an unmapped hole, dma_get_seg_table_origin()
unconditionally allocates missing page table directories:

drivers/iommu/s390-iommu.c:dma_get_seg_table_origin() {
    ...
    rte =3D READ_ONCE(*rtep);
    if (reg_entry_isvalid(rte)) {
        sto =3D get_rt_sto(rte);
    } else {
        sto =3D dma_alloc_cpu_table(gfp);
    ...
}

If this atomic allocation fails under memory pressure during a bulk unmap,
would the loop abort and return an error? Could this leave any remaining
pages in the requested range fully mapped in the IOMMU while the kernel
potentially frees the underlying physical memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-iommu_fix_=
iova_to_phys-v1-1-1cd76d2a55b8@linux.ibm.com?part=3D1
