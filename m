Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A203382FC;
	Fri, 14 Aug 2026 15:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721986; cv=none; b=P7nEEuaFLuz3v0UdjvVdh7bIWhJ314eYuDbSpF3IeuHAh6jij/ChZ5pPL3BZ5X5TFAFG22P/L/h0s6x+bMWDA4Dud05NQ9LuGgRzsVUlHapWg0YLtaWGL962jUtmU43Lp7jEIF2y8f7uXk4Lub7xPRQVORC0J+7xZDcNCA14J2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721986; c=relaxed/simple;
	bh=c4E2BEn9faCS3mqXCmFepgrlaJHUMCNRSJdS06YSxkU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PtWVc02uPszTCjDVzaQ2a4B8BbMnsK4HVx/JBnH3/2eS8442rxJPLX0uPMo13INt188ndTQCgJuQPwlIhvP7I3+aGLJ4LJcV2X28mMOKSimQJOeMbhto9BnTCzWQXG1DVHsF7Znp0FWPv22k+0z2jXXTVPm2IjJ+TuK5UcFFJ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWc231Cr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWc231Cr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369991F000E9;
	Fri, 14 Aug 2026 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721984;
	bh=lTa/JlR73bsOpoAGF1VRV3Vc6IztNz6I1r+STzAT4qE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CWc231CrL9oIvlwzsk51cqCvOT+51JrWaia3rRztpLCSRdFKVtfVeuqZQXD07Pa0Q
	 mfGYuPH6rigJg1WA5qWyZdDuWcSatCNhvnOn0YKq/kjHrRtcDlPAFfG9soe7fPQZuz
	 DJcCCspx9gU6ztfPS+KTZJ4lzdpzyWWU8zJ3O2XfZ6+VV+eUn1+9Y9JyLRdzXf78xQ
	 nSD2MypiN210e5WAV7fhGpq6YHZ/KcssBgX64hkTxAy+AoWeXjtmUUfrtVwcHYqYoB
	 X2VGqRQmATavA6tP1hVrVnbMJiv6zTNPHlVRQSEVrjcOPQd0WVRLKgjU50+nnmZOGW
	 w2u7/zgiWD5vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/10] dt-bindings: reserved-memory: Document Tegra
 VPR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, linux-s390@vger.kernel.org, robh@kernel.org, linux-trace-kernel@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, devicetree@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, media-ci@linuxtv.org
In-Reply-To: <20260814-tegra-vpr-v5-1-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-1-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:39:43 +0000
Message-Id: <20260814153944.369991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The examples use 64-bit values for `size` and `alignment` but are m=
issing a parent `reserved-memory` node to define `#size-cells =3D <2>`.
--

--- Patch [1]: [PATCH v5 01/10] dt-bindings: reserved-memory: Document Tegr=
a VPR ---
commit f3aef7e4bf1dca49011b483a566145d2ddfdd64a
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: reserved-memory: Document Tegra VPR

This commit documents the device tree bindings for the NVIDIA Tegra Video
Protection Region (VPR). It defines a fixed VPR using the "reg" property
and a resizable VPR using "size" and "alignment".

> diff --git a/Documentation/devicetree/bindings/reserved-memory/nvidia,teg=
ra-video-protection-region.yaml b/Documentation/devicetree/bindings/reserve=
d-memory/nvidia,tegra-video-protection-region.yaml
> new file mode 100644
> index 0000000000000..862bfd3913786
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

[Severity: Low]
Will this cause dt_binding_check to fail?

The 64-bit values for size and alignment contain 2 cells each. This violates
the core reserved-memory.yaml schema when parsed with the default root
node context, which sets #size-cells =3D <1>.

Could the examples be wrapped in a reserved-memory parent node that
explicitly sets #address-cells =3D <2> and #size-cells =3D <2>?

> +      reusable;
> +    };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D1
