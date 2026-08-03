Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E06332907;
	Mon,  3 Aug 2026 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774273; cv=none; b=MUrRXgay5bxCQ+uUiQT867n5Bq6h99RIm6Ss/pj9wQJsbgAHtDIhNdCsRlSlf5jNWk01MOoI6TyWVNXKxcezCJam++R+5CO/6M2rlWQaytTsNS9zoqFZaUuVNyhKyDxq0ouDueua2ZRRk0F1UE3IklnmIUdw0GLhAhbF/j6n4D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774273; c=relaxed/simple;
	bh=yHW4KIrcgyw7EKoWXLy7TpK7UIgVKRPu4M/DvtzjOl4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VWBKMM2wwolP4pQ+NteQq14WMyJg/COFhFlDiblCxje4uTGEfT97xRGt46i3gz/KnYKtC/ys7k1/e2T4n69Heg/JP6LWljBKUlHqQdkLPcyP/LpQuN667WiKL4yiuBDKNREtXsczTGWd5UwKNN5FQWEkqrBQ+zkc4+NzTmDJcrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY710zl3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY710zl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A541F000E9;
	Mon,  3 Aug 2026 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785774270;
	bh=g3O1oDmpjOCmW7t8Aw5VD+BPLCYZkCpvLa0doeP/4Mw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NY710zl3oXJxWyhMS4JmvrTC9g/l5u/cHomTAp+7ATA6aYx+svIUZZK+wF3t7OLfq
	 Bok5gs1mzHVbFZnSRywKrORgZPKM5FwcrHhHcG4Yn+Cb+Hmiz/3JirfnELMME4lBza
	 Jw2RwXqFXpBnDAVa9tp7szmzD9fqfe9cmZfDruqhAuWHIXwST1ciUzl5b3dLDPqvEe
	 3UgoIjiTGsPqLChVLzxlDRyRem6Nk07AhtE3SOSjFiv6YsgR93r8t3v2QIZW+A9rrh
	 zXMNChX6KIko7mGqbfNOd3hlOlDgjnxQ8zhpTIb4YBAGrbuZ+DLftvhJ3BcFH3QUJj
	 LiFnUMYy6GXkQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 04/23] s390/vfio_ccw: Ensure first IDAW remains
 constant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803160924.236807-5-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:24:29 +0000
Message-Id: <20260803162430.45A541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Guest memory over-read in get_guest_idal() for Format-1 IDALs requ=
ests twice the actual size of the guest's IDAL, potentially causing valid c=
hannel programs to be rejected.
- [High] When processing a CCW with the SKIP flag and IDA flag, the driver =
fails to translate the guest IDAWs into valid host physical addresses, pote=
ntially causing a host Channel Program Check.
--

--- Patch [4]: [GIT PULL v1 04/23] s390/vfio_ccw: Ensure first IDAW remains=
 constant ---
commit fb0447391e53154ceda5e61ab696ff1e49d88abb
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: Ensure first IDAW remains constant

The first IDAW in a list does not need to be on a 2K/4K boundary
like all others, and so is read separately to accurately calculate
the size of the buffer needed to read the full IDAL. Verify that
the address found in the first IDAW is unchanged between reads,
to ensure a consistent set of IDAWs being worked with.

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
This isn't a bug introduced by this patch, but does this over-calculate the
length for Format-1 IDALs?

Since Format-1 IDAWs are only 4 bytes long, but sizeof(*idaws) is 8 bytes,
idal_len ends up being twice the actual size.

When vfio_dma_rw() is called a few lines later:

    ret =3D vfio_dma_rw(vdev, dma32_to_u32(ccw->cda), idaws, idal_len, fals=
e);

could this attempt to read past the allocated IDAL size in guest memory? If
the over-read crosses into an unmapped page, it might spuriously reject a
valid guest channel program.

[ ... ]

I also noticed another issue in the same file.

[Severity: High]
This is a pre-existing issue, but do we correctly handle guest IDAW
translation when a CCW has both the SKIP and IDA flags set?

For such commands, ccw_does_data_transfer() returns 0, bypassing page
pinning:

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_fetch_ccw() {
    ...
    if (!ccw_does_data_transfer(ccw)) {
        ...
        pa->pa_nr =3D 0;
    }
    ...
    page_array_idal_create_words(pa, idaws);
}

Because pa->pa_nr is 0, page_array_idal_create_words() returns without doing
anything, leaving the raw guest virtual addresses (IOVAs) in the idaws arra=
y.

Will the host channel subsystem hardware fetch these invalid physical
addresses and raise an access exception (Program Check), failing the valid
guest request?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D4
