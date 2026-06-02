Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A673BA235;
	Tue,  2 Jun 2026 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439056; cv=none; b=hYwocWouSQVRcGu5WaqHAtX7m93jYI2aOb/n/nZMOmeQSXP5WTWFyMaS7dgJMKQw2kyBpOcyEAJ7Sm6Q/n4Or3QK3GG1zbQ+aoGFN/WxFR7Jdpkwb9o2e/zoxFtCutQsXtKL30qeWuqNcbQFNhknXUvP9gF5iO+7SYBQ7YzP1f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439056; c=relaxed/simple;
	bh=qk2gjXI3NoBy2QULb52AKHE9XZvZDY+WdJfRMde0vZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZ+crQjIVum4JSBKfB8p9HtSyBSLufMBNwKfVrGFuHdZkLy80ox230SwRdce+tDRTr6fzJt4CF5Iy487fOkbyQVsiGzy+SF4+SBofFnnO6ds1qlqLjpB5SGL44xBVV6roO4CDm2p6V1KKttxkKFI1tPQDZHEjxLudNJUG3UuFQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=MWl5kgBc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DTq11pSR; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="MWl5kgBc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DTq11pSR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8C4FC1D000AF;
	Tue,  2 Jun 2026 18:24:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 02 Jun 2026 18:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780439052;
	 x=1780525452; bh=HpsO3gd0wMcI3QhvrGbYU8+xypx9sZlOFSo6f6xcyiU=; b=
	MWl5kgBcu9nqWnG9LdYhh8w2wmsD4XzW2NnEsrRs4NWPNP4eSYHzAFCya/nQPjRL
	CQZ7/LwT5XwF9PpVU3PhZSao54VQ0NU7Sitdz2V7JyW8Z9K2aRVL+uoS8j763Hlz
	3egGju3Gw81CR9te6uobe5LZe6TE+l36vcDlGu2+UXCREDI8DDoy6nkgWzAQVgM2
	U2kD2qf2OCyE5Pll1anyLHBdIig0TtUD0i7JFxXM+Dx13Se7ZCSiwgwLEXzkEb8R
	N23ZkXOQDIRxxUarMVcvCLcFZVnFief84Ua64U1iIldxLRXXjYiPhFMxYQS7ICjW
	Gvb2D+gL034Yf/IFEPjbSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780439052; x=
	1780525452; bh=HpsO3gd0wMcI3QhvrGbYU8+xypx9sZlOFSo6f6xcyiU=; b=D
	Tq11pSRGK554bUHipDyXwbbsfasPvZDFKQVDvD1oRPgCf8rO+NnC1ywW3QW8hJJR
	4rfm0lagGPN2DJXlt+o7Q9cxLbz7e8094K9G2tnxUTKXlxub496jPY/+vpcReAWP
	mV+2uIKpHSiymhm6fxkLh04zU3RlmaiETxCkWW+q7LKmgCSmVmkpcSrRSTwxg2Jt
	uGmoQ2XCVKtxiuX2svHwfeL2e5xrKP8OwG75lJyFHQz+ypTt2TnpLEgITdFaxKvp
	qS4TT6wXMwLnABPeMJs6uYsPwJXRQt7bnFSwkFhY9dghliAtRPqDtS5AUfte1p2h
	iLMDiwo3B5+HnOrPYc5SQ==
X-ME-Sender: <xms:C1gfaub6iouHFw11PGxty0R1GDNEER4BOBFoTafztilPRrcd3j3UFg>
    <xme:C1gfaiwPummpVbhvC3SwX6IHrzrrh8Tl9j_C1R-AWE3de82QNmZHJSbRq2w4kTJGc
    U0UHdFGvvjJqWevTZMvGSoAdXhzMtXUvVMMl2NoNHAfJ3Vn6vmwgA>
X-ME-Received: <xmr:C1gfaiO9IO6qz4G1Jw3qZoQrh-zF9tX4Of-gUS5jQPYbvEXF5HEAlSagQKg>
X-ME-Proxy-Cause: dmFkZTEzFQQjv+SjWR4wAB+CXIyzIejqvDcZZfMXru6LkBHWQi3phvq5Zs3hDvM3bL6qEV
    ttan/L1BO4N6mQAlskzLR2o9PPltk0LTBwCwSVuqwxc76foIHu/voLDHnEu715nqiqayvA
    r9Q8QRKvMQDUGiWq7J9HgTka9vUgPCvHbgHE6HbKYl6/a3L5yYDnF+Vz3nMr/ogVxBdw9v
    Tnx3zf/zETaHEhR8r+GFu1KuF3e9zbFrAr/8LGrd+wQeDim1D0u0ZO4jQo7PfmB066UCkI
    ZEwRIsQTKGsBighIMe6p50SUE54xAufKpFkWn1z+VdQ1+I4Mr5Pxv7CigTudPuRyW0N7H6
    hLK5dnDv3YDCDjHa+/1Hd7IGehXObtJ2VWXEpm++9GvfF2d78M29bQfH/hIiffNr0Gs0Mb
    GcO1dqz3e+nz6TtNU43IvN/IHVjYQSEqv82IDAIxef95C800bgtAbboBVKI4WwceH11yom
    Jdm7Uh+EFDITlVZE9uB/7ddSKOxRH+s8qJqi291bJFfnh8u2bc6JhJqZyaqEz5yHTI6B9J
    qhYhdBslfWu4rASE6ziI6SfCNKec419VnQIIJZdC0vNGS0efMA08eFBtpgfG3dVpE6a251
    1HnYc8laMDGIZ/ZTGiR4E1rw1b/Wzso2jCFb/26FDtwRZO5KvOPsV5xLqGYQ
X-ME-Proxy: <xmx:C1gfao6wGIjsr6eTfj9f9iahqZ5quCj-mjgB3pT5p4SHx3nKFVD9mQ>
    <xmx:C1gfagfKsB3SFaYNdaAtgUuO0jZGLJxHMhkg2UMjkE_xYXU7qIyUJQ>
    <xmx:C1gfapKsH9_SPvmCgAAMqVhMRtPh1c16Xa7YOuiOOngF2AB7yhElrQ>
    <xmx:C1gfamn4Dtr7636PH4VuBKXPPN4FXNY2tPzlrmhctcena0AVdZqBcg>
    <xmx:DFgfan5pZikWQl-vKU_nfaaCSbgeqpLEYGaVX1-zXb7u6o35bYYWAFaO>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 18:24:10 -0400 (EDT)
Date: Tue, 2 Jun 2026 16:24:09 -0600
From: Alex Williamson <alex@shazbot.org>
To: Omar Elghoul <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v2 2/3] vfio-pci/zdev: Add VFIO FMB device feature
Message-ID: <20260602162409.1ca3c765@shazbot.org>
In-Reply-To: <20260519224204.19154-3-oelghoul@linux.ibm.com>
References: <20260519224204.19154-1-oelghoul@linux.ibm.com>
	<20260519224204.19154-3-oelghoul@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 18:42:03 -0400
Omar Elghoul <oelghoul@linux.ibm.com> wrote:
> diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> index 0990fdb146b7..1e9efe2bee69 100644
> --- a/drivers/vfio/pci/vfio_pci_zdev.c
> +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> @@ -167,3 +167,80 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
>  	if (zpci_kvm_hook.kvm_unregister)
>  		zpci_kvm_hook.kvm_unregister(zdev);
>  }
> +
> +int vfio_pci_zdev_feature_fmb(struct vfio_pci_core_device *vdev, u32 flags,
> +			      void __user *arg, size_t argsz)
> +{
> +	struct zpci_dev *zdev;
> +	struct vfio_device_feature_zpci_fmb fmb = {0};
> +	u32 ops = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_SET;

Somewhat gratuitous variable usage.

> +	int ret;
> +
> +	ret = vfio_check_feature(flags, argsz, ops, sizeof(fmb));
> +	if (ret != 1)
> +		return ret;
> +
> +	zdev = to_zpci(vdev->pdev);
> +	if (!zdev)
> +		return -ENODEV;
> +
> +	mutex_lock(&zdev->fmb_lock);

Use a guard and avoid the release_lock gotos.

> +	if (flags & VFIO_DEVICE_FEATURE_SET) {
> +		if (copy_from_user(&fmb, arg, sizeof(fmb))) {
> +			ret = -EFAULT;
> +			goto release_lock;
> +		}
> +
> +		if (fmb.flags & VFIO_DEVICE_FEATURE_ZPCI_FMB_FLAGS_ENABLED)
> +			ret = zpci_fmb_reenable_device(zdev);
> +		else
> +			ret = zpci_fmb_disable_device(zdev);
> +		goto release_lock;

Remaining flag bits are not tested, breaks any future expanded use of
flags.

Why does the user need to be able to control these?

Doesn't allowing the user to disable FMB remove guaranteed host-based
monitoring?

Since this is already provided via debugfs, why not make this a
userspace problem to interact with the existing interface?

Alternatively, couldn't the existing zpci mediation be extended to
support the guest registering a fmb buffer to be written at regular
intervals (the interface here seems to drop the reporting interval).

> +	}
> +
> +	ret = 0;
> +	if (zdev->fmb) {
> +		fmb.flags |= VFIO_DEVICE_FEATURE_ZPCI_FMB_FLAGS_ENABLED;
> +	} else {
> +		fmb.flags &= ~VFIO_DEVICE_FEATURE_ZPCI_FMB_FLAGS_ENABLED;
> +		goto release_lock;
> +	}

Flag bit is cleared, goto skips copy-to-user, returns success...

Regardless of what's documented in the header, the buffer should be
assumed to be userspace garbage.  Failing to set or clear the entire
flags field precludes any future use.

Why do we need to use flags to indicate the enable state?  Couldn't we
just as easily have success indicate enabled and -ENOMSG indicate
disabled?  Thanks,

Alex
