Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D299C445AD1;
	Wed,  7 Oct 2026 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382421; cv=none; b=GiF9YYBmE+BinHJtVQEcJNl2A8kZl1LE49aJx2BTNpQtXgTzJY38TD7jbTxKes8ZHz6p93XLK9v1q5xEZleXWBfgpUGs60kxxhzruubyNqj/yf3uIW1zSSL8T8XrvkVq8RiA5d0UAooxXmpTahWDtrxXzph8tLVWfSciLSDt5Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382421; c=relaxed/simple;
	bh=S/Y/v7m98QViY7QbF+u2jSDcUa1o0Zh3RjdOurlQnM4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YxA81gYoqcTWQRgjdtrs64Ku2z9Bz2Hfh4P5GUalMBRWzhwfjudmTKMECLiQyEGF7ZDBWgNj4/haz0FOE9LZMgseJraW5A6Ey3VZD+bppdav/buHorgvMbLBudoKfgco4UfITtGVDCBcfleB2+4wZJNSNkKvdJcfiAs2/lb8ygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzCwwPgG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzCwwPgG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6FB1F0089B;
	Wed,  7 Oct 2026 14:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382417;
	bh=xoRtVuT9kBl5tsRnib/Ng0feZcp1YNVr4ICXsU+qq2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mzCwwPgGj90yfTd4rKURlyOx883Kqe3e9ZFvguoJyTa/AprUGXsE0TTr+crlTD1Mu
	 xTrHvew8dGmzi6x3YPCwBTrPN4RlKS3m+9BDXNRa4Sw5drpmt4t0qH/wLTrL5Uotr2
	 koOpGUWdaY0PmwvVF5zvATWTjDIkT5b+BMYB66MgGrnWT+nN1HvSUdB9FWPcwRdV2h
	 RjEVuw2B7TdiXerfkQy9YsUFmzrZGKXJn1N9SGxmff4mta+h2FZspw25WN7YfS3sNf
	 wEJKcLmTWhjxpPvLHtNiHRQ4o5UT7dR41QhuVegQu8VKaXWkXYs2SUkVA0GXD1V5Ki
	 W+QLbdPX01YsA==
Message-ID: <sashiko-outbox-163092@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/4] s390/pci: Hold fmb_lock when enabling or
 disabling PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261007135926.82935-2-oelghoul@linux.ibm.com>
References: <20261007135926.82935-1-oelghoul@linux.ibm.com>
 <20261007135926.82935-2-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 14:13:36 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390/pci: race in pcibios_disable_device leaves FMB enabled
--

commit 0f2a2ae0e5e387c72b216a0f886fdb95698ac275
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Hold fmb_lock when enabling or disabling PCI devices
   =20
Ensure that fmb_lock is held by pcibios_enable_device() and
pcibios_disable_device() when calling zpci_fmb_enable_device() or
zpci_fmb_disable_device(), respectively.

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index d64c544b32b0c..c055a9ad09724 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c

[ ... ]

> @@ -648,7 +654,9 @@ void pcibios_disable_device(struct pci_dev *pdev)
>  {
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> =20
> +	mutex_lock(&zdev->fmb_lock);
>  	zpci_fmb_disable_device(zdev);
> +	mutex_unlock(&zdev->fmb_lock);
>  	zpci_debug_exit_device(zdev);
>  }

[Severity: Medium]
Could this sequence allow a race condition with debugfs?

If a concurrent write to the debugfs statistics file occurs in the window
after mutex_unlock() but before zpci_debug_exit_device(), it appears it cou=
ld
acquire fmb_lock and invoke zpci_fmb_enable_device().

If this happens, does it leave the FMB running in hardware without a debugfs
interface to control it, while also leaking the zdev->fmb memory?

Would it be safer to call zpci_debug_exit_device(zdev) before acquiring
fmb_lock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007135926.8293=
5-1-oelghoul@linux.ibm.com?part=3D1
