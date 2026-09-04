Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3C42F712;
	Fri,  4 Sep 2026 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519841; cv=none; b=qN7vNuXuIlK9MIR+p/hkyrjZ78qImoHZNpiK8JzpcAUbkV89d7xOge98F391PeXnUkH+QBOZtQod00zO4/jyoMdj0TWT4xTDesMF/uXgt1rIpIYmzbERA2Zq+cBW4auEz6N4zD1C4ijqxukx3P+4at+y/7FXyDCKhM7eKk+AHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519841; c=relaxed/simple;
	bh=wmQF2YqXQK5D1pVhFo7BE3ugnTdhdCnbz9fgmSpU9LE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fKo2GdEidq93oK1OGlEt0M9pRo5IQk+G/0zzDmll8cCmAGLE8LKx6QNekI8Br6rZtNY6ZswN4hQaYR+12WwaDbxiCKAGUXsYySnEYayJumX5UaVXAE2yG3ktJVpHWamJa41I8NpdGjlEGLBER57xW3pXnx8TfOaYxP4hIsqJFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwDTDxzC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwDTDxzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799131F00A3F;
	Fri,  4 Sep 2026 11:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519840;
	bh=03WZ/RbYT1BfhS6cRy0LG4WhNbveMON3bVI/gDXIpsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mwDTDxzCsttYTDz6tbb7e7YKyHUNmfColuvkU5BbDJIJT5SsuM7S3X5TE+6rh29ei
	 lWaB+cMhoOfrEsoMx5vpNCNUu9yJsEWyuPCHtnn/MQ0XJPj7JKD6VhPtnz2aLy/Js9
	 ABr443ro3hlJX01wKiI9Kk5I4b4ylLY6ihX0BafwJwX+VqszexCvVelrev4w2gdLv4
	 L1RtK0ynMMz1MTUpNUgj2omdRkqoTcjJDb0y4b6LBiNIQJn0vnMwIy9rdqmGC8n/re
	 eGun6hzackKav1aaqpUZaM5nspbS1awbJ0TNCb5zkGQBC4GSu1lt+aW5ws+5ctueNt
	 iAT/H4MorXbkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/12] dt-bindings: gpu: host1x: Document
 memory-regions for NVDEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: dri-devel@lists.freedesktop.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, conor+dt@kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, robh@kernel.org, media-ci@linuxtv.org, devicetree@vger.kernel.org, linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260904-tegra-vpr-v6-3-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-3-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:03:59 +0000
Message-Id: <20260904110359.799131F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `memory-region` and `memory-region-names` properties for the=
 Video Protection Region (VPR) were added to the Tegra234 NVDEC binding but=
 omitted from the older NVDEC binding (`nvidia,tegra210-nvdec.yaml`) which =
covers Tegra210, Tegra186, and Tegra194. Other hardware blocks on these old=
er chips (such as VIC and DC) already document and use `memory-region` for =
the VPR, indicating that the hardware shares the same capability. Failing t=
o update the related YAML files in the same family causes schema validation=
 to fail for complete device trees.
--

commit c5ee297bfa8219c2a7d714b86f0738c220914705
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: gpu: host1x: Document memory-regions for NVDEC

The video protection region is a reserved memory region that can be used
for secure video playback. NVDEC can access this region to decode images
into securely.

> diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234=
-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-=
nvdec.yaml
> index 4eb325cfd2961..bcaaabca945dc 100644
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

[Severity: Medium]
Should these properties also be added to the older NVDEC binding
(nvidia,tegra210-nvdec.yaml) which covers Tegra210, Tegra186, and Tegra194?

Other hardware blocks on these older chips (such as VIC and DC) already
document and use memory-region for the Video Protection Region, indicating
that the hardware shares the same capability.

If a device tree for Tegra210, Tegra186, or Tegra194 correctly specifies
the Video Protection Region for NVDEC, will it fail schema validation
because the properties are undocumented and additionalProperties: false
is set in the older binding?

> +
>    nvidia,memory-controller:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D3
