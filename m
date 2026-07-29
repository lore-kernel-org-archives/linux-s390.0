Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411D94D98E1;
	Wed, 29 Jul 2026 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349429; cv=none; b=PIKp+4MA1aZlcGjY10S/ToZ34zx6Tce5xWrNhQ+AjRDFXJoYnAq607L1NgMD5gCiDO13UPnbA9PKXfM/55MVC111k6FoONy0hqCDyUToZoT5yQLoZbL1m37YkJ/GHL/h3E68w/+GXreqB8EnLAO0VfCJ3+m55mW3CQR0Htbfx8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349429; c=relaxed/simple;
	bh=mv2sMhP+7eL58KdtS+VFVsDFKBITpQqXNbEMsP3qolA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DmL3SOEP3pM8vKkEUzdxok0taz12gVyKcB51VBkWHORotYHUiXbXYGAbUfesDOLfqQISVFvaDqz6RB/bZ6Y4MeNmBkNQcX+5ftiN04IbVx4caV2Nv1wOFiCRzNUcCIGsNuJFvGIWRjUUB03eDPYrN0IfNW1xrNTBVrQece+Y8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRdW6wZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRdW6wZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7A31F000E9;
	Wed, 29 Jul 2026 18:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785349422;
	bh=mv2sMhP+7eL58KdtS+VFVsDFKBITpQqXNbEMsP3qolA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WRdW6wZzzvcQwtBnJIm8J+km7dQBoa67TWPyJGUk8PsP8CwR/RnvQraGRdB+lhGWy
	 Leuqu4ciRNGkeKZkdKifuBMFr2XzCZC2DlgiuCZ4Lexi/JBFvqeyRcq7RiKeotPmuI
	 BtGKQ+PTEAaFc83/dHIckGLpKqZtHTwGo+Gdz6f1tNe9gi10PNVLP9KgvxIfmCslR7
	 4cVhOWdEFsg6dHgqAf67SjTr1IeNPYddqGytElMmqav4h6NU4u+XfLYOl61wGY5nq4
	 QmRY1mG35Dq7dQDEySwQVeHGI+K2DhpqC1/1Is6haG5CdXy3/t9LqFvOh10KIgIVeK
	 Wtq7GfLzF4c0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] vfio/pci: Avoid mapping BARs for devices with
 non-mappable BARs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260729181116.1373-1-alifm@linux.ibm.com>
References: <20260729181116.1373-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 18:23:41 +0000
Message-Id: <20260729182342.0B7A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> vfio_pci_core_map_bars() calls pci_iomap() to set up BAR resources, but n=
ot
> all devices support having their BARs mapped by the CPU. The
> non_mappable_bars flag indicates that a PCI device's BARs cannot be
> accessed by the CPU. The ISM device on s390 is one such device. The BAR
> size for an ISM device is 256 TiB, and attempting to map the BAR will lead
> to warnings:
>=20
> vmalloc_node_range for size 281474976714752 failed: Address range
> restricted to 0x2110bab00000 - 0x21903ab00000
>=20
> Use pdev->non_mappable_bars to skip pci_iomap() for such devices. This fl=
ag
> is set by the PCI core at enumeration time and already serves the same
> purpose in vfio_pci_probe_mmaps().
>=20
> Fixes: 05f2a68b407a ("vfio/pci: Set up BAR resources and maps in vfio_pci=
_core_enable()")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729181116.1373=
-1-alifm@linux.ibm.com?part=3D1

