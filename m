Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A543CE4B6;
	Fri, 14 Aug 2026 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721889; cv=none; b=ov59emAD8zH5ItLf+vvuAeyejG1n7kR5Twx0FFzQJxwMZgwHmVMxtxTZnMeXMszuxawj273xHI16bFsgtOsRj2MjpKB7O/Pjkpapx4r04UWvvGnmjOXZU8V7eHDPqUayvlBy1hdIFnB66wbg7/h7z7hXsZMDgvPuPmyzwUnCXqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721889; c=relaxed/simple;
	bh=mdCfgBgEcAIHIkKeCc59+Z9Slv2mFXEfMQNqiMGXJwM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L4krpXBUvL9hAPJQFq5u6HJUDnCPZBZBwOUJ2xXjj+S0owL8AtZ17sKW2Btsgg4pdo65fIVflkpfKlIjbqMtNvk0BTEThEwSy3fPnu2G7uvVdV3b9oTccYFnY0Ws5gMJFb91zBMyCyoCN34iWgWXrDa72WJH951i3CnOXFgPcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUUqjPRo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUUqjPRo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859C41F000E9;
	Fri, 14 Aug 2026 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721886;
	bh=v7qz5ThTCFyHTE6O0oPuP3P7nK6w6NGbEvsEyMmTBuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZUUqjPRoj6kgW37srNwXgNgZ5K0bsMz5yhSauKNADuNbd2BRjiJF5dGvy9Nz3J5Nl
	 7Lfu+YrMowfzRG6oB35kd/pKy6nT/yDwRAINhCCisOy73GqbbsWl3jCGbTxPflU41O
	 VvBq1zHHlAIrZ/OePHf6Zc3Pka1bJgaGca6rl3NQnIyXBEHw9LgFDalVuRN2BtHnbM
	 F7RM0EMXiEOMLBsUorxIzKYRhcGN6p8qYT0g3JozstKpGYNWp8DAcPA3yrdAoJOYnK
	 EvGJ+IX+CKiGnXF2Fe1aNE3ubI6F4M7O2+FPhG2EigJLdrKsCPpEz/oGZrMCfBuYkU
	 LBxbVf/ZDT+pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/10] arm64: tegra: Add VPR placeholder node on
 Tegra234
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, media-ci@linuxtv.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, conor+dt@kernel.org, robh@kernel.org, linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260814-tegra-vpr-v5-8-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-8-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:38:04 +0000
Message-Id: <20260814153804.859C41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The DT template comments out the `no-map` property to satisfy sche=
ma validation for resizable VPRs, but fails to instruct the firmware to add=
 it back for fixed VPRs. Without `no-map`, the kernel will map the hardware=
-protected Video Protection Region into the CPU linear map, leading to fata=
l SError panics from speculative execution.
- [Medium] Mismatch between the commit message instructions and the DT temp=
late regarding the `reg` property. The commit message instructs firmware to=
 remove `reg` for resizable VPRs, but it has already been commented out in =
the code.
--

--- Patch [8]: [PATCH v5 08/10] arm64: tegra: Add VPR placeholder node on T=
egra234 ---
commit 19202d4b4a42362e9866fdb06d4d5ebfaf462002
Author: Thierry Reding <treding@nvidia.com>

arm64: tegra: Add VPR placeholder node on Tegra234

This commit adds a placeholder device tree node for the Video Protection Re=
gion
(VPR) on Tegra234. It provides properties for both fixed and resizable VPR
configurations, expecting early firmware to finalize the node.

> Similarly, if the VPR is
> resizable, the firmware should remove the "reg" property since it is no
> longer needed.

[Severity: Medium]
Is this commit message instruction accurate for the final version of the pa=
tch?

The DT template in arch/arm64/boot/dts/nvidia/tegra234.dtsi comments out the
`reg` property by default. If early firmware strictly follows this commit
message and attempts to delete the `reg` property (e.g., using fdt_delprop(=
)),
could it fail and potentially abort boot if it doesn't handle the missing
property gracefully?

> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra234.dtsi
> index 8e0c51e496e20..52ff11873580d 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -29,6 +29,45 @@ aliases {

[ ... ]

> +			/*
> +			 * The below assumes resizable VPR by default. If the
> +			 * firmwares sets up fixed VPR, it is responsible for
> +			 * adding the missing "reg" property, removing any of
> +			 * the unused properties, as well as adding a unit-
> +			 * address matching the "reg" property.
> +			 */
> +
> +			/* fixed VPR */
> +			/*
> +			reg =3D <0x0 0x0 0x0 0x0>;
> +			no-map;
> +			*/

[Severity: High]
Does the firmware also need to be instructed to add the `no-map` property b=
ack
for fixed VPR configurations?

Since `no-map` is completely commented out and omitted from the instruction=
al
comment in the vpr node, firmware might not add it. Without `no-map`, the
kernel's of_reserved_mem_init() will use memblock_reserve() instead of
memblock_mark_nomap().

Could this cause a regression where the kernel maps the hardware-protected =
Video
Protection Region into the CPU linear map, leading to a fatal SError panic =
from
speculative execution?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D8
