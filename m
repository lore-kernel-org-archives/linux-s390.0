Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9315C3793A8;
	Tue, 28 Jul 2026 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211197; cv=none; b=obVpYYXiQcrvHBoLhVMVBTFeZ3bfwXHNnI98rkUaf0qVpkxE9D7MR8e8SAjoscjag+cNjP0nzw60h5KkhzqOpqQEEr4fkXA3+/uZA2mNL1HLX+c7sD1LLB5HrDri4yICauGN7b7S/yn1070RSrJi8CTcWAZAcUUp0pU2KeLLdik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211197; c=relaxed/simple;
	bh=T5GWt3NzYRe84IRGvYlttEcoh/cL0SRn7H0I1N902Kg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LD5+APvf1sJKN02jBJtMUx5UKSMg5pb6vtKVrR7ixYA/BiDAqoTW5W13rX4eHP1qRuafvkpDUihmtv6AHnwA8VV4omz2TNWtaHtAR0HHy5ZBLR5PjVKpCu/yhj88+mRrJMevnX4lquKAhwHwLyrCupWNwOmvsQVwW4ei/4sacIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/9RQ7XQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/9RQ7XQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9781A1F00A3A;
	Tue, 28 Jul 2026 03:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211192;
	bh=idOTq3gaHjRPg9EKrYnaOYO0QsIdMHZYL4kutmNXjFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R/9RQ7XQsljOFBUOpiwnjESh5CdqSO61prynURNbv0LnMxn2Tc/W/iaqGg6I53q54
	 tLdFwSdXSlco+yPjMmUpPScWh3bExSAaZ0Z6NziO0o2GlD446RWrXPcxd6SJ08UmUg
	 RSrwHkuimrnrGQbHaE+6q8PRNwxjuUkYC+DoP9l/6zwgNq7UEjYQUZk3ifL4lxr6Vw
	 RYssVO2C5B+6/ybPsyZ0Vv/TwVLCfyTcuHdLhn0qL8W0DuU7kBKJ0ZIGlQJq2z3ACK
	 UA8Dg4/DxXEWWEz2cePH3cSvwM4vfBsdbirlzSVA2VLES0tYuM0GYwDNWYTR033Zwo
	 55HB0B4qkKoyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/10] s390/vfio_ccw: ensure first IDAW remains
 constant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260728033022.2658232-5-farman@linux.ibm.com>
References: <20260728033022.2658232-1-farman@linux.ibm.com>
 <20260728033022.2658232-5-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 03:59:51 +0000
Message-Id: <20260728035951.9781A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] When processing Format-1 IDALs (32-bit IDAWs), get_guest_idal() co=
mputes idal_len using the size of a 64-bit host IDAW structure (idaw_nr * 8=
) rather than the actual 32-bit size of the guest IDAWs (idaw_nr * 4), caus=
ing an over-read of guest memory.
--

--- Patch [4]: [PATCH v9 04/10] s390/vfio_ccw: ensure first IDAW remains co=
nstant ---
commit befdc53db29630758bc9d091cedca02c65d65181
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure first IDAW remains constant

The first IDAW in a list is read separately to calculate the needed
buffer size. This patch verifies that the address found in the first
IDAW remains unchanged between reads to ensure a consistent set of IDAWs.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index af632f9d54535..6275794751cb4 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -523,6 +523,7 @@ static dma64_t *get_guest_idal(struct ccw1 *ccw, stru=
ct channel_program *cp, int
>  		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
>  	dma64_t *idaws;
>  	dma32_t *idaws_f1;
> +	u64 first_idaw;
>  	int idal_len =3D idaw_nr * sizeof(*idaws);

[Severity: High]
This is a pre-existing issue, but does this calculate an oversized length
for 32-bit Format-1 guest IDAWs?

When processing Format-1 IDALs, idaws is a dma64_t pointer (8 bytes).
Using sizeof(*idaws) means idal_len evaluates to idaw_nr * 8. Later in
get_guest_idal(), vfio_dma_rw() uses this oversized length:

	if (ccw_is_idal(ccw)) {
		/* Copy IDAL from guest */
		ret =3D vfio_dma_rw(vdev, dma32_to_u32(ccw->cda), idaws,
				  idal_len, false);

Could this cause valid I/O operations to fail with an error if the 32-bit
IDAL is located near the end of a mapped guest page, resulting in an
over-read into an unmapped DMA region?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728033022.2658=
232-1-farman@linux.ibm.com?part=3D4
