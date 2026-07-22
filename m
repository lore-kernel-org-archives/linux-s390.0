Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E878339391
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717563; cv=none; b=NH6QdveXY982dTH2OM+set8LEDJvPg3sF1YmHZ30wgIgLMCOzwBE9cDV5WU1RGzrLjkUATOC4uYW7PhRDNxG31JOrFYbSxXkqsMjeDE+7XWGV7kCpJ0CMws7KdIKrMT4PrZ4O9iUv1cNPwbQMitg0RFufEjz5/J2acqKi5Vt1W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717563; c=relaxed/simple;
	bh=mke9bSUV5X6Ksy90sjq+KxGr3kYrELXndoctO8TEMjc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p3EN225OEFW7IhHgdWcGBOTJFSMEDJ9WXQj1Sp5bwdMQqPoaimNj+YWOTdNBfzU8HgEgjN4nA4RemlWdhIos4qj8nIeZwVVWYkXyD74FQdQ2EHE7NX7GReng8mWSF+wo1aQeK21VMZwFWGuqSxyluPYM0n5psijQwgQaqhTOzx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSL3lH7g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSL3lH7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13561F000E9;
	Wed, 22 Jul 2026 10:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784717561;
	bh=mcvMcrlccOPBMqDVK6r73wDn09JHoiBHsjh4WYDcy4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OSL3lH7gSEflytZOJXiU0lJ1KdYKhAFzPD9L5Z9L4OnO5zLLHWuU4krrzznynh4u2
	 Fcv3t21c5bgdICQBa/BRBPo2YV6G1NOYXKlk+EanbQwgzZT6Wyl0n1Z4WYEv0B0Mcz
	 lEtOUupE9UfBwu2MgmBS9F6hOIxw0C3pqzCTqDWxNLR6h7j/L7g0AZcjSy1kwhu83C
	 AUjiamN+rx0mVK65hKUJwOGEjCTw4kzYK4hdgahxOb+7W9D5dPkrisAgVZia6UPG+z
	 KpYPr4MrbQyW6GjNaXAtZb5dGUPHdl/sPzvFURZRdhB7oTzDalfuhMkxiUMTKm35rg
	 /I27EfwyhEggA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/dasd: Fix undersized format-check buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260722103704.1709668-1-sth@linux.ibm.com>
References: <20260722103704.1709668-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 10:52:41 +0000
Message-Id: <20260722105241.A13561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Mismatched allocation and free functions in the error path of `das=
d_eckd_build_check_tcw()` cause a guaranteed NULL pointer dereference.
- [High] In FICON transport mode (`tpm`), the `while` loop skipping trailin=
g zeros causes out-of-bounds reads on the `fmt_buffer` array.
- [High] The user-provided `result` field in `format_check_t` is uninitiali=
zed by the kernel, allowing a logic bypass that causes an out-of-bounds mem=
ory read and Information Leak.
- [Medium] Unprivileged users can trigger a kernel warning splat (DoS) via =
`BIODASDCHECKFMT` ioctl due to missing bounds check before a massive `kzall=
oc`.
- [Medium] Device reference counts are permanently leaked on the error path=
s of request builder functions.
--

--- Patch [1]: [PATCH] s390/dasd: Fix undersized format-check buffer ---
commit dfd4c2437bd8554cd6e6af49167ed3eb732910da
Author: Stefan Haberland <sth@linux.ibm.com>
Date:   Wed Jul 22 10:37:04 2026 +0000

    s390/dasd: Fix undersized format-check buffer
   =20
    fmt_buffer_size in dasd_eckd_check_device_format() is declared as
    int, even though one of the multiplicands, sizeof(struct eckd_count),
    is a size_t. Compute the buffer size with check_mul_overflow() and
    keep it in a size_t to prevent silent truncation and resulting memory
    corruption.

    Cc: stable@vger.kernel.org #4.7

> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eck=
d.c
> index 74fe73b5738ab..d356a9f8f016f 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c

[ ... ]

> @@ -3490,7 +3491,9 @@ static int dasd_eckd_check_device_format(struct das=
d_device *base,
>  	rpt_exp =3D recs_per_track(&private->rdc_data, 0, cdata->expect.blksize=
);
> =20
>  	trkcount =3D cdata->expect.stop_unit - cdata->expect.start_unit + 1;
> -	fmt_buffer_size =3D trkcount * rpt_max * sizeof(struct eckd_count);
> +	if (check_mul_overflow(trkcount, rpt_max, &fmt_buffer_size) ||
> +	    check_mul_overflow(fmt_buffer_size, sizeof(struct eckd_count), &fmt=
_buffer_size))
> +		return -EINVAL;
> =20
>  	fmt_buffer =3D kzalloc(fmt_buffer_size, GFP_KERNEL | GFP_DMA);

[Severity: Medium]
This is a pre-existing issue, but missing a CAP_SYS_ADMIN check allows
unprivileged users to trigger a warning splat here.

Looking at drivers/s390/block/dasd_ioctl.c:dasd_ioctl_check_format(), cdata
is populated from user space without a capability check:

    if (copy_from_user(&cdata, argp, sizeof(cdata))) {
        rc =3D -EFAULT;
        goto out_err;
    }

This allows a user to control start_unit and stop_unit to request an
extremely large allocation size. If the requested size exceeds
KMALLOC_MAX_SIZE, this kzalloc() will fail and throw a WARN_ON_ONCE splat
because it lacks __GFP_NOWARN.

Since the sanity checks in dasd_eckd_format_sanity_checks() are performed
later, should this ioctl require CAP_SYS_ADMIN like BIODASDFMT does, or
should the size be capped earlier to avoid spamming OOM warnings?

>  	if (!fmt_buffer)
>  		return -ENOMEM;

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
dasd_eckd_build_check_tcw() use the wrong free function?

If dasd_eckd_build_check_tcw() fails, it branches to out_err:

drivers/s390/block/dasd_eckd.c:dasd_eckd_build_check_tcw() {
    ...
    cqr =3D dasd_fmalloc_request(DASD_ECKD_MAGIC, 0, itcw_size, startdev);
    ...
out_err:
    dasd_sfree_request(cqr, startdev);
    return ERR_PTR(rc);
}

Because dasd_fmalloc_request() was used, cqr->mem_chunk is NULL. However,
dasd_sfree_request() passes this to dasd_free_chunk():

drivers/s390/block/dasd_int.h:dasd_free_chunk() {
    chunk =3D (struct dasd_mchunk *) ((char *) mem - sizeof(struct dasd_mch=
unk));
    ...
}

Will this cause invalid pointer arithmetic and a subsequent NULL pointer
dereference panic?

[Severity: Medium]
This is a pre-existing issue, but does the same error path leak the device
reference count?

Earlier in dasd_eckd_build_check_tcw(), the reference count is incremented:

drivers/s390/block/dasd_eckd.c:dasd_eckd_build_check_tcw() {
    ...
    start_priv->count++;
    ...
}

If an error occurs, out_err releases the request but does not decrement
start_priv->count. Can this result in a permanent reference leak?

[Severity: High]
This isn't a bug introduced by this patch, but is there an out-of-bounds
read when skipping trailing zeros?

In drivers/s390/block/dasd_eckd.c:dasd_eckd_format_evaluate_tracks(), the
while loop checks the array content before validating the bounds:

    while (fmt_buffer[pos].record =3D=3D 0 &&
           fmt_buffer[pos].dl =3D=3D 0) {
        if (pos++ > max_entries)
            break;
    }

When pos reaches max_entries, it evaluates fmt_buffer[pos] before the break
condition is checked. Furthermore, the break condition executes pos++ again,
leaving pos pointing up to 2 elements out of bounds.

This out-of-bounds index is then passed to dasd_eckd_count_records() as
start:

    for (i =3D start; i < max; i++) {
        if (i > start) {
            if ((fmt_buffer[i].head =3D=3D head && ...

Could this trigger an out-of-bounds read on kernel heap memory?

[Severity: High]
This is a pre-existing issue, but does an uninitialized user space value
cause a logic bypass and information leak?

In drivers/s390/block/dasd_ioctl.c:dasd_ioctl_check_format(), cdata is
copied from user space without kernel initialization of cdata->result:

    if (copy_from_user(&cdata, argp, sizeof(cdata))) {
        ...

Later, in drivers/s390/block/dasd_eckd.c:dasd_eckd_format_evaluate_tracks(),
the index correction relies on this result field:

    if (!cdata->result) {
        i--;
        pos--;
    }

If a user intentionally provides a non-zero cdata->result, this bypasses the
index decrement. The loop leaves pos incremented out of bounds, and the
out-of-bounds data is copied:

    cdata->rec =3D fmt_buffer[pos].record;
    cdata->blksize =3D fmt_buffer[pos].dl;
    cdata->key_length =3D fmt_buffer[pos].kl;

Since cdata is then copied back to user space, could this allow unprivileged
users to leak kernel heap contents?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722103704.1709=
668-1-sth@linux.ibm.com?part=3D1
