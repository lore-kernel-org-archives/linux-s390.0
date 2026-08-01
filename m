Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB64A3BADA7
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785608778; cv=none; b=LpnSQykiSJ/U5ogM0cgJgEymr/V4HW1hfz6UGvxCg4IbxvrjHw6W5RoKm77O33nQF0Wc2iXIt3OE7zmac+qE10/nFrTaJ8GXrF2u8gyaNB+Q82QcHm34WUxx9bBq70y5Pz/apoeXXbeLp6IxYa5BF5ZdCOjvNHiQJ2K/pi85xXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785608778; c=relaxed/simple;
	bh=f4DGu7d6WcwQHE+IAEkfzhM+VJOzsbZykNzxVVKgyVI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hfx+t/13w1l8W48v71hbedTACC0pbOLugmZsJtowo+uxKzUIjnogbLA2qLLz/sNCEpXWo7s/piL9zEwEnQ3kNLSsYQJmR6ghfkDNsH5uCvu4Geum1Sh+xPIxV5G+vDVtesic6PjO+s1+0W5Rk7qHvX97ipg9DZJI6Jaq6SXtrGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzNs3Ngg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzNs3Ngg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221D61F00AC4;
	Sat,  1 Aug 2026 18:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785608777;
	bh=+AyQMQVIl4ZGpSMfvDZMkttCVyouaGs5ZMTxv22gIJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nzNs3NggTSgJL1uPsCLYhGy9+7h7sNjuR8ppvTvFICIC+8emmeaWepW0SEk7sgnNR
	 POZJE6Ak7Ugz/DVWdViu8Elue/zcjiVrn2lHc04XMYsGjceYuasMc1G3NQAzXVSY4Q
	 YWTqlMaKBtLnHJFXBrA+ZaGU+irS6B+9Q0H+A9Y58fLhcIigkCra2FDjfmKc29u+Ge
	 89pxcQueL7iXtnoQ9kviLl+QUsu4msbRC3C++MJmA9ggZtF4Yh+vS2MZCoTmhLkHLW
	 YAJVVyOI4lJzeAmqAK7oover9XJ8WbIlRIP9tIh29uD4JZKJG7FnIG5fvkP/EVNDEc
	 vWjmLUcC/AgDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/19] s390/dasd: Stamp a format label into newly
 formatted volumes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260801180033.3679412-16-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
 <20260801180033.3679412-16-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:26:16 +0000
Message-Id: <20260801182617.221D61F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Kernel heap buffer overflow in `dasd_eckd_build_format()` when for=
matting multiple tracks with non-standard intensities (e.g., 0x01, 0x09, 0x=
04, or 0x0c).
--

--- Patch [15]: [PATCH v7 15/19] s390/dasd: Stamp a format label into newly=
 formatted volumes ---
commit 13926f208a70b78985e240163ddd3726aa7b2dea
Author: Stefan Haberland <sth@linux.ibm.com>

s390/dasd: Stamp a format label into newly formatted volumes

When a CDL volume is formatted, write a small on-disk label so the format
can later be recognised by the kernel.

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -2819,6 +2852,10 @@ dasd_eckd_build_format(struct dasd_device *base, s=
truct dasd_device *startdev,
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> +	/* room for the label data that R4 carries in addition to its count */
> +	if (write_label)
> +		datasize +=3D fdata->blksize;
> +
>  	fcp =3D dasd_fmalloc_request(DASD_ECKD_MAGIC, cplength, datasize, start=
dev);

[Severity: High]
This is a pre-existing issue, but can this lead to a kernel heap buffer
overflow when formatting multiple tracks with non-standard intensities?

In dasd_eckd_build_format(), when handling intensities like 0x01, 0x09, 0x0=
4,
or 0x0c, the cplength and datasize calculations underestimate the required
memory if nr_tracks > 1.

For example, with intensity 0x04 (invalidate track) or 0x0c, cplength is
hardcoded to 3 in the switch block prior to this allocation. However, if a
user issues a BIODASDFMT ioctl with a track range resulting in nr_tracks > =
1,
the subsequent track processing loop unconditionally generates CCWs for eve=
ry
track:

for (j =3D 0; j < nr_tracks; j++) {
        ...
        if ((intensity & ~0x08) & 0x04) {
                ...
                ccw++;
        }
}

Because the initial allocation does not properly scale with the number of
tracks for these specific intensities, advancing the ccw and data pointers
appears to write past the allocated limits.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801180033.3679=
412-1-sth@linux.ibm.com?part=3D15
