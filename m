Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D74E56CA;
	Fri,  9 Oct 2026 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546911; cv=none; b=t41E5AiLE8FAq7lxQ+2dveIcXR7jsOJr4TlPaD395wx9qLMfBBsXNscrG3HDoIP0JuibGxcWWtn2nTGoPn1p3eM8sPbA4oybf5K2EFSE+3Lvb3Vh1m3+c9RJXJqupZrbKDB3wJ2Mzpo8aRftznjd6qPPHCBgpUgCozUuBCPcl4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546911; c=relaxed/simple;
	bh=GupX4CGbeBeYUoki3KEb6Hbzqx8qGQWlvkJK/JKmwbI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NEnxKdQFRnJWf0SOvM+bFV7oFfLZAbPJFxmUy+GfAkaRdxyXT4tny8BgxF/k0aIZY6Ojhlm8gqCxLs90bhywF9uHGDGBWya5ALZlGUZZyKqEoC6pAQvpgVMfLGV6Jk9iIkfbi9K+/Le6jnUvnCqo+vOtJa4rQN10na6A6KUvwck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCTbfAen; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCTbfAen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5AB1F00893;
	Fri,  9 Oct 2026 11:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546901;
	bh=a1Mup3U52T/gGkBsL9oByCwxlUNNzI/EY+vLZg3LlIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lCTbfAenNQxwYxx1okhwbYziWjUubP0Okpxyf1EyBhJVyMQxHjACZZoJ0Odlyuq3y
	 jqSkYuGqVrJFpUI28OhrEJNBWG6eXwRKx8xqo3ll3yU3RO8xw/swQSPesVh3qLZwtO
	 p10T25T680xP+WY04R/ZWrGl8mI4rOOSTnlwfnsvPWdHOBVgKZ2MbstQk/XuA01kfn
	 1C3/LSvS8qc8Cg3kjqswJcjhQH0BYIe8pWkSbC46tREjgxYpmQLLSBGdoGnPy/gig+
	 oT2dSOhOiCtz7m8O1GraHBcF/BhCaZm5QZAcfG7Qhke+CpGYOrc9zy+fHM4QmFscTD
	 /wIBVFyyQeqrg==
Message-ID: <sashiko-outbox-165448@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/15] s390/vfio-ap: Data structures for facilitating
 vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261009114244.1213173-3-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:55:00 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] vfio-ap: migration ABI layout depends on internal kernel macro AP_=
DOMAINS
- [High] s390/vfio-ap: missing interrupt state in migration ABI
--

commit a77ac9d23bc32798a481b033c179b8862ae321e5
Author: Anthony Krowiak <akrowiak@linux.ibm.com>

s390/vfio-ap: Data structures for facilitating vfio device migration

This commit introduces the data structures used to facilitate state
transitions during vfio device migration for the s390 crypto subsystem.
It adds the foundational structures for saving and restoring AP configurati=
on.

> diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypt=
o/vfio_ap_migration.c
> new file mode 100644
> index 0000000000000..f76d151a5ccec
> --- /dev/null
> +++ b/drivers/s390/crypto/vfio_ap_migration.c

[ ... ]

> +struct vfio_ap_queue_info {
> +	u64 data;
> +	u16 apqn;
> +	u8  reserved[6];
> +};

[Severity: High]
Does this structure capture the necessary fields for interrupt configuration
state?

During live migration, the guest's saved_iova and saved_isc appear to be
dropped as they are omitted here. After live migration, will AP queues on t=
he
destination host have interrupts disabled because the Notification Indicator
Byte (NIB) address is not restored, potentially causing guests waiting for
crypto operations to hang?

Furthermore, since the 6-byte reserved padding is too small to hold an 8-by=
te
saved_iova and 1-byte saved_isc, could this prevent non-destructively
extending the ABI later without breaking compatibility?

[ ... ]

> +struct vfio_ap_config {
> +	u32				magic;
> +	u32				version;
> +	u32				num_queues;
> +	u8				reserved[4];
> +	u64				adm[DIV_ROUND_UP(AP_DOMAINS, 64)];
> +	struct vfio_ap_queue_info	qinfo[] __counted_by(num_queues);
> +};

[Severity: High]
Does relying on the internal AP_DOMAINS macro here tie the migration ABI
layout to potentially changing architecture limits?

Since this struct is directly read from and written to the migration file
stream as raw bytes, if the AP_DOMAINS macro increases in the future
to support new hardware limits, wouldn't the size of the adm array grow
and shift the start offset of the qinfo[] array?

This could silently break migration compatibility between older and newer
kernels without a protocol version bump, as the destination would read qinfo
elements from the wrong offset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114244.1213=
173-1-akrowiak@linux.ibm.com?part=3D2
