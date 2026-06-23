Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5F2010EE
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782234333; cv=none; b=OE0LhCUeT6q4h3dtobiFBXAJUj6avIyD9npsXUgDjOuI2qbAjq77hNiPKweYggufwZ6jxRMK7HOu70e0ioJMJ5SE8iM5UeDlzDYA5/owmCVOTyVBe0SFctssm6AE765mk5upaG/wrmUM0Jy9Z9MNeBj0MHegmZLxfAEfx0Uw1pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782234333; c=relaxed/simple;
	bh=2epXDHeJf6q0z8jH0pzDL5zSZUX5plnuCRFuAjmRHoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UaDnrzCwmVC8+jQBvRvkqGY+bULNrVHOYNMGi4NyczAB2gy0GhsTr03/6aw9eBZiRC6lwFsuV6Rn3byuIXpI1iaitP23c8ONqwcpXN8BUn9eWYUes+uHGrrJPdRVBrDtlPF7H6SXNXXNgwz2q+Luga9uj7sAaobLpLuQDhEckZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9RgsTxj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9RgsTxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DB51F000E9;
	Tue, 23 Jun 2026 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782234332;
	bh=plK9oNYkqr0oRbIDzYTeOqgj2IWmsi0dW7tjBxPlcJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b9RgsTxjpmT9WIBfCtwADAa2tqeWwkAaFb8v+6AbBqL94PDyIwQ/Wjh45FwXRw3RZ
	 ER61kSWzYMTtQI+ObdSsSEcpO91/4V8xEia6ldgWbK/qAJT34+CZl4HS+QIlzIe252
	 yJAjXkZGM2mGlE+k7kGtt4vn1e6ylSvBlYDgs6Azgb6tDZOMpww2VAcxZ5sNyqXGs8
	 KU8o7tneKLKt+svEprg+ZKO1C1NlPuTVBL+Z6opNJAgOgtoRmRjfEDEduwKgiPy1al
	 0+dp79fE/7HK7NvyP1/9HhuCZJT9nzQgsO4nfOLtD74DiQarQuOyL/123QNZMDyFLc
	 lIBFzss+VY6nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/monwriter: Reject buffer reuse with different data
 length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260623165700.3548070-1-gerald.schaefer@linux.ibm.com>
References: <20260623165700.3548070-1-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 17:05:31 +0000
Message-Id: <20260623170531.E6DB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The patch introduces an unconditional NULL pointer dereference=
 when processing a MONWRITE_STOP_INTERVAL record.

Pre-existing issues:
- [High] MONWRITE_GEN_EVENT buffers are not properly accounted for in the g=
lobal `mon_buf_count`, allowing an attacker to underflow the counter and by=
pass memory limits.
- [High] The global variable `mon_buf_count` is modified concurrently witho=
ut global synchronization, risking corrupted counts.
--

commit d2476036fa25e1db9629a0b3a14cc2e8ed5a7d79
Author: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

s390/monwriter: Reject buffer reuse with different data length

When data buffers are reused, e.g. for interval sample records, the
first record determines the data length, and the size of the buffer for
user copy. Current monwriter code does not check if the data length was
changed for subsequent records, which also would never happen for valid
user programs.

Cc: stable@vger.kernel.org

> diff --git a/drivers/s390/char/monwriter.c b/drivers/s390/char/monwriter.c
> index eaeb4a6384d1f..84e6deed49130 100644
> --- a/drivers/s390/char/monwriter.c
> +++ b/drivers/s390/char/monwriter.c
> @@ -123,6 +123,9 @@ static int monwrite_new_hdr(struct mon_private *monpr=
iv)
>  			kfree(monbuf);
>  			monbuf =3D NULL;
>  		}
> +		/* Data with buffer reuse must not change its length */
> +		if (monbuf->hdr.datalen !=3D monhdr->datalen)

[Severity: Critical]
Does this code cause a NULL pointer dereference?

If a user writes a valid MONWRITE_STOP_INTERVAL record, monbuf is freed and
set to NULL immediately prior to this check. Evaluating monbuf->hdr.datalen
here will unconditionally panic the kernel.

> +			return -EINVAL;
>  	} else if (monhdr->mon_function !=3D MONWRITE_STOP_INTERVAL) {
>  		if (mon_buf_count >=3D mon_max_bufs)

[Severity: High]
This is a pre-existing issue, but does this code allow an underflow of
mon_buf_count?

In monwrite_new_hdr(), if a user writes a MONWRITE_GEN_EVENT header:

monwrite_new_hdr()
    ...
    if (monhdr->mon_function !=3D MONWRITE_GEN_EVENT)
        mon_buf_count++;

the buffer is added to monpriv->list but mon_buf_count is not incremented.
If the user then skips writing the associated data and closes the file,
monwrite_close() will unconditionally decrement mon_buf_count for that
dangling buffer, underflowing the global limit counter to a negative
value and allowing a bypass of the mon_max_bufs limit.

[Severity: High]
This is also a pre-existing issue, but is the global mon_buf_count variable
safe from concurrent modifications?

It appears monwrite_close() decrements mon_buf_count while iterating over
monpriv->list without holding any global synchronization locks:

monwrite_close()
    ...
    list_for_each_entry_safe(entry, next, &monpriv->list, list) {
        ...
        mon_buf_count--;
    }

Similarly, monwrite_new_hdr() modifies it while holding only a per-file
instance thread_mutex. Can concurrent open, write, or close operations from
multiple processes corrupt the global count?

>  			return -ENOSPC;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623165700.3548=
070-1-gerald.schaefer@linux.ibm.com?part=3D1
