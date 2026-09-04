Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA388372B27;
	Fri,  4 Sep 2026 11:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522579; cv=none; b=JBEnnE9nsGYqT4MZ2oficfM2v8Xx9/WzouqMSwfrOojB5jjtxgQsC1+69WCuf7eWMOaf5H+67I0ikwVRCo5Gz+xyBFu3TMCPAfitzQJp4YQCuMq+5tI0aggJ4NWkRWx6TTX+tv+XObgLXUHdnNaBwZxbHP55f6IlE+Zp5GCkfoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522579; c=relaxed/simple;
	bh=8ZpnG++Tpw6WZ1QHTT8ok/sLMpy7UZJ3KseWnAAoHYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t42aTqhRRnCxuK3cBegdx0UIGZ9A5+TfaHQjtdgt+QdMydltJUwScZnrKpXtOWsUrDDmQqPO5fMP1eqqgbQ59QRaFLOF9rLPqvlfUrWtfCl+p5ejwI9kuOFaZPmyAxVCXQSpFmvGaw6hU7l89sF3Qk3qiMtCtrKuCScoMCgV/ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXxmRfiz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXxmRfiz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA891F00A3D;
	Fri,  4 Sep 2026 11:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522577;
	bh=6X5f0ClUxMe0GJZCffHRr8tyViyUcOEcLYgyJDt0IoE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QXxmRfizVEpmuDf5lAQEvEx8C0v6F9xyy1cMF9eQsBrMs7KFedjkSSyvxrs4KDadh
	 Ufy1SUq253N8YUIeZB6QQZwNXPu8yXIxPGHc+reGDYeTiQORyX/6mTg015cEVT8phj
	 0VPVwVM8DBqsy2rx2MKtT10i0RnULYgHAlbRIj4a1pVAY4AJPBu2Wb2YUDumA0oNjr
	 ZTJdPt8ql5c8eWxq1F7rI+RNJ+eej4Aj0HfKykZa50map7g/Iw5gqcxUdHoYsqdZpX
	 flVD18UfTtFIUfN3dXn8fVDdjjc8L0nMy7siGF4YEPwS6xHEXIcE2JyA5Jlu9quhsP
	 N75aafZtTIqKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/12] arm64: tegra: Hook up VPR to host1x
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: robh@kernel.org, linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, media-ci@linuxtv.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260904-tegra-vpr-v6-11-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-11-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:49:36 +0000
Message-Id: <20260904114936.DAA891F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The VPR driver assumes `set_direct_map_invalid_noflush()` successf=
ully unmaps memory from the linear map if it returns 0. However, on arm64 w=
ith `rodata_full` disabled, the function is a silent no-op (returns 0 witho=
ut modifying PTEs).
- [High] For static VPR allocations without page-backing, `dma_map_sgtable(=
)` is unconditionally called with a NULL page pointer, which will generate =
a bogus DMA address and corrupt the mapping.
- [High] Memory allocated with `kvmalloc_array()` is incorrectly freed with=
 `kfree()`, which will cause a kernel panic if the allocation fell back to =
vmalloc.
- [Medium] The `vpr->active` bitmap leaks on the error path if `dma_heap_ad=
d()` fails.
--

commit 41cac70cac0869723195f2732d0c1395995f6880
Author: Thierry Reding <treding@nvidia.com>

arm64: tegra: Hook up VPR to host1x
   =20
The host1x needs access to the VPR region, so make sure to reference it
via the memory-region property.

> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra234.dtsi
> index 6c4739efc8a5d..c6a5ced069e79 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -4479,6 +4479,9 @@ vic@15340000 {
>  				interconnect-names =3D "dma-mem", "write";
>  				iommus =3D <&smmu_niso1 TEGRA234_SID_VIC>;
>  				dma-coherent;
> +
> +				memory-region =3D <&vpr>;
> +				memory-region-names =3D "protected";

[Severity: High]
Does hooking up the VPR driver here expose an issue where
set_direct_map_invalid_noflush() is assumed to invalidate memory, but silen=
tly
fails on arm64?

In drivers/dma-buf/heaps/tegra-vpr.c:tegra_vpr_chunk_activate():

	err =3D set_direct_map_invalid_noflush(chunk->start_page,
					     chunk->num_pages);
	if (err)
		return err;

On arm64, if rodata_full is disabled, can_set_direct_map() returns false,
causing set_direct_map_invalid_noflush() to return 0 without actually
modifying PTEs. Since this returns 0, the driver assumes success and contin=
ues.

If the CPU speculatively accesses memory that is supposed to be protected by
the VPR, could the hardware memory controller block the access and fault?

[Severity: High]
Does enabling VPR also trigger an issue where dma_map_sgtable() overwrites
manually crafted SG entries containing NULL page pointers?

In drivers/dma-buf/heaps/tegra-vpr.c:tegra_vpr_map_dma_buf():

	err =3D dma_map_sgtable(attachment->dev, sgt, direction,
			      DMA_ATTR_SKIP_CPU_SYNC);

For static VPR allocations without page-backing, the driver creates an SG t=
able
and explicitly sets sg_set_page() to NULL in tegra_vpr_attach(), manually
populating sg_dma_address.=20

However, the unconditional call to dma_map_sgtable() will iterate over the =
SG
table, extract the physical address via sg_page() (which resolves to PA 0),=
=20
and map it, overwriting the driver's manually populated sg_dma_address.=20

Can this corrupt the DMA mapping and potentially cause an IOMMU fault?

[Severity: High]
Is it safe to free memory allocated with kvmalloc_array() using kfree()?

In drivers/dma-buf/heaps/tegra-vpr.c:tegra_vpr_buffer_allocate():

		buffer->pages =3D kvmalloc_array(buffer->num_pages,
					       sizeof(*buffer->pages),
					       GFP_KERNEL);
...
		err =3D tegra_vpr_activate_chunks(vpr, buffer);
		if (err < 0) {
			kfree(buffer->pages);
			goto free;
		}

And also in tegra_vpr_buffer_release():

	bitmap_clear(vpr->bitmap, buffer->pageno, buffer->num_pages);
	list_del(&buffer->list);
	kfree(buffer->pages);
	kfree(buffer);

If the kvmalloc_array() allocation falls back to vmalloc(), calling kfree()
on a vmalloc address will trigger a kernel bug. Since video buffers are
typically large, isn't the vmalloc() fallback highly likely?

[Severity: Medium]
Does the vpr->active bitmap leak on the error path if dma_heap_add() fails?

In drivers/dma-buf/heaps/tegra-vpr.c:tegra_vpr_add_heap(), if dma_heap_add()
fails, it jumps to cleanup:

cleanup:
	if (vpr->resizable)
		tegra_vpr_free_chunks(vpr);

But tegra_vpr_free_chunks() fails to clean up the bitmap allocated in
tegra_vpr_setup_chunks():

	vpr->active =3D bitmap_zalloc(vpr->num_chunks, GFP_KERNEL);

Should there be a corresponding bitmap_free(vpr->active) in
tegra_vpr_free_chunks()?

>  			};
> =20
>  			nvdec@15480000 {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D11
