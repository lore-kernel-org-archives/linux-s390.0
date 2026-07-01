Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CD8431E64;
	Wed,  1 Jul 2026 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782945979; cv=none; b=gEfRNKuaMhkRrq36eBiqoVsVBT6zXCMVNmEXdHdnXXF1XXdpo6txVEEwJTrFt74i0TdJGj945ZmrkweKrL70LiXlu0C7DhUazwj4ske1YrLPPXHoFt0uaxCnJiSdkFfgELQsDiMqCIakk7hfvtBAaHBQrZdaHLbw4xpuW1xVft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782945979; c=relaxed/simple;
	bh=J/bHcvl9g4EVwyBkZLzv1zDNJ3Ar+62bNkQmVOmAgT0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EQjzhjxGjPOJMs80PTDBgkYLkrwXc8lniAb6opf+fj/MQM1/UyruWg4x8fLchj67ObhslzWTK9NaYINU2gJghzSrU60Sdnmz/we3OrJk+BZB3VYCCx78BgvOwwRaIpm2IydpLfxrFUZnlaW30eIGp9mgnbPWv2tueXEzn7XNsZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmBDm51+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmBDm51+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB5E1F000E9;
	Wed,  1 Jul 2026 22:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782945977;
	bh=+5J55zaBIGnIi7rBGFws0TyqXQXJrDn55RBwF2gWBhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KmBDm51+oHFm+hYlW3v2tPtatoUeE8GJsh8IG7/1yHx1ugO7ZI5J3c9qRen90Rsc1
	 JBtIzgFpN2tO1Z6+itO+OcsRP75zvqSvFZeX0CNFK3db3+jGqUJNqxIgZYqubS3rGZ
	 62ByZURFYW47p+y0gVDiFGhQThjjvS/Nl2nYmqtNmGo+U6UGeR8BEaNKTwjh8PZy3I
	 KaND1SWY1GQ653UReIBEQDf0HdI+hu9RXqRcjvedpLqmckbE1Krsi1Fv+MAY5MNSOG
	 FJw7nWiSf98nG9pRQAzvwFOxkY1hnbWBrnbzw2P2Bjw798UTp7PaG92cFBSnOme3TN
	 A3i+sWzlzar5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/11] arm64: tegra: Hook up VPR to host1x
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, devicetree@vger.kernel.org, robh@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260701-tegra-vpr-v3-10-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-10-d80f7b871bb4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 22:46:16 +0000
Message-Id: <20260701224617.4EB5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing explicit `of_reserved_mem_device_init()` API call for VPR =
devices.
- [High] Omitted `memory-region` assignment on the `host1x` parent node.
- [Low] Dead self-assignment of a zero-initialized pointer member in `tegra=
_vpr_attach()`.
--

commit d66858609809fa2e5e478b229dab43684ed2e277
Author: Thierry Reding <treding@nvidia.com>

arm64: tegra: Hook up VPR to host1x

This commit adds the memory-region property to the vic and nvdec device
tree nodes in tegra234.dtsi. It intends to hook up the video protection
region to host1x and its clients.

> The host1x needs access to the VPR region, so make sure to reference it
> via the memory-region property.

[Severity: High]
Are we missing the memory-region assignment on the host1x parent node?

The commit message explicitly states that host1x needs access to the vpr
region and should reference it via the memory-region property. However,
this commit omits adding the memory-region property to the host1x@13e00000
parent node itself, only applying it to the child nodes (vic and nvdec).

Since the host1x dma engines fetch command streams from memory, if those
command buffers reside in the vpr region, host1x must be tracked as a vpr
device and frozen during vpr resizes. Omitting the property prevents host1x
from being added to the vpr devices list, leaving the system vulnerable to
hardware crashes if a resize is triggered.

> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra234.dtsi
> index 52ff11873580d..38637e8e6fc92 100644
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
Does this node assignment lack the explicit of_reserved_mem_device_init()
call required in the driver?

The generic of_dma_configure_id() logic only automatically invokes
of_reserved_mem_device_init_by_idx() for reserved regions compatible with
restricted-dma-pool. Since the vpr region uses
nvidia,tegra-video-protection-region, this automatic initialization is
skipped.

The drivers for vic and nvdec do not explicitly call
of_reserved_mem_device_init() to initialize the reserved memory. As a resul=
t,
the tegra_vpr_device_init() callback is never triggered, and the devices are
never added to the vpr->devices list.

Since they are missing from the list, they will not be suspended by
tegra_vpr_resize() during vpr resizing. Because untrusted userspace
applications can allocate memory from the vpr dma-buf heap to trigger a
resize, an active hardware workload on the gpu, vic, or nvdec during the
resize will lead to memory corruption, hardware faults, or a system crash.

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

[Severity: High]
Could this assignment also lead to a hardware crash for similar reasons?

The generic of_dma_configure_id() logic skips automatic initialization for
nvidia,tegra-video-protection-region. The nvdec driver does not explicitly
call of_reserved_mem_device_init(), so the device is never added to the
vpr->devices list and will not be suspended during vpr resizes, leading to
potential hardware faults or crashes when the region is resized.

>  				nvidia,memory-controller =3D <&mc>;

Additionally, looking at the driver changes introduced in this series, there
is a regression in tegra_vpr_attach():

drivers/dma-buf/heaps/tegra-vpr.c:tegra_vpr_attach() {
[ ... ]
	if (err < 0)
		goto free;

	attach->dev =3D attach->dev;
	INIT_LIST_HEAD(&attach->list);
[ ... ]
}

[Severity: Low]
Is this intended to capture attachment->dev instead?

tegra_vpr_attach() allocates the attach structure using kzalloc_obj(),
which zero-initializes the memory. It then executes the dead assignment
attach->dev =3D attach->dev, which effectively assigns null to the struct
member.

While this doesn't cause an immediate crash because the driver uses
attachment->dev directly in tegra_vpr_map_dma_buf() and leaves the member
unread, it appears to be a logic flaw introduced by this patch series.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tegra-vpr-=
v3-0-d80f7b871bb4@nvidia.com?part=3D10
