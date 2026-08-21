Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49473D331A
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302566; cv=none; b=OFNmy+8uszSCN60LhjBkUJSrEMWFE7gH4bcE7v3k9V+b4Gn1qNPUxIsmfQ0etv7zIxYzN5eAQeS7Wz3Zgsc8oiKklEQe+C0r375E83rEFAO3lHXZBsuYMt/xb58qAodn6JK5zQfkNTNoN9ORDYGGxswMgO/yeEc2i6UPZ6hy1Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302566; c=relaxed/simple;
	bh=E/S95yp/0PFb2+8e7PpXciFZ8HWG58ck1c2PS7Q/o+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WaAmIBlhcBHwUMux7ytFN7klOIhDHKLGeYgXoCp9wl6LydDJqGNY5vbPOcMTst+gm9v/B7cB80F4KTsQdkvYbaDOJ5XCnRIxaEfY0in2+tcajdPQweer9ZveIpm+Wj9ZFW536Vnugx92K7yacevIafBqA7u41zGWqepvORH5KHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohfu7apv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohfu7apv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017B71F000E9;
	Fri, 21 Aug 2026 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787302565;
	bh=/m2xOJM62H3oAUNnjexNBWTpB8Lqg5KWBfI+GMOhNLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ohfu7apvdpab3gRaBSDzFPtmE4x99eUK2uCiin18oF4XBlVzE46AOyVYCMIV0dTls
	 LU0H9ubfijdKtx1Hwm1UKjLMp7L4Gr2Su1e7EXpsznw1+sAxmJQQH7zxCD4V4KUTdE
	 O4kmgOd5Ounivn0oUNO44e51mfdkjU75jkCwzxCUvlMjTp97xi5f8l/ZFbBAooiswJ
	 AJfIj2shGwGl6I2z+dWYkKCufgs7W14PZS/hTwyu/eKuy2AlOerJE6I8oYHxjM4VLJ
	 1KjuVolflbQGZ8Vev+g5LJ9wVYUrRaXvGhcI0hs62nPIi85viEmQxQZSAslV2AGy6K
	 eo55ZuXQyJRiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/smc: do not credit bytes that splice() did not
 take
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hidayath Khan" <hidayath@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260820085543.967490-1-hidayath@linux.ibm.com>
References: <20260820085543.967490-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 08:56:04 +0000
Message-Id: <20260821085605.017B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Error paths and early exits during the second chunk of a wrapped r=
ead skip trailing socket state updates, causing data duplication and leakin=
g `bytes_to_rcv`.
- [High] The patch fails to handle a full pipe correctly, introducing dead =
code because `splice_to_pipe()` returns `-EAGAIN`, which is intercepted by =
the preexisting `rc < 0` handler and mapped to `-EFAULT`.
--

--- Patch [1]: [PATCH net] net/smc: do not credit bytes that splice() did n=
ot take ---
commit 13a906bee6c672b72e5c22c2fd7111bc713c0c62
Author: Hidayath Khan <hidayath@linux.ibm.com>

net/smc: do not credit bytes that splice() did not take

This patch modifies smc_rx_recvmsg() to account for the actual number of
bytes consumed by splice_to_pipe(). It prevents advancing the consumer curs=
or
when splice_to_pipe() takes less data than offered, and stops processing
if the pipe is full.

>     A pipe that is not empty is enough to hit this; SPLICE_F_NONBLOCK on a
>     full pipe produces the zero case.
>    =20
>     Account what splice_to_pipe() actually took, and stop there rather th=
an
>     continuing to the second chunk of a wrapped read. When it took nothin=
g,
>     return -EAGAIN instead of reporting a length that was not delivered.

Is this description accurate?

splice_to_pipe() natively returns -EAGAIN when the pipe is full and the call
is non-blocking. Since -EAGAIN is negative, it gets intercepted by the
pre-existing error handler which maps it to -EFAULT when read_done is 0.

Does this mean the zero-case handling added in this patch is unreachable?

> diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
> index 5c9e4d8b57de4..d951dbe8eec3c 100644
> --- a/net/smc/smc_rx.c
> +++ b/net/smc/smc_rx.c
> @@ -488,6 +488,24 @@ int smc_rx_recvmsg(struct smc_sock *smc, struct msgh=
dr *msg,
>  						read_done =3D -EFAULT;
>  					goto out;
>  				}

[Severity: High]
This isn't a bug introduced by this patch, but does this error handler
unintentionally map -EAGAIN to -EFAULT?

If smc_rx_splice() returns -EAGAIN on a full pipe, this block catches the
negative return value and changes it to -EFAULT when read_done is 0,
completely bypassing the new logic below.

> +				/* splice_to_pipe() takes only what the pipe
> +				 * has room for, which may be less than was
> +				 * offered, or nothing. Account what it took
> +				 * and stop: crediting the whole chunk would
> +				 * advance the consumer past data the reader
> +				 * never received.
> +				 */
> +				if (!msg && rc < chunk_len) {
> +					if (!rc) {
> +						if (!read_done)
> +							read_done =3D -EAGAIN;
> +						goto out;
> +					}

[Severity: High]
This is a pre-existing issue, but does using 'goto out' here skip trailing
socket state updates?

If a ring buffer wrap occurs requiring two chunks, and the first chunk is
successfully processed (read_done > 0), but the second chunk encounters an
error or returns 0, jumping to 'out' bypasses the batched cursor update:

net/smc/smc_rx.c:smc_rx_recvmsg() {
    ...
    /* update cursors */
    if (!(flags & MSG_PEEK)) {
        ...
        atomic_sub(copylen, &conn->bytes_to_rcv);
        ...
        if (msg && smc_rx_update_consumer(smc, cons, copylen))
            goto out;
    }
    ...
}

Does this leave the socket state permanently corrupted by leaking
bytes_to_rcv and duplicating data on the next read?

> +					copylen =3D chunk_len_sum - chunk_len + rc;
> +					read_remaining -=3D rc;
> +					read_done +=3D rc;
> +					break;
> +				}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820085543.9674=
90-1-hidayath@linux.ibm.com?part=3D1
