Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7787247DFA5
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070812; cv=none; b=stYiu8sJ28so0filAbL/ckvSGZ8AZGSfvV6YQN0/qGoES60iM96N7l5IqKR0NrN9j18wVJgZqPn/07nO9Url0HyFLtlVAQugvaVIKY0/GjlwRRq/s3w0gKWZSstneoJ0mKqwjrPmZ8FpPabP2Cpj1isPYXTgs6/XbPrrX5SDlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070812; c=relaxed/simple;
	bh=/GFd5uz0Vltj1UsW7aRzbt+FaJgIbEHg8a8NngjH/Uc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nhBVQCjXaP2AZSSLczTwUI/H6GSGrT4oMKBpVBGuFlkKiyJB7BbpMVr5aeGv5lDPb8UDlqRxFr5E6hYPkTR7JligKFaL9z17VXcbJS83xF0V/go2DjRvDfDyKAktsDgFo6y82CXmOshFM/idlPe7ZLk6E94+eAXYanSNFI0yGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxem3yHA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxem3yHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82221F000E9;
	Tue, 18 Aug 2026 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787070811;
	bh=QAM3x8PfP6v65FRYAPuOolpVBlG7VTT4xwHyDuBW6GE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kxem3yHAm9SWg3v5Ge5sT3jJT6e91FVrCludA1pC1HiDu1GvGru+r/p8o6vOyjdTl
	 Yy+8LmLvho1UgvoLRtB2DJ+AZCnhDRM9ir0yhlojnwD7eLm1eher9r6S/yzRYunK0Q
	 +j9QMBsba6YClI1QcUn+xDzAwgaW+iqBbVBXtM4SZOErs9zorvc0wRHW4uA4e5rEdb
	 3pJe49gKEeHfe9mj+h5R09RTS8jOAMMtvgVJ9BVvXeFe906n4RerKrQPq1Yn7+Vioy
	 cdOmcahBfhDdcCUOt+BKMj2wprrcqdyrPnDXDgx6Bn3fpTJkaJUOKIObbyJeT4l9QN
	 NaHMsAXZXyrgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/iomem: register initrd as an iomem resource
 when retain_initrd is set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joseph Cathcart" <josephc@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260818162436.12383-1-josephc@linux.ibm.com>
References: <20260818162436.12383-1-josephc@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 16:33:30 +0000
Message-Id: <20260818163330.C82221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Imprecise substring matching for 'retain_initrd' creates a split=
-brain state with the core kernel, causing freed initrd memory to remain fa=
lsely marked as BUSY in the iomem resource map.
- [Medium] When CONFIG_BLK_DEV_INITRD is disabled, a bogus 1-byte initrd re=
source at address 0x0 is incorrectly registered if 'retain_initrd' matches =
in the boot command line.
--

--- Patch [1]: [PATCH v2] s390/iomem: register initrd as an iomem resource =
when retain_initrd is set ---
commit 0f4223b27c45aff988c662d5fb36a4161cc6901c
Author: Joseph Cathcart <josephc@linux.ibm.com>

s390/iomem: register initrd as an iomem resource when retain_initrd is set

This patch unconditionally adds initrd to the standard_resources array and
conditionally registers it as an iomem resource if the retain_initrd boot
parameter is present.

> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index b60284328fe3d..cd61e286628a0 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
[ ... ]
> @@ -501,6 +508,19 @@ static void __init setup_resources(void)
>  	bss_resource.start =3D __pa_symbol(__bss_start);
>  	bss_resource.end =3D __pa_symbol(__bss_stop) - 1;
> =20
> +	if (strstr(boot_command_line, "retain_initrd"))
> +		retain_initrd =3D true;

[Severity: Medium]
Is this substring match too broad? If a user passes "retain_initrd=3D0" or
"no_retain_initrd" on the command line, this will still evaluate to true.

The core kernel will correctly evaluate the exact parameter and free the
initrd memory, but s390 setup might then register the freed memory as an
IORESOURCE_BUSY initrd resource in /proc/iomem.=20

Will this leave a dangling resource entry covering memory that is actively
reused by the buddy allocator?

> +	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && retain_initrd) {
> +		unsigned long initrd_addr, initrd_size;
> +=09
> +		if (get_physmem_reserved(RR_INITRD, &initrd_addr, &initrd_size)) {
> +			initrd_resource.start =3D initrd_addr;
> +			initrd_resource.end =3D initrd_resource.start + initrd_size - 1;
> +		} else {
> +			retain_initrd =3D false;
> +		}
> +	}

[Severity: Medium]
What happens here if CONFIG_BLK_DEV_INITRD is disabled and retain_initrd
matched in the boot command line?

Since this block is skipped entirely, retain_initrd is never reset to
false. Won't the subsequent standard resources loop then process an
uninitialized initrd_resource (which defaults to 0-bounds), resulting in
a bogus 1-byte initrd resource registered at physical address 0x0?

> +
>  	for_each_mem_range(i, &start, &end) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818162436.1238=
3-1-josephc@linux.ibm.com?part=3D1
