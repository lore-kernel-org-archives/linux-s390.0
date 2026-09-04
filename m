Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD633CCFB8;
	Fri,  4 Sep 2026 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519555; cv=none; b=f7a9uWeBaaTnSmVpJKQgxAWgPZln8UTUUPWSw4lgaSimnV5ZXJyQGbmaHbhaiAWmBegr+KaRUZm/gPwfCJ+FoeUxL3r9bilgpqjbv34gaXHe1ovLkcnDX5bFYZlKUB2bgkIlhB0w8GMXk5cdcPlmSe5WyENRaWs2AWoQLJwTy20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519555; c=relaxed/simple;
	bh=VUi9SCTudcyuBGy1AI1bKBDs+Zh/rJ3hjz5BokKBQTI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E6jRJ/+dIrFOfq5b5WhchxqSl4lu3QKkEQF5ZW9TU1q6fizYIrEuRXVXNukoSWk1mcSosVygMhOwI8AMOIjxPqYQvmFcp4cLC21v2qA+ayVybe3ILVZS6I2U3R2S/ltVj7F7mvkp3wBH8KEEe3MhL7kYi+HIoekTlJVV/NGIDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFcr9HD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFcr9HD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0C41F00A3D;
	Fri,  4 Sep 2026 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788519554;
	bh=Q+wqxRlCl56rmCgZUANVMFMBl1TB3QdhwDp33qiHBpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HFcr9HD8XjwG6DfLthj7/5e6PXE6rBFFnBzTLpo4gtQNg+PP/PT6XSI/IN7CKzsvs
	 OW2SDkt7/p7dPO5ibUgrdc3/g3ZnAoi6/BQmkirChU1+65n2F0kewHCRMD1bln+BoO
	 zbSe6mjSrKeIiOz6GewzQ3NFEWoZt+fd4lU6RW21xX6Y+onLRRYFmXyieAmneOAx9g
	 vmIpaePsV5raRB6fzVMubIAUhhT8iFSR/eLMPMaffi1bO3d02S5Kfp+WGDIswtzKfR
	 X7rtIY67ftrJ0+1lQIBd/W39/SYFzQ7mG7QCOEHapKd9bU+NMM9qlwDSx05j9Vubzx
	 4aQ+RnawBtOBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/12] dt-bindings: reserved-memory: Document Tegra
 VPR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, devicetree@vger.kernel.org, linux-trace-kernel@vger.kernel.org, robh@kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260904-tegra-vpr-v6-1-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-1-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 10:59:12 +0000
Message-Id: <20260904105913.4A0C41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The examples fail to provide a `reserved-memory` parent node to est=
ablish the `#address-cells` and `#size-cells` context, leading to schema va=
lidation failures.
--

commit f2d3906971093a4dcbac5c42465c2d0d7ce5d0a8
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: reserved-memory: Document Tegra VPR

This commit adds device tree bindings for the NVIDIA Tegra Video Protection
Region (VPR), documenting both fixed and resizable variants.

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

[Severity: Low]
Will this fail make dt_binding_check during schema validation?

Since the example lacks an explicit reserved-memory parent node to establish
the #address-cells and #size-cells context, dtschema wraps this in a dummy
root node with a default of #size-cells =3D <1>. Supplying 2 cells for the
size here exceeds that implicit constraint.

> +      alignment =3D <0x0 0x100000>;

[Severity: Low]
Similarly, does this 2-cell alignment array violate the implicit
#size-cells =3D <1> constraint for the same reason?

> +      reusable;
> +    };
> +
> +  - |
> +    /* fixed VPR */
> +    protected@a8000000 {
> +      compatible =3D "nvidia,tegra-video-protection-region";
> +
> +      /* fixed VPR */
> +      reg =3D <0xa8000000 0x70000000>;

[Severity: Low]
Without a shared parent node to explicitly declare #address-cells and
#size-cells contexts, does this 2-cell reg property parse under the default
1-cell context (treating address=3D0xa8000000 and size=3D0x70000000)?

This creates a semantic mismatch with the 64-bit lengths intended in the
first example. Wrapping the examples in a reserved-memory parent node might
resolve these context issues.

> +      no-map;
> +    };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D1
