Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4732D0617
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 06:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787727096; cv=none; b=tQCK3TnOMIvsyLuz3+BcLkH4T3WHIKHwoppNbGwMU0kHiN0psSpRqkKr4hLxv8YQNJvJFA9BqlYnWYKq1olCqvYS12rsAZRna4lHmCoM2LwrfV383K3jzzUyhpAJ2TeOM/jfPzzVP1qJVPXs6TF/CMNRhi5FxLSohA9vF06GKL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787727096; c=relaxed/simple;
	bh=aUMyTBXTKZIrKH2UbgzQf2DsxF/58gTNLQ46+amkIBA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JO1SpvqFSQmYO8X40th6Fd2nxiVDj+Qx+OO51zG6h/33o2Jl7qY81A9KdQxBXjH3fMHxDBXFeCVbKAwQsXnbugUIhlNBPUZf8TLy0XmrUiiGCkWLepsRm4/MEdm1ZfEiG6qjyxWeZ8b+XYkTVpLsQ6lCQxg9lGCkz4CzPjotZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6kmeiCs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6kmeiCs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B661F000E9;
	Wed, 26 Aug 2026 06:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787727095;
	bh=Kqvi1UyZA4mAUGrI1RQxX9j6SLbIRE+FGjKkrlVkHug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D6kmeiCsPktdPZ6pae2VvXKuLOQV178fI/DzfyaBI9z3TlhfSfOfwxZa8RaiI66sp
	 ATDVF92IHM55MskqPUv5ptuAK9KEJMQIGIsITadclngjEwyM29J+Up21zTh2yEACsY
	 vUJBbN1nWx222/dbBNHEHdRp5O5woO+wONUCxjH+uHHDtQGmaEgFQmisqDYCHt27P6
	 sV83YCKylppWsi/v1H/CJzp2LS4PlcP7IVTtL1mWMJ1FNTmlU8jtuuDVB3ed0mYTPM
	 a5J03yUNs2/aCRTaX2EnbmfqgcE54Y3BwaLR18ba7eJ2fjgiPQKGrDrO9pXoQUpiRG
	 ntIUbMOJS3DdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] arch/s390/pci: fix fixup_user_fault() calls with NULL
 unlocked parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liu Dalin" <liudalin@kylinsec.com.cn>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <0726CF177011E0E2+20260826064228.3255764-1-liudalin@kylinsec.com.cn>
References: <0726CF177011E0E2+20260826064228.3255764-1-liudalin@kylinsec.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 06:51:34 +0000
Message-Id: <20260826065134.E9B661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Changing the 'unlocked' parameter of fixup_user_fault() from N=
ULL to &unlocked allows the mmap_lock to be temporarily dropped, causing a =
Use-After-Free of the VMA pointer.
--

commit 440b0dda47238ff5981413f278a2a1abe962cdd0
Author: Liu Dalin <liudalin@kylinsec.com.cn>
arch/s390/pci: fix fixup_user_fault() calls with NULL unlocked parameter

This patch provides a valid unlocked variable to fixup_user_fault() in
the s390 PCI MMIO read and write handlers to properly track the lock state,
resolving an issue where the lock state was obfuscated by passing NULL.

> diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
> index f3f79ba78410a..5ef2d6436d4b1 100644
> --- a/arch/s390/pci/pci_mmio.c
> +++ b/arch/s390/pci/pci_mmio.c
> @@ -182,7 +182,9 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, m=
mio_addr,
>  	args.vma =3D vma;
>  	ret =3D follow_pfnmap_start(&args);
>  	if (ret) {
> -		fixup_user_fault(current->mm, mmio_addr, FAULT_FLAG_WRITE, NULL);
> +		bool unlocked =3D false;
> +
> +		fixup_user_fault(current->mm, mmio_addr, FAULT_FLAG_WRITE, &unlocked);
>  		ret =3D follow_pfnmap_start(&args);

[Severity: Critical]
If fixup_user_fault() drops the mmap_read_lock and sets unlocked to true,
a concurrent munmap() could free the VMA. Since args.vma was populated
earlier, calling follow_pfnmap_start(&args) immediately after would=20
dereference the freed VMA pointer:

mm/memory.c:follow_pfnmap_start() {
	struct vm_area_struct *vma =3D args->vma;
	...
	struct mm_struct *mm =3D vma->vm_mm;

Can this regression be avoided by checking the unlocked state and handling
the possibility that the VMA is no longer valid?

>  		if (ret)
>  			goto out_unlock_mmap;

[ ... ]

> @@ -335,7 +337,9 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mm=
io_addr,
>  	args.address =3D mmio_addr;
>  	ret =3D follow_pfnmap_start(&args);
>  	if (ret) {
> -		fixup_user_fault(current->mm, mmio_addr, 0, NULL);
> +		bool unlocked =3D false;
> +
> +		fixup_user_fault(current->mm, mmio_addr, 0, &unlocked);
>  		ret =3D follow_pfnmap_start(&args);

[Severity: Critical]
Similarly in s390_pci_mmio_read(), if the lock is temporarily dropped by
fixup_user_fault(), can this second call to follow_pfnmap_start() cause a
use-after-free regression by accessing the stale args.vma pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0726CF177011E0E2+20=
260826064228.3255764-1-liudalin@kylinsec.com.cn?part=3D1
