Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091A3B2FFE
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830470; cv=none; b=tSmM9p+9CFLxHgZsEnHbZ4cbGSjZYl3Icef597mQtnF7evxSaBD3dEcbFk8ZEDX12GKkE33iXtucQtOPJ6UOCav09ThNBZNCJr2qRcCeeS6j2B0dSdaD9jL/Bs2QOeh9rj6grp7VqznifmRl3zPCBVHRKwQAHc//gV1QC4Kh7zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830470; c=relaxed/simple;
	bh=RgmDJJHSpDg+9ImGMlWTetcL86PjwrBy4HqB74Pax0k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JeEw9cUxcaMDNfb+I7+OqW1urfZvKXMK0XLSHGya1LVDMG+bF522Zdg0k70jJTosgNX6mUuYqBgJ5Vzhi5vhgxW27rNA0KdRfqcgPPDdE858yQGps02sfZ39je1UgwiG/Cb4Kdt9ShicDqGJSqGIgofKSqIr5+FhQcXS43yOTIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljtt8DMa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljtt8DMa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDF51F000E9;
	Tue,  4 Aug 2026 08:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785830468;
	bh=SXpjkMjP7ACf5LX5geyYy1BxXt0w5geQU8BpPgtJM7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ljtt8DMagZSgrfmSHoYtZBTotjh+p8gHfQkhYBRzVhU+K04lqM1bsgeqNuMbFErdd
	 SRWlzcha+rfdzpVcjJvyLJnw2kHoNxsPZq81gKhi53UO1993sofY1MUt/TW5f86LRH
	 5pv4JWPbRGsQKkY6F06/bsXoptBY6+RR093MyQjgEZTKtyVY/86GaPuP7XcIHJtNXH
	 pfskaWxWSkT2yi7dDsdiX15YSHc6uI+w4NdjBpoOOp7aGD/2i3yOrq4HE3UdD9kHVj
	 DfEXe6b6yiGd/BLHDLoelVeg93JXYvWJ016s6ptl33JH5IPzfY+1wNwkK4GR/LDEmH
	 7zBywnD+FSpyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] s390/sclp: Ensure no callback gets called after
 sclp_unregister() returns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Egorenkov" <egorenar@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260804074511.236153-3-egorenar@linux.ibm.com>
References: <20260804074511.236153-1-egorenar@linux.ibm.com>
 <20260804074511.236153-3-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 08:01:07 +0000
Message-Id: <20260804080108.4DDF51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing synchronization in sclp_register() error path leads to Use=
-After-Free.
- [Medium] Concurrent execution of state_change_fn and receiver_fn corrupts=
 the completion mechanism.
--

--- Patch [2]: [PATCH v2 2/2] s390/sclp: Ensure no callback gets called aft=
er sclp_unregister() returns ---
commit 56ff5dbe692c5051e8907f572849ceb9402fdda1
Author: Alexander Egorenkov <egorenar@linux.ibm.com>

s390/sclp: Ensure no callback gets called after sclp_unregister() returns

This commit adds a completion mechanism to prevent callbacks from being=20
executed after a driver unregisters from the SCLP subsystem. It blocks=20
sclp_unregister() until any inflight state change or receive callbacks=20
have finished executing.

> It is sufficient to use only one completion per struct sclp_register
> because the callbacks state_change_fn() and receiver_fn() never get called
> in parallel.

[Severity: Medium]
Is this assumption accurate?

Looking at sclp_dispatch_state_change() and sclp_dispatch_evbufs(), both=20
functions drop sclp_lock before invoking their respective callbacks. If a=20
driver registers both callbacks (such as sclp_input_event in sclp_tty.c),=20
could both dispatchers execute concurrently?

If they run in parallel, it seems they would both call reinit_completion()=
=20
and complete() on the same reg->done completion, potentially corrupting it=
=20
and causing a premature wakeup in sclp_unregister().

> diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
> index 98e334724a627..8954f4260401b 100644
> --- a/drivers/s390/char/sclp.c
> +++ b/drivers/s390/char/sclp.c

[ ... ]

> @@ -885,6 +890,8 @@ sclp_register(struct sclp_register *reg)
>  	/* Trigger initial state change callback */
>  	reg->sclp_receive_mask =3D 0;
>  	reg->sclp_send_mask =3D 0;
> +	init_completion(&reg->done);
> +	complete(&reg->done);
>  	list_add(&reg->list, &sclp_reg_list);
>  	spin_unlock_irqrestore(&sclp_lock, flags);
>  	rc =3D sclp_init_mask(1);

[Severity: High]
If sclp_init_mask(1) fails here and returns an error, the listener is remov=
ed
from sclp_reg_list and sclp_register() returns the error to the caller.

Since the listener was briefly in the active list, could a hardware interru=
pt
have started executing the callback concurrently?=20

If so, does this error path also need to call wait_for_completion(&reg->don=
e)
before returning? Otherwise, it looks like a concurrently executing callback
could call complete(&reg->done) on a freed structure if the caller frees the
listener after the registration failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804074511.2361=
53-1-egorenar@linux.ibm.com?part=3D2
