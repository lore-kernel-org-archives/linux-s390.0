Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A6331ED7
	for <linux-s390@vger.kernel.org>; Tue, 18 Aug 2026 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039111; cv=none; b=HpB8iaMDxKBr92FTe0Xvyx99xafio55tuDunaRuTmvhwqzKOlSznzztjji+Ist+0FqIOKITQ6lRUqp2hxJXt/Ww35hThwqpr5Pa2sHwaVkjQMy3E38wMpswRfsGMi0wkAeo/yIyN57kpnPRFAhcluI7wVd1Czkjwsfj3NItKEmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039111; c=relaxed/simple;
	bh=Am/lQvZ7mtGa18JkfiOjkf0IecCq8+4RSyWj+lixg/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K4E8Nj/Jf+SwcfnT35vZfFIfcfxs5ylkzHoJ5pILyYrwjEbIVZmYipG3f0j58uYHsvFIn+7hre3kMrP4sHYGSD22rtIllmH12qTOpwU3WYpMiuzSPuZnRhNrG2guu+2RPtyU3rja+GGehxZa9CRugZxfrYfjB5l2gtK8GJH0qds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLgaBUIO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLgaBUIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FAC1F000E9;
	Tue, 18 Aug 2026 07:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787039106;
	bh=ZRQslazirwRU7sX2Q6/GfNN+M9DWDjCGZAFW/+iic34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hLgaBUIOsYjeHw4u+m54QFLNCtUBwCxmrmqsePWmez8HdnQC6Nn/9gAkMx9Y7/bgf
	 l1CFnhy8H/c8eNMA+FtRkwdpNth+SvSZzLlcyWSxserVhhEQlXAkMkyxsV4g6/F0e8
	 sRLc1URRCAnwRz/W+xkAYLbMsRdxn4popSUKf1CAbDzaFE0qkukHXRdvi4SqqjGCS+
	 rzUWsfT+DR7hqN7CDhg3r5jkhptcVFVXfn1xtAmkEgA4Cb5LV+PlIiTjyhYLkJfhHZ
	 tTNu21VAbCI6kdSaJvj/wZdrsLv8MIORB91Bp2juGTkO9SKGyADQX4GZxQUS+FfrTR
	 FN5N4MacEPHlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390: raw3270: Handle allocation failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260818073205.1669781-1-triet.hoang.dev@gmail.com>
References: <20260818073205.1669781-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 07:45:05 +0000
Message-Id: <20260818074506.62FAC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Dangling pointer and Use-After-Free if `ccw_device_enable_console(=
)` fails in `raw3270_setup_console()`.
- [High] Device reference count leak in `raw3270_create_device()` on error =
path.
--

--- Patch [1]: [PATCH v2] s390: raw3270: Handle allocation failures ---
commit 0dc799bc2a1ab261a4df0f1061360db8eed525e2
Author: Triet Hoang <triet.hoang.dev@gmail.com>

s390: raw3270: Handle allocation failures

Check the return values of kzalloc_obj() and kzalloc() before using the
allocated memory. Free the allocated resources on subsequent initialization
failures to avoid leaking memory.

> diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
> index aa9c4d81225cb..ff397396b440e 100644
> --- a/drivers/s390/char/raw3270.c
> +++ b/drivers/s390/char/raw3270.c
> @@ -814,10 +814,23 @@ struct raw3270 __init *raw3270_setup_console(void)
>  		return ERR_CAST(cdev);
> =20
>  	rp =3D kzalloc_obj(*rp, GFP_KERNEL | GFP_DMA);
> +	if (!rp) {
> +		ccw_device_destroy_console(cdev);
> +		return ERR_PTR(-ENOMEM);
> +	}
>  	ascebc =3D kzalloc(256, GFP_KERNEL);
> +	if (!ascebc) {
> +		ccw_device_destroy_console(cdev);
> +		kfree(rp);
> +		return ERR_PTR(-ENOMEM);
> +	}
>  	rc =3D raw3270_setup_device(cdev, rp, ascebc);
> -	if (rc)
> +	if (rc) {
> +		ccw_device_destroy_console(cdev);
> +		kfree(rp->ascebc);
> +		kfree(rp);
>  		return ERR_PTR(rc);
> +	}
>  	set_bit(RAW3270_FLAGS_CONSOLE, &rp->flags);
> =20
>  	rc =3D ccw_device_enable_console(cdev);

[Severity: High]
This isn't a bug introduced by this patch, but if ccw_device_enable_console=
()
fails just below this context:

drivers/s390/char/raw3270.c:raw3270_setup_console() {
    ...
	rc =3D ccw_device_enable_console(cdev);
	if (rc) {
		ccw_device_destroy_console(cdev);
		return ERR_PTR(rc);
	}
    ...
}

This error path destroys the cdev but fails to unlink rp from
raw3270_devices or free it.

Because raw3270_setup_device() previously added rp to the global list here:

drivers/s390/char/raw3270.c:raw3270_setup_device() {
    ...
    if (rp->minor =3D=3D -1 && minor < RAW3270_MAXDEVS + RAW3270_FIRSTMINOR=
) {
        rp->minor =3D minor;
        list_add_tail(&rp->list, &raw3270_devices);
    }
    ...
}

Does leaving it linked in raw3270_devices create a dangling pointer where
rp->cdev points to the destroyed console device?

Later, when raw3270_init() iterates over this list, it could dereference
rp->cdev->dev, causing a use-after-free.

I also noticed a pre-existing resource leak in the same file:

drivers/s390/char/raw3270.c:raw3270_create_device() {
    ...
	rc =3D raw3270_setup_device(cdev, rp, ascebc);
	if (rc) {
		kfree(rp->ascebc);
		kfree(rp);
		rp =3D ERR_PTR(rc);
	}
	/* Get reference to ccw_device structure. */
	get_device(&cdev->dev);
	return rp;
}

[Severity: High]
This is a pre-existing issue, but does this leak a device reference count w=
hen
raw3270_setup_device() fails?

If raw3270_setup_device() fails, the function continues to unconditionally
execute get_device(&cdev->dev) before returning the error pointer.

The caller, raw3270_set_online(), receives the error and returns immediatel=
y,
meaning put_device() is never called to balance it.

Can this permanently leak a reference to the ccw_device, preventing the
physical device's structures from being freed even if hot-removed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818073205.1669=
781-1-triet.hoang.dev@gmail.com?part=3D1
