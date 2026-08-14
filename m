Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2648550F;
	Fri, 14 Aug 2026 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721957; cv=none; b=HMjx7ndIjIE51cqFuktfrC/hM9JLvdAI0j+o+SZMtgQKOmGK/4woZTkjodJX/jXkaD0Pgf+eCDeM02uPaDiaJ4B0CtoW1MGkiaURdGlwb+LHm1698GYYy29mufe+RQfiezQ5II1Ai8Up8xhvfMxRVK6r+B9YM0MOPT0M/X8vXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721957; c=relaxed/simple;
	bh=+mFmNOzrDof2hy3FnetQ2n3+AzeLRJHpi+fcy1A/taU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jC+7VtLnZW/VMgIBANPwQPbDo02/d9MN/PRh8mTh3v5qUWrr3M5xP7AIW9GSCBoDZGnRYKqLg5EvD3m5vDR+PmbJOdtCqpzmQ7V+z3boK4xtHEv7MZcEX1Zbtld2JJxo2KvfSvVjRnIZYwDzfuov3S2qBKBEzW8U9NFGspRVphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSkwIFrt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSkwIFrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E391F00A3F;
	Fri, 14 Aug 2026 15:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721953;
	bh=Lz+BHq6X9x8gkjPFZ43W7rtgt7YRtUAr0PMD0edHYTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RSkwIFrtPde5Eisj+bN+Pe3n7kMGuDfhyzCEXsCEL+o4E6ih6PPk9NwgQGYtuhjpp
	 6da/8oUcQ7HGGtlJY/SuU6CaZ9duX87v2lCyb191bVT1NfoEIEJLRBViH04KE8LV1z
	 8jZO5htWrghVtVs6304+/9w7lSs1r/0eMi1zRBvBsHS/r/6Wnyle291By539Lpk9z1
	 peygpQBGh7KELSykiQ4PJfuYjk733SqNwIBOTbXPJB9H3f2kwfHw89eaI1OcqNqc4m
	 ZMeSVhd/F85WT/hJnv7hrHVGkSx4FjAm0bcbhD8gOY/1jMeh4lkXjFSNuROstRiAPr
	 zKq06gU+0Tv0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/10] dt-bindings: gpu: host1x: Document
 memory-regions for NVDEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: dri-devel@lists.freedesktop.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, conor+dt@kernel.org, media-ci@linuxtv.org, linux-s390@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-trace-kernel@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260814-tegra-vpr-v5-3-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-3-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:39:12 +0000
Message-Id: <20260814153913.02E391F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing `memory-region` and `memory-region-names` properties in =
`nvidia,tegra210-nvdec.yaml`
- [Low] Missing word in the commit message sentence describing NVDEC behavi=
or
--

--- Patch [3]: [PATCH v5 03/10] dt-bindings: gpu: host1x: Document memory-r=
egions for NVDEC ---
commit d7576d345a96bd859ab402d685153853ecaa3898
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: gpu: host1x: Document memory-regions for NVDEC

This commit documents the memory-region and memory-region-names properties
for NVDEC in the nvidia,tegra234-nvdec.yaml schema. It specifies a reference
to the video protection memory region used for secure video playback.

> The video protection region is a reserved memory region that can be used
> for secure video playback. NVDEC can access this region to decode images
> into securely.

[Severity: Low]
This isn't a bug, but there seems to be a missing word in the commit messag=
e.
Should this be "decode images into it securely"?

> diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234=
-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-=
nvdec.yaml
> index 0b7561c8b9bb2..72313f776dbd8 100644
> --- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.=
yaml
> +++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.=
yaml
> @@ -60,6 +60,14 @@ properties:
>        - const: dma-mem
>        - const: write
> =20
> +  memory-region:
> +    items:
> +      - description: reference to the video protection memory region
> +
> +  memory-region-names:
> +    items:
> +      - const: protected
> +

[Severity: Medium]
Will this same feature be used on older hardware variants?

The Video Protection Region (VPR) appears to be available on older Tegra
devices as well. Since the schema located at
Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml
uses additionalProperties: false, attempting to configure the VPR on older
NVDEC nodes will fail schema validation.

Should memory-region and memory-region-names be added to
nvidia,tegra210-nvdec.yaml too?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D3
