Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349645DF71
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777551; cv=none; b=G9EGxE7+i6fCCx7Jdva8vuoJY6MP2WpW9x7QM3gXrkqLbGfI62xfENM5vatvDFRKjk/696XjFWHAMQojn1b60KMcRZIJEzAo/uawx2f+eMgkdjtXeZzdpGezMUIWc2xnSQZVrdFsINNaesAgizC9M5whZJrNdvFRwigiVCth/uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777551; c=relaxed/simple;
	bh=gUIOwzPqw3tQXes9V+o+aqMDeyqTVds6JQltGL5myJY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bb4AJR7uTBM6OEWaQqiMXPFW9YC50VIyGJLiLETtBA5dv908oLFAe9FMyT1kFL44CHDVida1s+o/yZIueAVIpaeu7aXOmhjyAi8vB7FiXieZmRxEt48+Kg+HscCqf5Y/Qmu/ePyjhRWDMQeTnyogXK960o2vCcajGnEN9ug/Lb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiUBrUb3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiUBrUb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA261F00A3A;
	Mon,  7 Sep 2026 10:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788777549;
	bh=jNPWtj7D8DdxZlA9j6imcGoZM4NjaBRFY6VvGK1q7LE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jiUBrUb3/sZREESa3BeKK7VXMWlw8rP97iKFQd5b9CLaQHkSMvcSOyMd6UvnIED3Y
	 ephjlrEPTAZ8EmEPI7d4mblE8BtDo6UnXLU+hGUYy7jU1HsgpvIgjvD01SDt69enoE
	 mJHsVGvWi5sGr9eA8TSfukzGTvXaDOX0SAsHNXc/Fhamx2FwXFcmaT2IbnQSxae55n
	 YchNl/XgZqNUTZZTicBPVckcGt5FvfSa3mHHwQibBKsFZLwjgKnt2XeZRrptkTOu9i
	 93sbnGs1/YgYEKq0lzi+vVymcBp9Uro5mYu+PRrKlcSyM7VBdodfUShrMdAMbALG2f
	 x80aVJ/jRsQMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/13] s390/chsc_sch: Use kzalloc() for CHSC requests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260907-s390-cio-ready-v1-3-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
 <20260907-s390-cio-ready-v1-3-ca7f39806234@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:39:08 +0000
Message-Id: <20260907103908.EBA261F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The device reference counting in the `chsc_async` loop is flawed, =
causing both a memory leak on the `continue` path and a Use-After-Free (UAF=
) on the normal loop continuation path.
--

commit 53c8650f3f5b3ba23ce15639dc05928d14ac4215
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/chsc_sch: Use kzalloc() for CHSC requests

This commit replaces get_zeroed_page() with kzalloc() and free_page() with
kfree() for allocating CHSC requests. This simplifies the allocation and
free paths by using the standard slab allocator API.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
> index b6cb8bb8bcc4b..c8d6871d1841e 100644
> --- a/drivers/s390/cio/chsc_sch.c
> +++ b/drivers/s390/cio/chsc_sch.c
> @@ -292,7 +292,7 @@ static int chsc_ioctl_start(void __user *user_area)
>  	if (!css_general_characteristics.dynio)
>  		/* It makes no sense to try. */
>  		return -EOPNOTSUPP;
> -	chsc_area =3D (void *)get_zeroed_page(GFP_DMA | GFP_KERNEL);
> +	chsc_area =3D kzalloc(PAGE_SIZE, GFP_DMA | GFP_KERNEL);
>  	if (!chsc_area)
>  		return -ENOMEM;
>  	request =3D kzalloc_obj(*request);

[Severity: High]
This is a pre-existing issue, but does the call to chsc_async() from within
this function trigger a memory leak and a use-after-free?

When the CHSC_START ioctl is called, it triggers chsc_async(). In that
function, the subchannel reference counting appears flawed:

drivers/s390/cio/chsc_sch.c:chsc_async() {
    ...
    while ((sch =3D chsc_get_next_subchannel(sch))) {
        ...
        if (private->request) {
            spin_unlock(&sch->lock);
            ret =3D -EBUSY;
            continue;
        }
        ...
        put_device(&sch->dev);
    }
    ...
}

If the chosen subchannel has private->request set, the loop hits continue,
which seems to skip dropping the subchannel reference and leaks it.

If the loop continues normally, it calls put_device(&sch->dev) and loops,
passing the now-put (and potentially freed) sch pointer back into
chsc_get_next_subchannel(). Does this subsequently dereference sch->dev.p
in driver_find_device(), resulting in a use-after-free?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-s390-cio-r=
eady-v1-0-ca7f39806234@kernel.org?part=3D3
