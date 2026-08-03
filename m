Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D314733FE33;
	Mon,  3 Aug 2026 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774290; cv=none; b=i5SI9uVZkaySCZZSbaMTvDidgWiiuqmDgSo0KrYS7fHriRbQ7/GCc2BN55eqdsxFy4FsxzSJSM2MO9obsUGwm70oOPyQTQHwdqa348+4aY1vLYuaTnCYORxtmegP/vlxemTWYTUHKJhcwNiWESO+2fczeVZaDopSD6tc0CQOqh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774290; c=relaxed/simple;
	bh=vsX5jXWJiSor1txKA07cHs4BrgIyA/wIFnQYCRSEWnU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c/wSa/OtidC//3V9Itu+XblEAb3ZecG5HKCITaVD4wj2YOP40xqBgkfOy8jg0fSDWKi2zX8t/k96mFeWDp+6mcG9zKfTXoQMUsRWUlf/UIWw3kuhPgyw5CMP6nh7/gun6U89hmroxTaro8bXphhhk0kwY5roXQQc3t/FoxqFbt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROGw3nHq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROGw3nHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC2F1F00A3A;
	Mon,  3 Aug 2026 16:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785774288;
	bh=GeGhq//5ClN3wn46e1Au3p7BWxioYjpJU26I7WvXMH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ROGw3nHqLlTDjk9qQRvOaixXeNRP1AXustY8nl9gLE4oOQKUBqhWd2HLrr6gd0sRW
	 /RkW0Wx5fPqVHmNpACrbDROXVoOBhRGqm4WUzG+E06K3Hxlzowfk7FlfUpEWrkzfQO
	 QxwjpWPDOVX32tlHfY6AJ6iNv+Sz33e9EMLQs9GHM3/fq3HUBbiMgzOgCypaNNM8Hm
	 B7oDHsAXhCmflakQxHDSd4PesPYAspogqK6Y+nsSHn1cwquwhrwbJn4JdMuN1Uoh0k
	 e3WADYjiQ2HyQ2YMjdyYuUtgVwfqGQOxAfIiAADkdgBBq9USXrth9XR6niajdTHqhP
	 XZIgTO/mgs5Vg==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 05/23] s390/vfio_ccw: Calculate idal length based
 on idaw type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260803160924.236807-6-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:24:46 +0000
Message-Id: <20260803162447.EFC2F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Untranslated guest physical addresses (or garbage data) are passed=
 to the physical host channel subsystem for skipped commands, causing spuri=
ous channel-program checks.
--

--- Patch [5]: [GIT PULL v1 05/23] s390/vfio_ccw: Calculate idal length bas=
ed on idaw type ---
commit e748c56d38e70498395b0ca91606fb9902835452
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: Calculate idal length based on idaw type

This commit fixes the guest IDAL length calculation in get_guest_idal() by
ensuring the size is based on the IDAW type (Format-1 vs Format-2) rather
than unconditionally assuming Format-2 (64-bit).

Link: https://lore.kernel.org/r/20260720203400.7328E1F000E9@smtp.kernel.org/

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 6275794751cb4..5ef082b8289af 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
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

> @@ -593,7 +594,7 @@ static int ccw_count_idaws(struct ccw1 *ccw,
>  	struct vfio_device *vdev =3D
>  		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
>  	u64 iova;
> -	int size =3D cp->orb.cmd.c64 ? sizeof(u64) : sizeof(u32);
> +	int size =3D get_idaw_size(cp);
>  	int ret;
>  	int bytes =3D 1;

[Severity: High]
This is a pre-existing issue, but looking at ccwchain_fetch_ccw() in this
same file, there appears to be a problem when evaluating skipped commands:

drivers/s390/cio/vfio_ccw_cp.c:ccwchain_fetch_ccw() {
    ...
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
    ...
}

When pa->pa_nr is 0 for a command that does not transfer data (such as a
read with the SKIP flag set), page_array_idal_create_words() will perform
no operations.

Since ccw->cda is unconditionally set to the idaws array and CCW_FLAG_IDA
is set, does this cause the host channel subsystem to fetch untranslated
guest physical addresses (or garbage data)?

For skipped read operations, the s390 hardware architecture still requires
IDAWs to be fetched and validity checked. Could this result in spurious
channel-program checks being injected into valid guest I/O operations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D5
