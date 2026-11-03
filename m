Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718930;
	b=ADq6uVslqoQZT3vAZJtJmabcPZW6U6NIKzB9XbrL9uzzeixQz0CLNZNTB8c2Pbj2RXlO
	 LaNMkZ39eMLbA4mLnKzcB359wrk1Ra+xo2IsP6z5Kld0ty6SsOMAcxNGmGfWFZQLQjzyf
	 F25iBh7XscAzKzOrahicypmLpK/R/iCMpal3kOCS7rO+CWr8DlbwoH2/8g4i2mrf6eAHR
	 mk49PFdc9gc82zptJd5tMniBaCsHUar5+ALZU8gVYTQDftzhewx3OmdErRCJ/7UjfF+nW
	 GpxgXp3MLmah9mRYEGlDT/7Tn969q8foyaCGLuzRmw7u3kjcWHLdnH8Czaw9yyAUUag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718930;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mI3CFwUuzvcIOODehtEbWIXPGEGMeTOZrw8tS2JfCIQ=;
	b=mFYkBAuJMpx6VC+1t9up32/izP6vPESg2vU/vJOK/BATH4OVGR4En7Iu6Y3r67u9npkv
	 GdW1Ke+LxdkMUTWYWEIeGNFJxXbLgvz4I3ZJFNZ7nTh4davx8zKd+oyml52L3/UQ3MnvD
	 rhjrMO5c/aXjAw81XUQl59XLuXMzg93t7dx6/Ro8J1Y/Cz0F129f8HU5eaMCb7vkIESnC
	 FiVFCdJslZbJOsR4DwPtH6VI9aNZcbmBAZLbxDkSotUkxu9yR07aDxWMvFgaY5wDhcabv
	 2TlGNp7GfUzBzjZpPU2wpUTjO4aDIUC0jW8tqPKiwHuQjzaTcv662TFgoptIS8c++AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P9D89k5W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D176606EEAA;
	Tue,  3 Nov 2026 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P9D89k5W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D256B1F00A23;
	Tue,  3 Nov 2026 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718930;
	bh=mI3CFwUuzvcIOODehtEbWIXPGEGMeTOZrw8tS2JfCIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P9D89k5W4gPRK3aF36dQI9RlWFxgCfl7QijD7Dpl9kLItprnRnowYqyKdVAoqhgQv
	 omCdEgq7z7JLY3eByFNwRHwDsnUQKkKJ2PeTTGmbfu34ddZTkO3sh2Nd61UmiQqEJm
	 J9ETrMB4D/yiQNXhbYg97UDRPIhrGVkHgjxPJBg/Zj1FLgcfqSYrtKOYiQAZHT+jja
	 byMgwl885xClqDM2ivNS7sRA3+neRYvA8T5dOrdR9mnP/HxEhNhh3kOKCsUKKNdSJn
	 iqFpQj/0q6zr3yxG7JJtbXmMXaV5Q7cJ/DUxZgn8JkxOxBDLNtoFZcIc2+V6aOLGYp
	 EZ66JFGQ0S8gQ==
Message-ID: <sashiko-outbox-195573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 3/5] s390/pci: Improve FMB memory management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261103150114.68873-4-oelghoul@linux.ibm.com>
References: <20261103150114.68873-1-oelghoul@linux.ibm.com>
 <20261103150114.68873-4-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:15:29 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390/pci: fmb_enabled not cleared when function is already disab=
led
--

commit ca3a9f4958dfbbed1e7f4c289498cd7e117c52ca
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Improve FMB memory management

This commit replaces the dedicated kmem_cache for Function Measurement
Blocks (FMB) with kzalloc_obj() and retains the allocated FMB buffer across
disable cycles until device release. Because a non-NULL zdev->fmb pointer no
longer indicates whether measurement is active, it adds a zdev->fmb_enabled
flag to track FMB state.

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index f49736386eb7c..f066a7ffc35c1 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
[ ... ]
> @@ -205,13 +203,17 @@ int zpci_fmb_enable(struct zpci_dev *zdev)
> =20
>  	lockdep_assert_held(&zdev->fmb_lock);
> =20
> -	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
> +	if (zdev->fmb_enabled || sizeof(*zdev->fmb) < zdev->fmb_length)
>  		return -EINVAL;
[ ... ]
> @@ -802,6 +805,12 @@ int zpci_disable_device(struct zpci_dev *zdev)
>  	} else {
>  		rc =3D -EIO;
>  	}
> +
> +	if (!rc) {
> +		guard(mutex)(&zdev->fmb_lock);
> +		zdev->fmb_enabled =3D 0;
> +	}
> +
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(zpci_disable_device);

[Severity: Medium]
Can zdev->fmb_enabled remain set to 1 when the PCI function is disabled by
firmware during reset or error recovery, preventing zpci_reenable_device()
from re-enabling FMB measurement?

In zpci_disable_device(), when clp_disable_fh() returns
CLP_RC_SETPCIFN_ALRDY because the function is already disabled in firmware,
clp_refresh_fh() updates zdev->fh to the disabled handle and sets rc to
-EINVAL:

arch/s390/pci/pci.c:zpci_disable_device() {
	cc =3D clp_disable_fh(zdev, &fh);
	if (!cc) {
		zpci_update_fh(zdev, fh);
	} else if (cc =3D=3D CLP_RC_SETPCIFN_ALRDY) {
		...
		rc =3D clp_refresh_fh(zdev->fid, &fh);
		if (!rc) {
			zpci_update_fh(zdev, fh);
			rc =3D -EINVAL;
		}
	} else {
		rc =3D -EIO;
	}

	if (!rc) {
		guard(mutex)(&zdev->fmb_lock);
		zdev->fmb_enabled =3D 0;
	}
}

Because zdev->fmb_enabled is only cleared when rc is 0, it stays set to 1 on
the -EINVAL path. Similarly, when a platform error event disables the
function on LPAR, __zpci_event_error() updates zdev->fh to the disabled
handle via zpci_update_fh() without clearing zdev->fmb_enabled.

When zpci_hot_reset_device() (or _do_recover() in pci_sysfs.c) then runs:

arch/s390/pci/pci.c:zpci_hot_reset_device() {
	if (zdev_enabled(zdev)) {
		rc =3D zpci_disable_device(zdev);
		if (rc =3D=3D -EINVAL)
			rc =3D 0;
		if (rc)
			return rc;
	}

	rc =3D zpci_reenable_device(zdev);
}

zpci_reenable_device() re-enables the function in firmware (where FMB
measurement starts disabled) and calls zpci_fmb_enable(zdev). However,
since zdev->fmb_enabled is still 1, zpci_fmb_enable() immediately returns
-EINVAL without calling zpci_mod_fc() to register the FMB address with
firmware, leaving FMB measurement disabled in firmware while
zdev->fmb_enabled reports it as enabled.

Should zdev->fmb_enabled also be cleared when the function is confirmed
disabled on the CLP_RC_SETPCIFN_ALRDY path (or whenever zpci_update_fh()
observes a disabled function handle, or before zpci_fmb_enable() in
zpci_reenable_device())?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103150114.6887=
3-1-oelghoul@linux.ibm.com?part=3D3
