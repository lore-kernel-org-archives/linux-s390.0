Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82942771E;
	Sat, 25 Jul 2026 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994293; cv=none; b=rfI9JxuevTpnPhidQNfVe6R8BNc3ssmN5LIQW4qA10h74PtiE3jJ/rDMjLIws4RJ/Lro0DLgExbfG2nTeOjHLafJngtJXKTGraWtUyhN+FZcMUi1lo7k4EEMyaTtd0WiVFgH08lG3YsaD0X2cwnySErQ8xNTbnyIn6UFBveLvhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994293; c=relaxed/simple;
	bh=7qjLAD4hcYVSM2hDc35lQRh058fYuVAJy4e3td16rEQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r7+DsedSBHW+g1lWEgWlsuOGVQrshsZlv0ozauOIwiOgxIAd8eurs2z4PUz9n/Y/4vuae90HEDK+ebvHxsLiBOcUeR1gmp/vKVvEpmjH2xrx0PadCNnA60PukCL5vZR4bwxra78s5pvieJEoR2z0omnSsIA1ayyevP61jsX1Wic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3xmNPAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3xmNPAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022231F00ADB;
	Sat, 25 Jul 2026 15:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784994287;
	bh=DG8U1X8BU9TKKTZuFvEXPFuBOYoIHlmXuE/7U3viq4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T3xmNPAS6ArBPOEG0TVCZfWsRyTXN8Fs+ZJNdjuq5BIzezKkI2fjotD03L9E0rfDJ
	 Nq5TtC10+3OomrqCAjt5/5nsCoT6tZqs4L5lCTL12wixaAw7CZsIZo7+Asb07bYePp
	 mqm+Okv1Xi6KvLjAGqwOwpsKVUX6VSXZNtpmtftZ/chvSkkvqqTexPggI1S7zIxHLP
	 oaKQ4VQP+wjs9z973exO/qsAjFS/z+9zqSFJleNC1meoH1ORbxYJo5fPlfyY47tA8s
	 FRM7RsmxBQ1vOsNl4sK1iLrHDzWHMEJVa+xDoEmoExHtIU79MJCg6QOsGvWXDLNH+q
	 0gCsAObDdWBaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] s390/vfio_ccw: ensure first IDAW remains
 constant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260725152705.3958100-5-farman@linux.ibm.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-5-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:44:46 +0000
Message-Id: <20260725154447.022231F00ADB@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `get_guest_idal` reads past the end of the guest's IDAL buffer for=
 format-1 IDALs, potentially causing spurious DMA faults.
- [High] Untranslated guest IDALs are passed to the host channel subsystem =
when data transfer is skipped, causing hardware Program Checks.
--

--- Patch [4]: [PATCH v4 4/9] s390/vfio_ccw: ensure first IDAW remains cons=
tant ---
commit ff6c62bce82b594d19f9d6e95c9229ea752d6614
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure first IDAW remains constant

The first IDAW in a list does not need to be on a 2K/4K boundary like all
others, and so is read separately to accurately calculate the size of the
buffer needed to read the full IDAL. This commit validates that the address
found in the first IDAW is unchanged between reads.

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
        ^^^^

[Severity: High]
This is a pre-existing issue, but does get_guest_idal() read past the end of
the guest's IDAL buffer for format-1 IDALs?

It appears that idal_len is calculated using sizeof(*idaws), which is alway=
s 8
bytes (sizeof(dma64_t)), even when the guest uses 32-bit (format-1) IDAWs.

Later in get_guest_idal(), vfio_dma_rw() is called with this idal_len:

	if (ccw_is_idal(ccw)) {
		/* Copy IDAL from guest */
		ret =3D vfio_dma_rw(vdev, dma32_to_u32(ccw->cda), idaws, idal_len, false);

If a guest channel program uses Format-1 (32-bit) IDAWs, they are only 4 by=
tes
each. Calling vfio_dma_rw() with idaw_nr * 8 reads 100% past the end of the
guest's IDAL buffer.

If the guest's 32-bit IDAL ends near a page boundary and the adjacent page =
is
unmapped or restricted, this over-read could cross into unmapped guest memo=
ry
and fail, potentially spuriously rejecting a valid guest I/O request with a
DMA translation error.

>  	int idaw_size =3D idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
>  	int idaw_mask =3D ~(idaw_size - 1);

[ ... ]

[Severity: High]
This is also a pre-existing issue, but does ccwchain_fetch_ccw() pass
untranslated guest IDALs to the host channel subsystem when data transfer is
skipped?

Looking at ccwchain_fetch_ccw(), if ccw_does_data_transfer(ccw) is false
(e.g., a READ CCW with the SKIP flag), pa->pa_nr is set to 0:

	if (ccw_does_data_transfer(ccw)) {
		ret =3D page_array_pin(pa, vdev, idal_is_2k(cp));
		if (ret < 0)
			goto out_unpin;
	} else {
		pa->pa_nr =3D 0;
	}

	ccw->cda =3D virt_to_dma32(idaws);
	ccw->flags |=3D CCW_FLAG_IDA;

	/* Populate the IDAL with pinned/translated addresses from page */
	page_array_idal_create_words(pa, idaws);

Consequently, page_array_idal_create_words() loops 0 times, leaving the ida=
ws
buffer populated with raw guest IOVAs instead of valid host absolute addres=
ses.

Since vfio-ccw forces orb.cmd.c64 =3D 1 (Format-2, 64-bit IDAWs) when issui=
ng the
SSCH to the host channel subsystem, the hardware will fetch these untransla=
ted
guest IOVAs. If the guest used 32-bit IDAWs, they are read as garbage 64-bit
pointers.

Will the hardware validate these invalid addresses during execution and tri=
gger
a Channel Program Check, spuriously failing the guest's SKIP I/O request?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725152705.3958=
100-1-farman@linux.ibm.com?part=3D4
