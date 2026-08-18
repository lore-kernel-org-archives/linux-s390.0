Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6873A5438
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787067879; cv=none; b=Rn3p3fRPgnX12oBMFPtmjBYd6dC5TsuqixejEK8DsVRIus5P9RxMQM3ZNEinc0f4+XnJvIMqEJIyNVzudOFh0Ezk7ZJz+sJTq5pzJ8OhXLq00ADIm+WhauufDicri1ioJ/OVQkGj/1XNqsOQzPotaBxfdi/FziEevEQ8fbAu9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787067879; c=relaxed/simple;
	bh=s89HWKo9WlkoSZghvGBDSnJHI4nSys18+Wdl4cCylZI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jq/b4zDjhwVgZbVEvkvO3b8+RKSsjwRg7786chMQdZpwM0f+69kCxgnDzwypZkrfk34NvKjITFPb0iaih1FLZxKpLxcovPaLzzGyPJPrAe72prVrdiDRIf3T4a4p75iFvxiHOnLB6x8MdjrNLSjz/YBtbNh6X6v3fxQ5rwqkIWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5ZP5Gk6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5ZP5Gk6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856EC1F000E9;
	Tue, 18 Aug 2026 15:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787067877;
	bh=sDCAqZzQoRDLRpETIyRfpUCxVmLzQVLn7bP7ELEZOdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5ZP5Gk6L+AgAVdoVFYbDshWdWz+dWoqV4HSkMj+7/cz0fuY2BSFIOlqys9HCAR0d
	 Vmwhr4vHeoSMOJH7gwO9wxinF46XfvEae45SrfqZvmKSH5L5Ik6UNtpkhof/CJwKCu
	 FTcgzdzGJ8JuFMWoczMD7fI7M4ypoUh9jM4Y8uOHRgAClPYVonFp+YXyR85ufs4QS+
	 jhvPwyj+TbyCeU/eDdbV4Qqv9E7j100s8LqFC4ZGixvSNcxSxLbwxfhRRkM0tRSaVZ
	 Uu599h5vR1ZmxktMgauX48oHTjAN7xJ12Kj0Y+ZTpGgSkwUBIGF9J91/W/qbmwcUZK
	 1GwIUF0OzQTTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] s390/iomem: register initrd as an iomem resource
 when retain_initrd is set
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joseph Cathcart" <josephc@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260818153559.5700-1-josephc@linux.ibm.com>
References: <20260818153559.5700-1-josephc@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:44:37 +0000
Message-Id: <20260818154437.856EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] When 'retain_initrd' is specified but no initrd is actually load=
ed, a spurious 1-byte resource is incorrectly registered at physical addres=
s 0.
- [Medium] Divergence between s390 `strstr()` boot parameter parsing and th=
e core kernel `__setup()` parsing leads to freed initrd memory being falsel=
y exposed as busy.
--

--- Patch [1]: [PATCH v1] s390/iomem: register initrd as an iomem resource =
when retain_initrd is set ---
commit 0c196150a4a4c949fd3f9d1707d0bc631a2fd7ca
Author: Joseph Cathcart <josephc@linux.ibm.com>

s390/iomem: register initrd as an iomem resource when retain_initrd is set

Currently, /proc/iomem contains no reference to initrd memory, even
when initrd is retained and still held in RAM. This makes the memory
ranges invisible from userspace, and unusable to programs such as kexec.

> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index b60284328fe3d..a3c57ff40bf81 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c

[ ... ]

> @@ -501,6 +508,17 @@ static void __init setup_resources(void)
>  	bss_resource.start =3D __pa_symbol(__bss_start);
>  	bss_resource.end =3D __pa_symbol(__bss_stop) - 1;
> =20
> +	if (strstr(boot_command_line, "retain_initrd"))
> +		retain_initrd =3D true;

[Severity: Medium]
Could this strstr() match substrings like "retain_initrd=3D0" or
"no_retain_initrd"?

The core kernel parser in init/initramfs.c (__setup("retain_initrd", ...))
enforces strict matching and rejects parameters like "=3D0". If the core ke=
rnel
leaves its do_retain_initrd flag false and frees the initrd memory, wouldn't
this substring match cause s390 to incorrectly mark the freed initrd memory
as an IORESOURCE_BUSY resource?

> +	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && retain_initrd) {
> +		unsigned long initrd_addr, initrd_size;
> +=09
> +		if (get_physmem_reserved(RR_INITRD, &initrd_addr, &initrd_size)) {
> +			initrd_resource.start =3D initrd_addr;
> +			initrd_resource.end =3D initrd_resource.start + initrd_size - 1;
> +		}
> +	}
> +

[ ... ]

> @@ -517,6 +535,8 @@ static void __init setup_resources(void)
> =20
>  		for (j =3D 0; j < ARRAY_SIZE(standard_resources); j++) {
>  			std_res =3D standard_resources[j];
> +			if (std_res =3D=3D &initrd_resource && !retain_initrd)
> +				continue;

[Severity: Medium]
If the retain_initrd parameter is provided but no initrd is actually loaded
(e.g. get_physmem_reserved() returns 0), retain_initrd remains true but
initrd_resource bounds are never set.

Does this result in an uninitialized initrd_resource being erroneously
registered as a 1-byte resource at physical address 0?

>  			if (std_res->start < res->start ||
>  			    std_res->start > res->end)
>  				continue;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818153559.5700=
-1-josephc@linux.ibm.com?part=3D1
