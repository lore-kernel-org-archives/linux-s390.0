Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435936A37D;
	Fri, 12 Jun 2026 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288574; cv=none; b=GC+cauVTOVk/npGZVGquAVhCf23u8mV75yOIFXRIZrXbnXACxTx0CDvAnuK3WZyw5/sb6EZZ+RUZlUrqSYF1bRs/aqNeCtbuWRtFU8+/uXLetr+KdZ/sPXe4pXW5Xr3ncMXVSFTs40EOoz4s+3876jBlBA1+VhXlpgARdMGghso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288574; c=relaxed/simple;
	bh=i1HUHeL5qeXFSPb75C3k7VkSTDipWQvB2OlovsqsJos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qAchUbncE/DVH3mpyHTKXcIqCfMGM9105gNaRw0Ou4U3rRsYWy9YCJTJne2fpr/Xyfjrz9w0lzpjztZdtFKQTtBzadEwTpw4+Wn+JGdtedwdCfnRpDuc4Y4Xdugy6ifjSR7jrw73XJ7CUGpre9wO0hvkz3ZsoHOQ6Qu7TuUf/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzAlrIS5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzAlrIS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE141F000E9;
	Fri, 12 Jun 2026 18:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781288573;
	bh=TjVhZg1rC6h+i/yo4zWI+EfLAZQWngNdlBNlbh1To3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gzAlrIS5b/RW/SNy4cWm9c4NWAJKLUoQE0M2rJpCHLWRbugOtuCrlj61kr8gjwyJ2
	 a2e9oFhptBXkJydo4w432iBrF31kL69Llu+0x23+xspfOU/zltP3CMjX0yXQcgorIR
	 oj8XdPCV1M3pLjiOEu0zWJCEsgC7EBjFMMTVlLfAo8A432kNf95UrWPxf9qGEzBhuW
	 eoPQkfOaBrwLu1SV5WcfIm/svHgUQRiQwnTYuqGedqVZsYBuqb/v9LTsQeeg+DZcPW
	 F7M+eSSBC5StBOA6B1OE6pFMucMo9YsmhhSafaI95h2Ey0Rbj8l3/6wxYoq2csI6EK
	 d12yB/SX88thw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] s390/pci: Fence FMB enable/disable via sysfs for
 passthrough devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260612181048.91548-5-oelghoul@linux.ibm.com>
References: <20260612181048.91548-5-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:22:52 +0000
Message-Id: <20260612182252.AAE141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch explicitly wraps a sleepable user-space memory copy (`=
kstrtoul_from_user()`) inside `mutex_lock(&zdev->kzdev_lock)`, introducing =
a lock-holding anti-pattern that can block system paths.
--

commit 0ba1ddb8db696b6bb98d1631644717f3b52b557c
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Fence FMB enable/disable via sysfs for passthrough devices

This commit introduces a fence over enabling or disabling FMB via sysfs when
the zPCI device is associated with a KVM guest. This prevents the host from
disabling FMB while the guest is using it, securing the VM state.

> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
> --- a/arch/s390/pci/pci_debug.c
> +++ b/arch/s390/pci/pci_debug.c
> @@ -149,9 +149,15 @@ static ssize_t pci_perf_seq_write(struct file *file,=
 const char __user *ubuf,
>  	if (!zdev)
>  		return 0;
> =20
> +	mutex_lock(&zdev->kzdev_lock);
> +	if (zdev->kzdev) {
> +		rc =3D -EPERM;
> +		goto out_unlock_kzdev;
> +	}
> +
>  	rc =3D kstrtoul_from_user(ubuf, count, 10, &val);

[Severity: Medium]
Is it necessary to hold kzdev_lock while copying from user-space?

Calling kstrtoul_from_user() here means we are holding the kzdev_lock mutex
during a potentially blocking memory copy. If the user-space read blocks, it
will indefinitely hold kzdev_lock, stalling any other operations
synchronizing on this device's lock.

Since kstrtoul_from_user() only parses data into a local stack variable and
does not depend on the device state, does it make sense to move this call
before acquiring kzdev_lock?

>  	if (rc)
> -		return rc;
> +		goto out_unlock_kzdev;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612181048.9154=
8-1-oelghoul@linux.ibm.com?part=3D4
