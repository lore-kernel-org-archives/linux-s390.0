Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A6231832;
	Sun, 26 Jul 2026 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087369; cv=none; b=KQEYvSoLFTEVapfV+L9T+kj6OMPmzVYYS7OloGjGEj0DfemJQUp3W1pfjlpHGs77eVw/baQYKMYgY7PmPQQ9xvJWlFdWQ8hFzGMCLVZV2ys290jM8gPfjnPV1E92RdBfv4pUTQ/ij72V+KDBarut5exdiD7EdZtxy/nNwBL6zcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087369; c=relaxed/simple;
	bh=0sNp0EcvTs2mgZRlqeFwX37KTvYniF446oLAwkwcrpk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p0LQPPZnNk3WQYFmCetXNsupQknv8dCYimoB7aD9b5PXU1iy+5zuaTgjxLZjjqiINjj7F/Ppb5qsH+8G75f7euYyuzYiyLheKbS840e7FFvCQiNJZb0pVPPQ+1be6lE93aZaxkT7NtnIN6mCi2tJpqI2isb/UFWLiyHwObBbLHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g97clXa2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g97clXa2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7C91F000E9;
	Sun, 26 Jul 2026 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087368;
	bh=sbbcN/QuVByShoAK2elcOGn8U/XiOPAABQAzpMBnzl8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g97clXa2gJo4nJ4Dh5KSBmfETWo3Qh6uADM7mN+Rdh8+Hpb97vihrRBxotQy32xAP
	 lBbYZOWuLppj0FhaPmbkjlDQUfWmH+6kZ+DJioSU48tpnPqq2ls7qJ5plTgSLWfKNs
	 E9FinTbUDbuyByIiO19HcY6KV/rfiJ3Q2vF87CFi3UsYAkMYAWMVvoZU7444ea5Mfp
	 867w3+Za2gk/3IyIoR2JEeov9I+Wmy5n1ZL7khZQ2C9fCqZxG05Hf8Z9fcfxkBOvYw
	 9vpRhBdHuHWTP/X6nYROxY6ljSXLVON+Cw9tQCm7IkaGAEIvjcDxVqVvsdR+jiotPb
	 ynVSEAIwzQMhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/10] s390/vfio_ccw: calculate idal length based on
 idaw type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260726172153.1818056-6-farman@linux.ibm.com>
References: <20260726172153.1818056-1-farman@linux.ibm.com>
 <20260726172153.1818056-6-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:36:07 +0000
Message-Id: <20260726173607.CE7C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] When processing a CCW that does not transfer data (e.g., a read co=
mmand with the SKIP flag set), vfio-ccw fails to translate the IDAL, passin=
g raw guest IOVAs directly to the host channel subsystem, which causes host=
 IOMMU faults.
--

--- Patch [5]: [PATCH v6 05/10] s390/vfio_ccw: calculate idal length based =
on idaw type ---
commit 6c424b4fc15dc709c90a5e16ed87383742a135f1
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: calculate idal length based on idaw type

The output of vfio-ccw is always Format-2, but the input can be either
Format-1 (31-bit addresses) or Format-2 (64-bit addresses). As a result,
the size of the guest IDAL may be incorrect and should be trimmed down.

Link: https://lore.kernel.org/r/20260720203400.7328E1F000E9@smtp.kernel.org/

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 6275794751cb4..5ef082b8289af 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
[ ... ]
> @@ -233,6 +233,7 @@ static void convert_ccw0_to_ccw1(struct ccw1 *source,=
 unsigned long len)
>  }
> =20
>  #define idal_is_2k(_cp) (!(_cp)->orb.cmd.c64 || (_cp)->orb.cmd.i2k)
> +#define get_idaw_size(_cp) ((_cp)->orb.cmd.c64 ? sizeof(u64) : sizeof(u3=
2))
> =20
>  /*
>   * Helpers to operate ccwchain.
[ ... ]

While reviewing this, I noticed a separate issue in this file.

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_fetch_ccw()
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

[Severity: High]
This isn't a bug introduced by this patch, but when processing a CCW that d=
oes
not transfer data, such as a read command with the SKIP flag set, does vfio=
-ccw
fail to translate the IDAL?

Because ccw_does_data_transfer(ccw) returns false, pa->pa_nr is set to 0. T=
his
prevents page_array_idal_create_words() from overwriting the raw guest IOVAs
with translated host addresses.

Could a guest VM submit a channel program with a CCW where ccw_is_skip() and
ccw_is_read() are true, containing an arbitrary guest physical address?

Since the untranslated guest IOVAs remain in the idaws array, passing them
directly to the host channel subsystem might trigger a host IOMMU fault or
Channel Program Check, potentially leading to a host denial of service.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726172153.1818=
056-1-farman@linux.ibm.com?part=3D5
