Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F296E23FC41;
	Wed,  1 Jul 2026 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922588; cv=none; b=dU6SB7/NfC7Mte6oeHtPtqNswq/EyZAB/LbTPn/7x4WXS8pF/hd8sHM46A3njRYBduSe8injtUMktJ6fF9swV+DNCruij7K2TxIsjh4sI6xi2HpgAwn/QJ3iUSSBGUf53aYoYyQfMUkdicYyiYOOJgj33htIiaD0MrNmlHXt4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922588; c=relaxed/simple;
	bh=fNHQ0TSOcHuwr5FQ7QWdZBodpCcY9rc2C+N0JKV1CBQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qPujaXQD8BiO7lMYAt8Oox69ttFb8MZB0tr03o9dNop/dWtycxXTxvzhm4/WpsYvBqYGLSYMGgYIH+o59pESos66UfhPj4akm2ycm4LMBxyViDIoZiEgQ8SLT/8xJTFmSmmJR46pxMGQF9HbsUsb7Gdu8oBKrapNf0MfptWE2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wc0vRORD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wc0vRORD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261AE1F000E9;
	Wed,  1 Jul 2026 16:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782922587;
	bh=ULDk0dKlNaYCc4UU7uCB1fvspUD39sUqTgZWe4uD7Kk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wc0vRORD2MCCStZboly9uAHihvzPNd+m5QJiSJSD+lwellSixuAwumOoBjIZQEy7g
	 H5k2VUzX90W3OyJIpVrRec1pRxd5OH1ruMGNIDhkc/NARcD11i1pY5biDYBvCzCs1K
	 ff1c8WsiJItmlPvVY9kaDznrxDrwGOMIJrg3fEPLxrsIlqOgbi8RdVOOJIBYTLoBlJ
	 Xzu1HK7UrtRDE+z1JlvHRoUgXkUT2xdE/m/zJsyyceTrYkoqojKjT8aS6SBMJgwOJ2
	 b+bakV8+xDWVrrtqv6DnKH8eOfoqx9FGoJmLbfb/iSCvBlfv7ZbX5COhD7G5dMk3Jy
	 3dHJCPJhuc9Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/11] dt-bindings: gpu: host1x: Document
 memory-regions for NVDEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-s390@vger.kernel.org, devicetree@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, robh@kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, conor+dt@kernel.org
In-Reply-To: <20260701-tegra-vpr-v3-3-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-3-d80f7b871bb4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:16:26 +0000
Message-Id: <20260701161627.261AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typo `maxitems` instead of `maxItems` in device tree binding schema.
--

commit b966754e5a0b2701616e733b8013eb6ace1487ef
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: gpu: host1x: Document memory-regions for NVDEC

The video protection region is a reserved memory region that can be used
for secure video playback. NVDEC can access this region to decode images
into securely.

Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml in p=
roperties.memory-region-names:

>   memory-region-names:
>     items:
>       enum: [ framebuffer, protected ]
>     minItems: 1
>     maxitems: 2

[Severity: Low]
Is this regression a typo with maxitems? Should it be camelCase like
maxItems?

It looks like the lowercase version either disables maximum length validati=
on
for the memory-region-names array or breaks meta-schema evaluation when a
developer or CI system runs the make dt_binding_check target.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tegra-vpr-=
v3-0-d80f7b871bb4@nvidia.com?part=3D3
