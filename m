Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74730BB94;
	Fri, 26 Jun 2026 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497531; cv=none; b=LveWfWXG75jjz1lIyM31INLUb/hSaV147sfqbUiWeUEY+zmytBVHh0Sqsl6gqpyTRvuHCOfXmt6fmUIg8VqiDGEMlGP1Aah1wPgQesDs66DKcAzRhpjMiCNBXezFXsl8O2eRXrYd1O+GQzhuZRFyZslzg3OeSrkgGdQvZHyd99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497531; c=relaxed/simple;
	bh=ndPvzs91bbp5afyCIkhTMgFjTWprb0xWsxX3bqgUUf4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WlkqS+UhOG0gGxftkaglTHGLhKW9HG2C70OR36g0RBVZxI5exLxs9QV0gXRQfpuPz7vhGz/gJHBsOWM993Ll22ve0GPJRsqNx+4o2wvi3N47tUI+AS1Y0iXcXMcgAQ5vVnKg5+IUIFFOfsMGP6Vi2DFGG7bqRnshE0NwIagCZ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GltDbKi8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GltDbKi8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70541F000E9;
	Fri, 26 Jun 2026 18:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782497530;
	bh=q1x6FnWHbOYR7+PG1PZ+f4YkWvMajyukbNDrUd67hws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GltDbKi8o2AK54R6cd+DIdNeztD8/SqL5EmbDjXveyL0mfLtVc3xgK68rkfSdphjJ
	 Z4K1L2y0MKH5XFtpfy4TOVRgQfTu8G/dx4zKDvim9XRBQfyP5siC95Pm4G8pxTsvXH
	 Fw5lW5pue0CGGzIhnkClOVmq5NC3JfXDiV54JWr/mRjJefm9xWgsavhrqwh5PrfGAj
	 pF9kZBuFb8HflWs3d9uTb24cSa6k74Q+6WTnQTchBG8wcsArVKOEZ+2dh9DkufsR52
	 6BP60VPx+GtJ/fwAPu1LdlB7paeiGE6gmdkuLAQlyx+bOc1hdLIcKfuS3TbPBXHn/6
	 2Eo8Ehw11Y5Eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] s390/pci: Hold fmb_lock when enabling or
 disabling PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260626175525.37370-2-oelghoul@linux.ibm.com>
References: <20260626175525.37370-1-oelghoul@linux.ibm.com>
 <20260626175525.37370-2-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 18:12:09 +0000
Message-Id: <20260626181209.A70541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup in pcibios_enable_device() on pci_enable_resources=
() failure leads to FMB memory leak and Use-After-Free.
- [Medium] Race condition between pcibios_disable_device() and pci_perf_seq=
_write() allows FMB to be re-enabled on a disabled device, causing a memory=
 leak.
--

commit 2e2fca3d1e089622d5f93c6cb6a886a708c7c22d
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Hold fmb_lock when enabling or disabling PCI devices

This commit ensures fmb_lock is held in pcibios_enable_device() and
pcibios_disable_device() before calling the zpci fmb enable/disable
functions. It also adds lockdep assertions to prevent future races.

Cc: stable@vger.kernel.org

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 39bd2adfc240f..2910d4038d39c 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c

[ ... ]

> @@ -639,7 +643,9 @@ int pcibios_enable_device(struct pci_dev *pdev, int m=
ask)
>  	struct zpci_dev *zdev =3D to_zpci(pdev);
> =20
>  	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
> +	mutex_lock(&zdev->fmb_lock);
>  	zpci_fmb_enable_device(zdev);
> +	mutex_unlock(&zdev->fmb_lock);
> =20
>  	return pci_enable_resources(pdev, mask);
>  }

[Severity: High]
This is a pre-existing issue, but does this lack of cleanup on failure lead
to a use-after-free?

If pci_enable_resources() fails, the function returns an error without roll=
ing
back the debugfs initialization or the FMB allocations. Because the PCI core
considers the device disabled, pcibios_disable_device() is never called to
clean these up.

When the device is eventually released, pcibios_release_device() will drop
the zdev references without destroying the debugfs entries:

arch/s390/pci/pci.c:pcibios_release_device() {
    ...
    zpci_unmap_resources(pdev);
    zpci_zdev_put(zdev);
}

Can a subsequent userspace access to the orphaned debugfs files dereference
the freed zdev pointer and trigger a use-after-free?

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
This isn't a bug introduced by this patch, but does unlocking fmb_lock befo=
re
zpci_debug_exit_device() create a race condition with debugfs writes?

A concurrent write to the debugfs statistics file could potentially execute=
 in
the window between mutex_unlock() and zpci_debug_exit_device() removing the
files:

arch/s390/pci/pci_debug.c:pci_perf_seq_write() {
    ...
    mutex_lock(&zdev->fmb_lock);
    switch (val) {
    ...
    case 1:
        rc =3D zpci_fmb_enable_device(zdev);
        break;
    }
    mutex_unlock(&zdev->fmb_lock);
}

If pci_perf_seq_write() acquires the lock in this window, could it successf=
ully
re-enable the FMB in hardware right before zpci_debug_exit_device() destroys
the debug entries, leaving the FMB enabled but permanently leaking the memo=
ry
upon device release?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626175525.3737=
0-1-oelghoul@linux.ibm.com?part=3D1
