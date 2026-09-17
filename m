Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C546E011
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628932; cv=none; b=IPHIo6NuxBETRr3l/9ZTxQqqDpdPxATO0aSQZvmgcqiJRERQfr++mqkQcRYH+95HBDpn0Tqyyu+xVxmo1uDW6tEmodyBiRs+Gmf7eRQu90wgHO6NKiC+UJDVsofv89woEECpy0y/5eKz34ULE0R1bVFRerWJmMUGtHerWLuMQGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628932; c=relaxed/simple;
	bh=ll/O7FnvDaQbPvISXzEWybqRjYA1nyRQEuyGXTZWK4Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C89XEj4ESWV1HbS8vBScdz335cQTEfuPRtc4GlUtB9GExrHrzsBO1zo7VS4SG5/SxekNE9jUd0nAwtGDE0ZB1VD+964cRFrIXRGnKCGGqzhDBKEINNBUwHQub3piXfYX/uDoPhy+fbAMQ2+rtqWjBkBJS2Bdy4LGfXNSBrOE7Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce/lvy/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce/lvy/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E171F000FF;
	Thu, 17 Sep 2026 07:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789628931;
	bh=CY2o48UwN5Hluc98Hz+yr0JU6gWTEy31/4xlM2mgMDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ce/lvy/3xDIvM59576LfBKTDTvlvReULBiKmFMS43OpZeIOrLol1r1kBnbWnI+EE9
	 XjmbrX6ye84BCDKVyeW8gyLYZ9mtjBrG9BldboLBBAbtzb5c1VDqaNd6HmqxhdTaAe
	 SU9kenNhRjTZHu3XzckmrRTJygDne/e2WDZnUNdWl3n3f7fAVAi5BkabR4zsBZXrd7
	 ivyASZrYooRMz+XvrlwcM1Ox2ynPnSkZKFVBmyPSmR5K1Ye7vKcoiNhsBJclarhjfV
	 x7dXM3Khw1O7dj16Hgutur9LZeUrMn9oWJQgOU1pDBNXfbouMSYALN/TnVkHcupNll
	 3Ug1FMlv6j4YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] s390/sclp: Introduce macro sclp_gds_for_each()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260917065824.2858737-2-egorenar@linux.ibm.com>
References: <20260917065824.2858737-1-egorenar@linux.ibm.com>
 <20260917065824.2858737-2-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 07:08:50 +0000
Message-Id: <20260917070850.B5E171F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sclp: out-of-bounds read in sclp_gds_for_each() due to integer pro=
motion
--

commit f292c3c2b28abf9088d99e5a8af81f738a00c9ee
Author: Alexander Egorenkov <egorenar@linux.ibm.com>

s390/sclp: Introduce macro sclp_gds_for_each()

This commit introduces a macro to iterate safely over GDS {sub}vectors. It
adds bounds checks to avoid infinite loops and out-of-bounds memory accesses
when parsing malformed event buffers.

> diff --git a/drivers/s390/char/sclp.h b/drivers/s390/char/sclp.h
> index b31a680e08714..d22003b769f14 100644
> --- a/drivers/s390/char/sclp.h
> +++ b/drivers/s390/char/sclp.h
> @@ -360,25 +360,33 @@ sclp_ascebc_str(char *str, int nr)
>  	(machine_is_vm()) ? ASCEBC(str, nr) : ASCEBC_500(str, nr);
>  }
> =20
> -static inline struct gds_vector *
> -sclp_find_gds_vector(void *start, void *end, u16 id)
> +/* Loop over all GDS {sub}vectors in a safe manner. */
> +#define sclp_gds_for_each(v, n, start, end)	\
> +	for ((n) =3D (end) - (start), (v) =3D (start);	\
> +	     (n) >=3D sizeof(*(v)) && (v)->length >=3D sizeof(*(v)) && (v)->len=
gth <=3D (n);	\

[Severity: High]
Does this code introduce an out-of-bounds read due to integer promotion?

If a malformed SCLP event buffer is provided by the hardware with an
evbuf->length smaller than the header size, start will be greater than end.
This happens in callers like sclp_ocf_handler() and sclp_tty_receiver():

drivers/s390/char/sclp_ocf.c:sclp_ocf_handler() {
    ...
    v =3D sclp_find_gds_vector(evbuf + 1, (void *) evbuf + evbuf->length,
                             0x9f00);
    ...
}

In sclp_gds_for_each(), the loop limit n is computed as (end) - (start).
Because callers define n as an int, if start is greater than end, n will be=
 a
negative integer.

The bounds condition (n) >=3D sizeof(*(v)) compares the signed int n with t=
he
unsigned size_t returned by sizeof. Due to C integer promotion rules, n is
implicitly promoted to an unsigned type, wrapping the negative value to a v=
ery
large positive number.

Consequently, the bounds check evaluates to true, and the loop mistakenly
executes (v)->length >=3D sizeof(*(v)), reading from the out-of-bounds start
pointer.

The original logic ((void *) v < end) handled start > end safely by
immediately skipping the loop.

> +	     (n) -=3D (v)->length, (v) =3D (void*)(v) + (v)->length)
> +
> +static inline struct gds_vector *sclp_find_gds_vector(void *start,
> +						      void *end, u16 id)
>  {
>  	struct gds_vector *v;
> -
> -	for (v =3D start; (void *) v < end; v =3D (void *) v + v->length)
> +	int n;
> +	sclp_gds_for_each(v, n, start, end) {
>  		if (v->gds_id =3D=3D id)
>  			return v;
> +	}
>  	return NULL;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917065824.2858=
737-1-egorenar@linux.ibm.com?part=3D1
