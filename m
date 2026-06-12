Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181AD399031;
	Fri, 12 Jun 2026 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288796; cv=none; b=WFUkebxzjSJQTfP3h02o6iAmqgEMyIzec3yFgOzWJDeRSo0kQIY1Lbc1erl71IAwx9H97AOJf9qh+90CDQE8WCuLRP2BlGf2oECzJVBgMpgaeNhAC5EoPe1zHaM7y7gODEdgQhkhAcOcLy2b/aUrW1fnmnIghkdBwlGd0r3HZfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288796; c=relaxed/simple;
	bh=DxFw9DzADdJwvw8erhmvQIon9AtoFno5XXrR0oQp6iY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cu0IfbRxOXpeBhBBn5i9jIYE5suWiyEdQRYGyGDtEyYMCNrfr2Ee+hF5+MGvlixmYKg0013NJ8rnIpT+bpRxUZAyNMggGR5nzbFeE9+PvC6ssahvYuWElZo6+yW2Ptfsdj/7VsZ/wDjWcM+5/TU2uGQN6KP6J1QpCTFww7oyhrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beXSFYkB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beXSFYkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EE71F000E9;
	Fri, 12 Jun 2026 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781288793;
	bh=geVjcGeVFeXtkciELUdBMW5RuU1hD98qGXtlXcTJi8o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=beXSFYkBuW1o8Uze6ZsaFMF34jRWAnHDHIZxi5uzrwDC55Ky0V54cQFhjT01UWOEm
	 01NxHBQ/Q9sGe7gPDowY/tFf3h/8/A1G9MjHcWCDGnLQIEBI4Mm+ZWE8VzpLV4Lr/O
	 rqgF1S9RPytySEeLbziyMwWAKZxv5L6tbL/JcY0YGsSkQ4lXGvPAHGN5TFyRgBWwMy
	 j5TC9YaXvQgQ9g8hKsRGzHpoZOyx0zQm2b5Fl2+RtdjFbfrCnDcgvhEdV8beQyCxRw
	 8jc4IwRX0I5w8rb2Qk0SVAEZwbwn/mNfvmz/H9zqO+3Ed4jn/NW3eSoVyAdawz7xzX
	 Q84mPygoikGVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] s390/pci: Preserve FMB state in device
 re-enablement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260612181048.91548-3-oelghoul@linux.ibm.com>
References: <20260612181048.91548-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:26:31 +0000
Message-Id: <20260612182632.E4EE71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] zpci_fmb_reenable_device() reuses the existing FMB hardware buff=
er without zeroing it, exposing stale hardware counter values until the fir=
st periodic hardware update occurs.
--

commit a81b1b0a067d09df54d661ddbb8985e9220d9a88
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Preserve FMB state in device re-enablement

This commit introduces zpci_fmb_reenable_device() to reuse the existing FMB
buffer during device re-enablement instead of allocating a new one. It also
refactors the FMB enablement and software counter clearing logic into shared
helpers.

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 2910d4038d39c..21d3fccac7894 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c

[ ... ]

> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
> +{
> +	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> +	struct zpci_fib fib =3D {0};
> +	u8 cc, status;
> +	int rc;
> +
> +	lockdep_assert_held(&zdev->fmb_lock);
> +
> +	if (!zdev->fmb)
> +		return zpci_fmb_enable_device(zdev);
> +
> +	fib.gd =3D zdev->gisa;
> +	cc =3D zpci_mod_fc(req, &fib, &status); /* Disable function measurement=
 */
> +
> +	/* Unlike in zpci_fmb_disable_device(), cc =3D=3D 3 is not a valid stat=
e here
> +	 * because we are re-enabling function measurement for the same function
> +	 * handle.
> +	 */
> +	if (cc)
> +		return -EIO;
> +
> +	zpci_fmb_clear_iommu_ctrs(zdev);
> +

[Severity: Medium]
Does this code need to zero the reused zdev->fmb buffer before enabling it?

The commit message states that a program resetting an FMB should see all
counters start from zero. While zpci_fmb_clear_iommu_ctrs() clears the
software-maintained IOMMU counters, the hardware-maintained FMB buffer
(zdev->fmb) is reused here without being cleared.

Could this expose stale hardware counter values to userspace until the
first asynchronous hardware update occurs? The previous behavior in
zpci_fmb_enable_device() allocated a fresh, zero-initialized buffer via
kmem_cache_zalloc().

> +	rc =3D zpci_fmb_do_enable(zdev);
> +	if (rc) {
> +		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> +		zdev->fmb =3D NULL;
> +	}
> +
> +	return rc;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612181048.9154=
8-1-oelghoul@linux.ibm.com?part=3D2
