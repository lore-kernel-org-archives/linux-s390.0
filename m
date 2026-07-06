Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76C23C65FD
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324464; cv=none; b=qr6DUrFNJl3T7aFdyy5mvl5h8705yg2MsBCTKuG5JcL3yCOhZ5vbpDwnGAiI/oihyfJox7bUyCpAMNGuCVvtMPoLtLz81IGBQfkZSyXCD9+chGFgXVxIiRgGFNwgyujCiHiz/YVAhniGBypSixItSzVbL08J+EPW/ADCJz6SEY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324464; c=relaxed/simple;
	bh=yKI3Hz/fRI1OiDC9V2OC5BsZ4jVfh1cePIFVAAm+lG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CWG8hZL2wS1dTudeJcMs3lyuv4Y5qpyFYRN6Qu50OO2TuMWdXGp2yWXVP6jogiIM+phzYY3G5LK/1doBdB9kcE4KnPlyo/iirwSiS0woVh3ImbCfOly3rj7+PSBAUja0CqDcA07uo7b6kebSJ6962PtuLUAaV9ODSsT/neT+gC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEGrEGnL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEGrEGnL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848F81F00A3A;
	Mon,  6 Jul 2026 07:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783324456;
	bh=VfP5FrCwrEmqbJR+rVciYAFGXXb31Gxg34KLhP0EbnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bEGrEGnLweSrueFfHsmZhzdZv6HD6YYfY13rEdftvj+vSnREJQ4zrZZlF6Vcz3+9u
	 wx/mp2rkT6BCnlCoHqwZSvVyVVg4cc5hGQ0cKyKOhd+IjfN6OCBT3sUZ+JqyDwSGhl
	 B2TramFnE23dbq38/PlY+dGQPhYmb1XkA7pOKrdy3kPQet+TPUxNg1Fv6HrQw8QNiK
	 wcaZ0xkan/mTimh3MOnUEkywW7pb7gSUX4wOkBVyuEP2Xi0VtviKQc6loDz4e5jo75
	 /bQlyk+RX5nVgj1fUcJSIMjkWzodApicXvrDGOz5DfbQFBxCsw1DCl9UtDXD/tVM18
	 d+LftJV/go3mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 3/3] net/smc: bound the send length to the send
 buffer in smc_tx_sendmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260705-b4-disp-28a1bbca-v4-3-be089b98acc6@proton.me>
References: <20260705-b4-disp-28a1bbca-v4-0-be089b98acc6@proton.me>
 <20260705-b4-disp-28a1bbca-v4-3-be089b98acc6@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 07:54:16 +0000
Message-Id: <20260706075416.848F81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Partial write failure in `smc_tx_sendmsg` causes silent data loss =
and stream corruption.
--

commit 1bdb319d30163889b9beebc58c1c90f65092496b
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/smc: bound the send length to the send buffer in smc_tx_sendmsg()

This patch bounds the writespace to the send buffer length to prevent
an out-of-bounds write caused by a forged cursor. It ensures the
writespace is always properly bounded before starting the message copy.

> diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
> index 3144b4b1fe290..5916f02060fb9 100644
> --- a/net/smc/smc_tx.c
> +++ b/net/smc/smc_tx.c
> @@ -233,6 +233,19 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msgh=
dr *msg, size_t len)
>  		/* initialize variables for 1st iteration of subsequent loop */
>  		/* could be just 1 byte, even after smc_tx_wait above */
>  		writespace =3D atomic_read(&conn->sndbuf_space);
> +		/* sndbuf_space is advanced from the peer's wire-controlled
[ ... ]
> +		if (writespace < 0 || writespace > conn->sndbuf_desc->len)
> +			writespace =3D conn->sndbuf_desc->len;
>  		/* not more than what user space asked for */
>  		copylen =3D min_t(size_t, send_remaining, writespace);
>  		/* determine start of sndbuf */

[Severity: High]
This is a pre-existing issue, but does this error path cause silent data
loss?

If memcpy_from_msg() fails on the second iteration of the chunk loop,
send_done has already been incremented by the first chunk's length:

smc_tx_sendmsg() {
    ...
    for (chunk =3D 0; chunk < 2; chunk++) {
        rc =3D memcpy_from_msg(sndbuf_base + chunk_off,
                             msg, chunk_len);
        if (rc) {
            smc_sndbuf_sync_sg_for_device(conn);
            if (send_done)
                return send_done;
            goto out_err;
        }
        send_done +=3D chunk_len;
        ...
    }
    ...
    /* update cursors */
    smc_curs_add(conn->sndbuf_desc->len, &prep, copylen);
    smc_curs_copy(&conn->tx_curs_prep, &prep, conn);
    ...
}

By returning send_done early when a multi-chunk copy partially succeeds,
we skip the cursor updates. Userspace will believe the first chunk was
successfully written and advance its state, but the kernel will overwrite
those uncommitted bytes on the next sendmsg() call because the cursor
was never advanced.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-b4-disp-28=
a1bbca-v4-0-be089b98acc6@proton.me?part=3D3
