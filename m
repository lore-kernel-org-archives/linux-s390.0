Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF23F5BDB
	for <linux-s390@vger.kernel.org>; Mon, 14 Sep 2026 07:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789371715; cv=none; b=cLtGI1L6PIzQ5lR+ZjdKa4RGMarFUrlZLnCaKs1Z4huleDahIkrJjLVf7w0rj1KYzqEYq3YtRYx0H0uZdHWtgXPcFR1YsgAvfz3ntx90DYgXcGtRm322eDfBENGXmM4rWc0J+aMU0P7qvJ3iwmdsOv2l3NpdzIg1JEDO+d+E714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789371715; c=relaxed/simple;
	bh=6YDgUr6VOoXoTc4xvbw8mh96+sI8zXbWtDS6D+hO30E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pugk8WjR/PUwgG2fXM8vNyT43qRUejbpyo34uJKuKP9s3s4/YauinksnJ9JEQyIN3nTniSsfLA1aB/z0VN0CS5G1+D/tPnVCR2oG9KacYNF8OM58BOPO5/oTEhIGoZkHI2IPTfrf7Jxi40oR21KwpZB/CZWfmnL60+nvTwoHQZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgoikxE1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgoikxE1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD591F000FF;
	Mon, 14 Sep 2026 07:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789371713;
	bh=6YDgUr6VOoXoTc4xvbw8mh96+sI8zXbWtDS6D+hO30E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SgoikxE1Bmb4usxC/KaLaiwDGIND6sJdr843k0fMGUddEGEaYO91n49yrF/GNI6OM
	 1MsAC/kumTHM8S3y719hEMwfN5TWqt/nwlYGSy4knMiDEAW34nmWx7EWnSX+c1314j
	 DbxE2qggE+1G+ubitFW5K1RU0VIFEzD5nGpg24pttkMvyheNSaPlo46F5EnvSFLlJa
	 F8ETOa7zbUx5gxFN3naVW4Sf5ftOLpGphhCrEuTqUHEkKLd8YEZfypuiDkfub71MM8
	 bKGKq7lTrALdRkcNKPe2m1sZfoTAFXnqTGUj2Y+0cwQ8gQHePDGI7Bxl92bxB6PsAh
	 fFVNOCgtiKMbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] dma: swiotlb: Centralize memory-encryption pool
 sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260914070135.313337-4-aneesh.kumar@kernel.org>
References: <20260914070135.313337-1-aneesh.kumar@kernel.org>
 <20260914070135.313337-4-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 07:41:53 +0000
Message-Id: <20260914074153.7BD591F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Memory-encrypted guests use shared or unencrypted memory for DMA and may
> route all DMA through SWIOTLB. The default pool can therefore be too
> small for I/O-intensive workloads.
>=20
> Move the existing x86 guest-sizing policy into the SWIOTLB core. For
> SWIOTLB_POOL_CC_GUEST, size the pool to 6% of guest memory, clamped
> between the normal default and 1 GiB. Preserve an explicit swiotlb=3D
> size.
>=20
> Provide swiotlb_adjusted_size() so early users, including the x86 crash
> kernel reservation, can account for the prospective guest pool size
> before SWIOTLB initialization. Use the same area-aware alignment for
> both the prospective and allocated sizes.
>=20
> Host memory encryption still selects a normal-sized shared pool and
> does not use the guest-sizing policy.
>=20
> A restricted DMA pool already provides shared bounce buffers for its
> devices. Record its presence during reserved-memory initialization and
> do not select the confidential-guest default-pool policy solely because
> guest memory encryption is active.
>=20
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914070135.3133=
37-1-aneesh.kumar@kernel.org?part=3D3

