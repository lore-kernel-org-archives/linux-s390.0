Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABEE41D233;
	Fri,  7 Aug 2026 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119407; cv=none; b=GSfurwS7uEm9LZXWTyT+Jh9iunC4yAxfVYKEtE8RkQjnQa+b+l2+otHBtzMoedHt+pwN5U/CD2nh8V5R9eiq17NgvSo/mklHTb62YCIB0eam6khzJAErrehWUPE8hxO2irC7QE+Gfh1NCfhnXDZVHVCHAOiHPzGz8wSSBPQ60sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119407; c=relaxed/simple;
	bh=Fkpn26Lfvz3wmShB0UV8QqY38ksw+EsmCUvcPqriT9Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WGvrqP9eQab/3VzWHtvhQmAZF0KTGIrnVusYeinT+7Rf1fB4Fk6AZrbSa4qfgkhjusRq3aa5xS8MBnAVoJ8y+drG3ysI/iOtTi2VX5tpcmYk0T1nfVRd6aokztCI9UAQSJ4UETS9fMAI1Z2dqe6GJ0ZMOMWbzMrOU6iMoHMbxiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlRmzsAz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlRmzsAz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503191F000E9;
	Fri,  7 Aug 2026 16:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786119397;
	bh=gAcVUUFX808c+BHpBX40mWEXe0dlxpN0gPYrR12musU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BlRmzsAzl5Pr+79IA5/B5e/WS/UNVOEMUvhTsotOcxlruLJs5IMIw9hFrVqKHRGeT
	 JZemjeRVCtESeJnGyim4Lu1oCRkvJFqBiqbG4ewcv1UKZ5caLTPd3CVCY53PM1wmbn
	 DOK5hc7SkJ0m5kjwat9XV3IGNU2n9WiMBY5LYI6U3E5KRsSmuq/GefHidxw9gGUeZd
	 012vA9JKItPIvmD1xJmN/vv1KIJFWqjb7JUeokR7xVmRhIYUEXzM4eiimippm5ksjY
	 wTNrrsp4erym7VpQXwXKRlAl+n5UxhwhMX2Fhe0E+oLy4o/Ly4+6+noHiNDWbablsp
	 3bIf2iGFnovAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/10] arm64: tegra: Hook up VPR to host1x
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: media-ci@linuxtv.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, conor+dt@kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, robh@kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260807-tegra-vpr-v4-9-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-9-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:16:36 +0000
Message-Id: <20260807161637.503191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unconditional NULL pointer dereference in tegra_vpr_device_init on=
 deferral and driverless paths.
- [High] VPR heap initialization fails for sizes in the lower half of an or=
der due to 0-sized chunks.
- [Medium] Off-by-one error prevents allocating the final page of the VPR o=
r a single max-sized buffer.
--

--- Patch [9]: [PATCH v4 09/10] arm64: tegra: Hook up VPR to host1x ---
commit 04120e646b04a85555bacc81f097911f705ea117
Author: Thierry Reding <treding@nvidia.com>

arm64: tegra: Hook up VPR to host1x

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
>  			};
> =20
>  			nvdec@15480000 {
> @@ -4497,6 +4500,9 @@ nvdec@15480000 {
>  				iommus =3D <&smmu_niso1 TEGRA234_SID_NVDEC>;
>  				dma-coherent;
> =20
> +				memory-region =3D <&vpr>;
> +				memory-region-names =3D "protected";
> +
>  				nvidia,memory-controller =3D <&mc>;
> =20
>  				/*

With the VPR region now hooked up, we noticed a few issues in the tegra-vpr
heap driver that might be triggered by this change.

[Severity: High]
Does this code risk a NULL pointer dereference on the deferral or driverless
paths?

drivers/dma-buf/heaps/tegra-vpr.c:tegra_vpr_device_init() {
	struct dma_heap *heap =3D rmem->priv;
	struct tegra_vpr *vpr =3D dma_heap_get_drvdata(heap);
	const struct dev_pm_ops *pm =3D dev->driver->pm;

	if (!rmem->priv)
		return -EPROBE_DEFER;
}

The heap pointer (rmem->priv) and dev->driver appear to be unconditionally
dereferenced before the check for !rmem->priv happens. Could this cause a
kernel panic if the VPR heap driver is not yet initialized or if dev->driver
is NULL?


[Severity: High]
Can the VPR heap initialization fail for sizes in the lower half of an order
due to 0-sized chunks?

drivers/dma-buf/heaps/tegra-vpr.c:tegra_vpr_setup_chunks() {
		size =3D min_t(size_t, size, max_size);
		end =3D start + size - 1;

		err =3D tegra_vpr_chunk_init(vpr, &vpr->chunks[i], start, size,
					   order, name);
}

When max_size is artificially large due to power-of-2 rounding, size could
reach 0 in the final loop iterations. Would this lead to an invalid CMA
region creation when cma_create() is called with a size of 0?


[Severity: Medium]
Does this off-by-one error prevent allocating the final page of the VPR or a
single max-sized buffer?

drivers/dma-buf/heaps/tegra-vpr.c:tegra_vpr_find_free_region() {
	return tegra_vpr_find_free_region_in_range(vpr, 0, vpr->num_pages - 1,
						   num_pages, align);
}

The end_page parameter is given the inclusive upper bound (vpr->num_pages -=
 1).

drivers/dma-buf/heaps/tegra-vpr.c:tegra_vpr_find_free_region_in_range() {
	for (pos =3D next; pos + num_pages <=3D end_page; pos =3D next) {
}

However, the loop condition checks pos + num_pages <=3D end_page, meaning
end_page acts as an exclusive bound. Does this cause allocations that span
the final page to fail with -ENOSPC?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-tegra-vpr-=
v4-0-5510d16af89e@nvidia.com?part=3D9
