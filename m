Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39CA43F0A7
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629130; cv=none; b=U+Y1YLgOxCG0292NFKkL0s+icGuOkmUxFGBuH5YBIdqvSooLNw4blJmPBU5M+9KwzE2Kybwm/iqBwSGZStgdvE7GH3lV/tZNhP7vJ4hBgc0iKTzmh95ExUjIWEgiHsFmp2PHEKSoLu+DSXcew04lYq3ObTkMB8fATKBeRidDpKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629130; c=relaxed/simple;
	bh=yWC5ANq21ZusOLKDy1gavxj/FDfWzoUz5KCpBj2Jg5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sCJgzWzCVRkeQG8U6io3k5Peo/e+CRmIHMCyb1x8oSB7yifpSULr6eYyD9UbP0OqFhANhnuSnL8R8TVpLihVXslKrsQDYsYYj5ax4QpDROFzzdjC2c4i35YaA9wZPWJwbzmSYaIJ4Z+nMTYU+E3QBJT7qNZU+fnJz6dQ7xecH2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIncmyU6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIncmyU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23701F000FF;
	Thu, 17 Sep 2026 07:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789629128;
	bh=2ttklWCZY+jUGWAbuQ3McbC7zv4HUaU7RyMaCaljS9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BIncmyU6cKobel9GKHnt4S/34acJY0AfCjcghm4XynQbYM/N9EeHCZQyDZc6nzRfg
	 YG2JSHJHmPUCMCCNptNOBxmop2hy4Ea+R4OFW7B79NyDvJLQM4Fz2gavTDaqOpsE5M
	 T6DE1N898a4ICjNykmhuFNG5rxZ/d3mSNBHz6fMz9KU9/hKXCK0AP6Uq35phf1tJ/g
	 qg/6vw6Ww43H1+rXlRy+jKetlh+zxkDKinpH/zfVLTFtcHP7eW2uGClxgKM+gvWKJC
	 znH/ObGjUFIpVN48ayG+qbmHE0VYefUuEF9wb3tBcN4NcqDCat9XuPI5boRDT9LQOn
	 3/QA/B2YCxNuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] s390/sclp_tty: Make use of sclp_gds_for_each()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260917065824.2858737-3-egorenar@linux.ibm.com>
References: <20260917065824.2858737-1-egorenar@linux.ibm.com>
 <20260917065824.2858737-3-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 07:12:07 +0000
Message-Id: <20260917071207.E23701F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/sclp: out-of-bounds read in sclp_gds_for_each() due to intege=
r promotion
--

commit b02b1435e7ea0c6d35613a83d6a0bafa8d59fb95
Author: Alexander Egorenkov <egorenar@linux.ibm.com>

s390/sclp_tty: Make use of sclp_gds_for_each()

This commit replaces manual iterations over gds subvector entries with the
sclp_gds_for_each() macro. The stated goal is to handle erroneous entries
in gds vectors and subvectors more safely.

> diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
> index 0a92d08830e7c..4353890bbf8af 100644
> --- a/drivers/s390/char/sclp_tty.c
> +++ b/drivers/s390/char/sclp_tty.c
> @@ -418,38 +418,38 @@ static void sclp_get_input(struct gds_subvector *sv)
> =20
>  static inline void sclp_eval_selfdeftextmsg(struct gds_subvector *sv)
>  {
> -	void *end;
> -
> -	end =3D (void *) sv + sv->length;
> -	for (sv =3D sv + 1; (void *) sv < end; sv =3D (void *) sv + sv->length)
> +	void *start =3D sv + 1;
> +	void *end =3D (void *) sv + sv->length;
> +	int n;
> +	sclp_gds_for_each(sv, n, start, end) {

[Severity: High]
Does this code introduce an out-of-bounds read regression if the hardware
provides a malformed sccb buffer with a length smaller than the header size?

If sv->length is smaller than sizeof(*sv), start will be greater than end.
In the sclp_gds_for_each() macro defined in drivers/s390/char/sclp.h, n is
defined as an int and evaluated as n =3D (end) - (start), which becomes a
negative value:

drivers/s390/char/sclp.h:
#define sclp_gds_for_each(v, n, start, end) \
	for ((n) =3D (end) - (start), (v) =3D (start); \
	     (n) >=3D sizeof(*(v)) && (v)->length >=3D sizeof(*(v)) && (v)->length=
 <=3D (n); \
	     (n) -=3D (v)->length, (v) =3D (void*)(v) + (v)->length)

Because sizeof returns an unsigned size_t, standard C integer promotion
rules convert the negative int n to a very large positive size_t value
when evaluating (n) >=3D sizeof(*(v)). This incorrectly bypasses the initial
bounds check.

The condition then proceeds to evaluate (v)->length >=3D sizeof(*(v)),
dereferencing v. Since v points to start which is beyond end, this results
in an out-of-bounds memory read (1 or 2 bytes), which could cause a kernel
panic due to a page fault on unmapped memory or trigger kasan.

This regression is exposed here in sclp_eval_selfdeftextmsg(), but also
directly in sclp_tty_receiver() when parsing untrusted sclp event buffers
from the hardware or hypervisor, where an evbuf->length smaller than
sizeof(*evbuf) causes start > end:

drivers/s390/char/sclp_tty.c:sclp_tty_receiver() {
    ...
    v =3D sclp_find_gds_vector(evbuf + 1, (void *) evbuf + evbuf->length,
                             GDS_ID_MDSMU);
    ...
}

>  		if (sv->key =3D=3D 0x30)
>  			sclp_get_input(sv);
> +	}
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917065824.2858=
737-1-egorenar@linux.ibm.com?part=3D2
