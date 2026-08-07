Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB02647668C;
	Fri,  7 Aug 2026 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118755; cv=none; b=GOysWkFmrA7kxaH0JJumRBJ6m7MnErvUsePGKcR8LXy14FS9QyNvBQMBX9jQSjwQ7Qml/po/hy0yN8lHG9tebte2Eu21H15PZygylzOv3oPIU1jIcSZS9xxyHz2MhW4zAkCK6gxoW+gh50N0z+YlC8reF3kGaHNiwy1NZT6ZO5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118755; c=relaxed/simple;
	bh=URpzXFjad3g3V6eacKW0pQSdAC87a3y+bDdcavGmxRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VeYVBqJeFa8e+TfdFwdQG+4w2SjBE1MxMhTLXSPGj6sNYPHK3P2Q5FznTcN8wGgG5cRnrfmz9tbQEOOLsDLge42+vf97bf3rZIFFJxrb+wYXjwUOfFbJXwspPI72Ov0IYHDnOQBycS4vY4Pt9N+/z/3sQd+iBv+4yZyvpQ9meFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obIT2Qed; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obIT2Qed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C203D1F000E9;
	Fri,  7 Aug 2026 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118754;
	bh=1NVTQqosPep/eMz6+Qtw7pi02Pr/BqCT8FDr9sDxzN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=obIT2QedAtZfeLvVjXuh2QCywSDBkfESspPCccXMSjhDaPovcOEssCGc+YalUl9YQ
	 fgiN3oPQBaQpKC5IxfbTPBOO/nMHZ8McHEKVZJIAPRW61rYiveZWZMes0sToByXxpc
	 vyBaNK8d5Cv3XDOKzbabRz7FaqA95mPLuu8LowRwazkaL/G8eU9TcWdcqXLnq4s/Hp
	 ALyNwZ/ZH/cqxmDkrXLSurQpqIF32/jLFKIgAvdNXrA3a9eL/f9m2gFbOiTTAknNpc
	 vNavBclWHwnFyE/kabjrZxvZ4yrU5D3COyMuXfxzof5+jq7pG14pDVQD2OY1WXYXk9
	 AiaW3UntpAKaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/10] dt-bindings: gpu: host1x: Document
 memory-regions for NVDEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-s390@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, "Heiko
 Carstens" <hca@linux.ibm.com>, robh@kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260807-tegra-vpr-v4-3-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-3-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:05:53 +0000
Message-Id: <20260807160553.C203D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `memory-region` and `memory-region-names` properties were ad=
ded to `nvidia,tegra234-nvdec.yaml` to support the Video Protection Region =
(VPR) for secure video decoding, but they were omitted from the related `nv=
idia,tegra210-nvdec.yaml` binding which covers earlier generations of the s=
ame hardware family.
--

--- Patch [3]: [PATCH v4 03/10] dt-bindings: gpu: host1x: Document memory-r=
egions for NVDEC ---
commit 97ab5bd4094807d50abd7cf4f4dbbc00d0abb716
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: gpu: host1x: Document memory-regions for NVDEC

This commit adds memory-region and memory-region-names properties to the
Tegra234 NVDEC binding. This allows device trees to define a reserved video
protection region for secure video playback.

> diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234=
-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-=
nvdec.yaml
> index 4eb325cfd2961..bcaaabca945dc 100644
> --- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.=
yaml
> +++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.=
yaml
[ ... ]
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
Since earlier generations of the hardware share this family, should these
properties also be added to nvidia,tegra210-nvdec.yaml?

Because nvidia,tegra210-nvdec.yaml specifies additionalProperties: false, if
older devices (like those using nvidia,tegra186-nvdec) configure the NVDEC
block to use the Video Protection Region by adding the memory-region proper=
ty,
they will fail device tree schema validation.

>    nvidia,memory-controller:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-tegra-vpr-=
v4-0-5510d16af89e@nvidia.com?part=3D3
