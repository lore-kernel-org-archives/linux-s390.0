Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C2378D87;
	Fri,  7 Aug 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118887; cv=none; b=OJRzdT29d6o/xBLx+9ERfcCjKo1aJcdReuOrPBSeSe5BcE5foQLuMwgSDkWm30AajukA/xXJXGnPDbUyZLo4/98Jxq5fN3vtR93uaRNqAczgjuzgLVMjp15GgxWlZr9rY5/NpduLpRSsrSXFn3Xido5cDn4d+PM48iTr88iZLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118887; c=relaxed/simple;
	bh=IwcBswHOg/CKuhtuNDwE128oVbuFC01XMOMHhr+0h3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pXvHlURnTPMbAu4sidx5dlEsgGEXKW//MZ3aoiKMVJCp6hCc/b2yvNgA2oH8TsBDkngZyHzAjiU51tdNKsChKZByWCRY5X1548uMr7QYUdFPY27LHvGaxoDwxkV+UJSlPtRJ85gGV0tf64UXiDNs/irdqrDr/DDXBBcXSURYexk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TU2lP0ms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TU2lP0ms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FC51F000E9;
	Fri,  7 Aug 2026 16:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118885;
	bh=Mln1bvhJz1E5kIqI7M1efSQXW8KH8cV3OVz8x8Ispdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TU2lP0msn/r9JB6hcZEHmstbnkRUljtgCowxyZJdEL7qoErKzKA55cH7VtPcuAb+Q
	 oHBPXwH0T51LlbkoeSbpTE3UrrnnCxYmOtr3iVwSctBJVDMNWJ6FoRv45rQb7wubyp
	 OjoBzSHW3/Q1dOxvVyX8gJ9arLsuYreew2SmAD2Bfa2MW0xPOGOlAdJ5IwwLTcScSJ
	 IyQ5TuO/jpbOsqN3l2W8Td9J0UNohWKD3mCmJ+RBRYTax97G0bHBMPBlr7kklASyUE
	 1V5Ef+IkbeIMnM//N0rOYvKzvY0qBNFND/KknfY3hsxT3NiieHgDLJ/jiIDMDM+8L5
	 whJaPzVqsZg+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/10] dt-bindings: reserved-memory: Document Tegra
 VPR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, robh@kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, devicetree@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260807-tegra-vpr-v4-1-5510d16af89e@nvidia.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-1-5510d16af89e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:08:03 +0000
Message-Id: <20260807160805.01FC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The dt-schema examples for the VPR omit the parent `reserved-memory=
` node context, causing 64-bit multi-cell values to be incorrectly parsed a=
gainst 1-cell defaults.
--

--- Patch [1]: [PATCH v4 01/10] dt-bindings: reserved-memory: Document Tegr=
a VPR ---
commit 8113c8e6ae5fc4a5f07530aed37855cc00e7b6cc
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: reserved-memory: Document Tegra VPR

This commit adds device tree binding documentation for the Video
Protection Region (VPR) on NVIDIA Tegra chips. It supports both fixed
and resizable memory regions for DRM protected content playback.

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
Will this example fail semantic validation during make dt_binding_check?

Because #size-cells and #address-cells default to <1> at the root level,
omitting the parent reserved-memory node wrapper causes these 64-bit
multi-cell values to be parsed against 1-cell defaults. The size and
alignment properties here provide 2 cells and will be evaluated as arrays
of two 32-bit values rather than single 64-bit values.

> +      reusable;
> +    };

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807-tegra-vpr-=
v4-0-5510d16af89e@nvidia.com?part=3D1
