Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A13F9FB;
	Wed,  1 Jul 2026 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922520; cv=none; b=ClvVQ7FZASI8OyyjN21uumtB2QrRCfok1Qi+BORQX+ZxpK5TiPjbLcnGQUNLCEkL+i4y5h94MKZ3Q0MG1SvRG1g1cufaKCLKrXkv6FMke6/moKytDNnP9ovemKBxqdJpxVzoIF0OJxHJgpEtBMfKHyPcRR1pMND7eEGde9Scdk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922520; c=relaxed/simple;
	bh=xomRQIHYXv3J1pYDJReGFOKxkV/RdbDzwFgYbNEr1Q4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PyR3AKrw6XggtXZTAQvLPNIBW0QhSNolcs1CayrhRkKQWMHzjiBXsyoSuqV2gHokvEAcy57/wlCyXeIwIs4B0kudEoiqKC4EAS3/UYN5oYAZnwhHJThFj5W02lMBkNni789RpRiqPgp5ejpp+3Zzm0IZJfZZUo8E7m0pSN8/sm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5ghedL6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5ghedL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B140D1F000E9;
	Wed,  1 Jul 2026 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782922519;
	bh=aipDvWrWgPOS3T5x8LZ5hocJ9pcLdqwMOe41b3FMRds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J5ghedL6aUSbTKU7J+IdalinDDMtVrakY/guhUigSeYh6iLaXllutPDDHPhZ0/hRZ
	 ihF8+1dUJmBKtfNpNCwaBVjVh5gUthKbI92mV8fOA5F/5cIzbwfC1ZETyI9buCMAkW
	 qmOahRciR7Zjp/+522DqxlEifELsihsS5ojG6BUpC6g0I2EF97NjZqjQSj2wCihEZ3
	 M8t5Ze96hSo8kyBHD6Nvdw0dQY/8pXfWOmejIhzJ1AJp1vPjcl/suj21NbCZVPPpSf
	 KDSougZjtjkrqBxe/zFtAaMatBGFfuP+cKklIVGhsj0jNx4+IcW2sG29g0XAZJ4Gp3
	 VXZxPcj1QVbdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/11] dt-bindings: reserved-memory: Document Tegra
 VPR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, devicetree@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-tegra-vpr-v3-1-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-1-d80f7b871bb4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:15:18 +0000
Message-Id: <20260701161518.B140D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The examples section lacks a parent `reserved-memory` node defining=
 `#address-cells =3D <2>` and `#size-cells =3D <2>`, causing `make dt_bindi=
ng_check` to fail due to property length mismatches.
--

commit 4ece5321c623dd3f99c7265c3f5b7ed31b2d2efe
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: reserved-memory: Document Tegra VPR

This commit adds device tree binding documentation for the NVIDIA Tegra
Video Protection Region (VPR). It describes a protected memory region used
for DRM content, supporting both fixed and resizable variants.

> diff --git a/Documentation/devicetree/bindings/reserved-memory/nvidia,teg=
ra-video-protection-region.yaml b/Documentation/devicetree/bindings/reserve=
d-memory/nvidia,tegra-video-protection-region.yaml
> new file mode 100644
> index 0000000000000..1c524bae9ce32
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra-vide=
o-protection-region.yaml

[ ... ]

> +examples:
> +  - |
> +    /* resizable VPR */
> +    protected {
> +      compatible =3D "nvidia,tegra-video-protection-region";
> +
> +      size =3D <0x0 0x70000000>;
> +      alignment =3D <0x0 0x100000>;
> +      reusable;
> +    };
> +
> +  - |
> +    /* fixed VPR */
> +    protected@2a8000000 {
> +      compatible =3D "nvidia,tegra-video-protection-region";
> +
> +      /* fixed VPR */
> +      reg =3D <0x2 0xa8000000 0x0 0x70000000>;
> +      no-map;
> +    };

[Severity: Low]
Will this cause make dt_binding_check to fail due to property length
mismatches?=20

The examples use 64-bit values for size, alignment, and reg, which require
2 cells. Without an explicit parent reserved-memory node defining
#address-cells =3D <2> and #size-cells =3D <2>, won't the tooling evaluate =
this
using default 1-cell constraints and report errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tegra-vpr-=
v3-0-d80f7b871bb4@nvidia.com?part=3D1
